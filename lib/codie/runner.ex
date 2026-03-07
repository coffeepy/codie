defmodule Codie.Runner do
  @moduledoc """
  Validates learner submissions by parsing, evaluating, and checking results.
  """

  alias Codie.Curriculum
  alias Codie.Curriculum.Check
  alias Codie.Runner.{Result, Submission}

  @timeout_ms 4_000
  @blocked_tokens [
    "System.cmd",
    "File.write",
    "File.rm",
    "Port.open",
    "Node.connect",
    ":os.cmd",
    "Code.eval_string",
    "Code.compile_string",
    "Task.start",
    "spawn("
  ]

  def submit(%Submission{} = submission), do: run_sync(submission)

  def run_sync(%Submission{} = submission) do
    lesson = Curriculum.get_lesson!(submission.lesson_slug)
    reward_preview = Codie.Game.preview_rewards(nil, lesson)
    started_at = System.monotonic_time(:millisecond)

    with :ok <- reject_if_unsafe(submission.code),
         {:ok, ast} <- parse(submission.code),
         {:ok, execution} <- execute(submission.code, ast) do
      check_result = run_checks(lesson.checks, execution)
      purge_modules(execution.modules)

      case check_result do
        :ok ->
          %Result{
            status: :pass,
            compile_output: "Compiled cleanly.",
            test_output: "Every lesson check passed.",
            returned_value: format_return_value(execution.value),
            runtime_ms: elapsed(started_at),
            summary: "Nice work. Codie stays caffeinated.",
            annotations: [],
            reward_preview: reward_preview
          }

        {:error, :failed_check, check} ->
          %Result{
            status: :fail_test,
            compile_output: "The code compiled, but a lesson check failed.",
            test_output: check.failure_message,
            returned_value: format_return_value(execution.value),
            runtime_ms: elapsed(started_at),
            summary: "Close, but one of the lesson checks still failed.",
            annotations: [check.label],
            reward_preview: reward_preview
          }
      end
    else
      {:error, :rejected_submission, message} ->
        %Result{
          status: :rejected_submission,
          compile_output: message,
          test_output: "Submissions run locally, so obviously risky APIs are blocked.",
          returned_value: nil,
          runtime_ms: elapsed(started_at),
          summary: "That code uses APIs that are blocked in Codie.",
          annotations: [message],
          reward_preview: reward_preview
        }

      {:error, :parse, error} ->
        %Result{
          status: :fail_compile,
          compile_output: error,
          test_output: "Fix the syntax issue and try again.",
          returned_value: nil,
          runtime_ms: elapsed(started_at),
          summary: "Elixir could not parse the submission.",
          annotations: [error],
          reward_preview: reward_preview
        }

      {:error, :runtime, error} ->
        %Result{
          status: :runtime_error,
          compile_output: "Code compiled, but raised during execution.",
          test_output: error,
          returned_value: nil,
          runtime_ms: elapsed(started_at),
          summary: "The code ran, but crashed before it satisfied the lesson.",
          annotations: [error],
          reward_preview: reward_preview
        }

      {:error, :timeout, message} ->
        %Result{
          status: :timeout,
          compile_output: "The submission exceeded the lesson time limit.",
          test_output: message,
          returned_value: nil,
          runtime_ms: @timeout_ms,
          summary: "That run took too long.",
          annotations: [message],
          reward_preview: reward_preview
        }

      {:error, :runner, message} ->
        %Result{
          status: :runner_error,
          compile_output: "The runner hit an internal error.",
          test_output: message,
          returned_value: nil,
          runtime_ms: elapsed(started_at),
          summary: "Codie's checker tripped on its own shoelaces.",
          annotations: [message],
          reward_preview: reward_preview
        }
    end
  rescue
    error ->
      %Result{
        status: :runner_error,
        compile_output: "Unexpected runner failure.",
        test_output: Exception.message(error),
        returned_value: nil,
        runtime_ms: 0,
        summary: "Codie's runner crashed unexpectedly.",
        annotations: [Exception.message(error)],
        reward_preview: nil
      }
  end

  def build_harness(lesson, code) do
    %{lesson: lesson, code: code}
  end

  def normalize_result(%Result{} = result), do: result

  defp format_return_value(value) do
    inspect(value, pretty: true, limit: :infinity, printable_limit: :infinity)
  end

  defp reject_if_unsafe(code) do
    case Enum.find(@blocked_tokens, &String.contains?(code, &1)) do
      nil -> :ok
      token -> {:error, :rejected_submission, "Blocked token detected: #{token}"}
    end
  end

  defp parse(code) do
    case Code.string_to_quoted(code, file: "submission.exs") do
      {:ok, ast} ->
        {:ok, ast}

      {:error, {line, error, token}} ->
        {:error, :parse, "Line #{line}: #{to_string(error)} near #{inspect(token)}"}
    end
  rescue
    error ->
      {:error, :parse, Exception.message(error)}
  end

  defp execute(code, ast) do
    modules = defined_modules(ast)

    try do
      task =
        Task.Supervisor.async_nolink(Codie.Runner.TaskSupervisor, fn ->
          output =
            ExUnit.CaptureIO.capture_io(fn ->
              try do
                case Code.eval_string(code, [], file: "submission.exs") do
                  {value, binding} ->
                    Process.put(:codie_execution, {:ok, value, binding})
                end
              rescue
                error ->
                  Process.put(
                    :codie_execution,
                    {:error, Exception.format(:error, error, __STACKTRACE__)}
                  )
              end
            end)

          {Process.get(:codie_execution), output, Macro.to_string(ast), modules}
        end)

      outcome =
        case Task.yield(task, @timeout_ms) || Task.shutdown(task, :brutal_kill) do
          {:ok, {{:ok, value, binding}, output, ast_string, returned_modules}} ->
            {:ok,
             %{
               source: code,
               value: value,
               binding: binding,
               output: output,
               ast_string: ast_string,
               modules: returned_modules
             }}

          {:ok, {{:error, message}, _output, _ast_string, returned_modules}} ->
            {:error, :runtime, message, returned_modules}

          nil ->
            {:error, :timeout, "Submission exceeded #{@timeout_ms}ms.", modules}
        end

      case outcome do
        {:ok, execution} ->
          {:ok, execution}

        {:error, reason, message, modules_to_purge} ->
          purge_modules(modules_to_purge)
          {:error, reason, message}
      end
    rescue
      error ->
        purge_modules(modules)
        {:error, :runner, Exception.format(:error, error, __STACKTRACE__)}
    end
  end

  defp run_checks(checks, execution) do
    Enum.reduce_while(checks, :ok, fn %Check{} = check, :ok ->
      case check_passes?(check, execution) do
        true -> {:cont, :ok}
        false -> {:halt, {:error, :failed_check, check}}
      end
    end)
  end

  defp check_passes?(%Check{type: :returns, config: %{expected: expected}}, execution) do
    execution.value == expected
  end

  defp check_passes?(
         %Check{type: :binds, config: %{variable: variable, expected: expected}},
         execution
       ) do
    Keyword.get(execution.binding, variable) == expected
  end

  defp check_passes?(%Check{type: :ast_contains, config: %{snippet: snippet}}, execution) do
    String.contains?(execution.ast_string, snippet)
  end

  defp check_passes?(%Check{type: :source_contains, config: %{snippet: snippet}}, execution) do
    String.contains?(strip_whitespace(execution.source), strip_whitespace(snippet))
  end

  defp check_passes?(
         %Check{
           type: :module_function,
           config: %{module: module, function: function_name, args: args, expected: expected}
         },
         _execution
       ) do
    Code.ensure_loaded?(module) and function_exported?(module, function_name, length(args)) and
      apply(module, function_name, args) == expected
  rescue
    _ -> false
  end

  defp check_passes?(_check, _execution), do: false

  defp defined_modules(ast) do
    {_, modules} =
      Macro.prewalk(ast, [], fn
        {:defmodule, _, [{:__aliases__, _, parts}, _]} = node, acc ->
          module = Module.concat(parts)
          {node, [module | acc]}

        node, acc ->
          {node, acc}
      end)

    Enum.uniq(modules)
  end

  defp purge_modules(modules) do
    Enum.each(modules, fn module ->
      :code.purge(module)
      :code.delete(module)
    end)
  end

  defp elapsed(started_at), do: System.monotonic_time(:millisecond) - started_at

  defp strip_whitespace(value) do
    value
    |> String.replace(~r/\s+/, "")
  end
end
