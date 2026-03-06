defmodule CodieWeb.LessonLive do
  use CodieWeb, :live_view

  alias Codie.Curriculum
  alias Codie.Progress
  alias Codie.Runner
  alias Codie.Runner.Submission

  @hint_focus_cost 2

  @impl true
  def mount(_params, _session, socket) do
    profile =
      Progress.get_or_create_profile()
      |> Progress.apply_daily_decay_if_needed()

    {:ok,
     assign(socket,
       page_title: "Lesson",
       profile: profile,
       lesson: nil,
       available?: false,
       passed?: false,
       draft_code: "",
       editor_version: 0,
       active_run_id: nil,
       hint_index: 0,
       latest_result: nil,
       reward_result: nil,
       next_lesson: nil,
       next_lessons: [],
       run_state: :idle,
       progress_by_slug: %{},
       passed_slugs: []
     )}
  end

  @impl true
  def handle_params(%{"lesson_slug" => lesson_slug}, _uri, socket) do
    {:noreply, hydrate(socket, lesson_slug)}
  end

  @impl true
  def handle_event("save_draft", %{"code" => _code}, %{assigns: %{lesson: nil}} = socket) do
    {:noreply, socket}
  end

  def handle_event("save_draft", %{"code" => code}, socket) when is_binary(code) do
    {:ok, _} = Progress.save_draft(socket.assigns.profile, socket.assigns.lesson.slug, code)

    {:noreply, socket}
  end

  def handle_event("reset_starter", _params, socket) do
    {:ok, _} =
      Progress.save_draft(
        socket.assigns.profile,
        socket.assigns.lesson.slug,
        socket.assigns.lesson.starter_code
      )

    {:noreply,
     assign(socket,
       draft_code: socket.assigns.lesson.starter_code,
       editor_version: next_editor_version(socket),
       latest_result: nil,
       reward_result: nil
     )}
  end

  def handle_event("request_hint", _params, socket) do
    cond do
      socket.assigns.hint_index >= length(socket.assigns.lesson.hints) ->
        {:noreply, socket}

      true ->
        {:ok, profile} = Progress.spend_focus(socket.assigns.profile, @hint_focus_cost)

        {:noreply,
         assign(socket,
           profile: profile,
           hint_index: socket.assigns.hint_index + 1
         )}
    end
  end

  def handle_event(
        "run_submission",
        _params,
        %{assigns: %{available?: false, passed?: false}} = socket
      ) do
    {:noreply,
     put_flash(socket, :error, "This lesson is still locked. Clear earlier nodes first.")}
  end

  def handle_event("run_submission", _params, %{assigns: %{run_state: :running}} = socket) do
    {:noreply, socket}
  end

  def handle_event("run_submission", %{"submission" => %{"code" => code}}, socket)
      when is_binary(code) do
    attempt_number =
      socket.assigns.progress_by_slug
      |> Map.get(socket.assigns.lesson.slug, %{attempt_count: 0})
      |> Map.get(:attempt_count, 0)
      |> Kernel.+(1)

    run_id = System.unique_integer([:positive, :monotonic])
    parent = self()

    {:ok, _pid} =
      Task.Supervisor.start_child(Codie.Runner.TaskSupervisor, fn ->
        result =
          Runner.submit(%Submission{
            lesson_slug: socket.assigns.lesson.slug,
            code: code,
            profile_id: socket.assigns.profile.id,
            attempt_number: attempt_number
          })

        send(parent, {:run_submission_complete, run_id, code, result})
      end)

    {:noreply,
     assign(socket,
       draft_code: code,
       active_run_id: run_id,
       run_state: :running,
       latest_result: nil,
       reward_result: nil
     )}
  end

  def handle_event("run_submission", _params, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_info(
        {:run_submission_complete, run_id, code, result},
        %{assigns: %{active_run_id: run_id}} = socket
      ) do
    {:ok, _} =
      Progress.record_submission(socket.assigns.profile, socket.assigns.lesson, %{
        result: Atom.to_string(result.status),
        compile_output: result.compile_output,
        test_output: result.test_output,
        runtime_ms: result.runtime_ms,
        status: "completed",
        code: code
      })

    case result.status do
      :pass ->
        {:ok, profile, reward_result} =
          Progress.mark_lesson_passed(socket.assigns.profile, socket.assigns.lesson, code)

        {:noreply,
         socket
         |> assign(profile: profile)
         |> assign(active_run_id: nil)
         |> assign_result_state(result, reward_result)
         |> refresh_progress()}

      _ ->
        {:noreply,
         socket
         |> assign(active_run_id: nil)
         |> assign_result_state(result, nil)
         |> refresh_progress()}
    end
  end

  def handle_info({:run_submission_complete, _run_id, _code, _result}, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section class="lesson-shell">
      <div class="glass-panel lesson-brief">
        <div class="section-heading">
          <p class="eyebrow">
            {@lesson.track_slug |> String.replace("-", " ") |> String.capitalize()}
          </p>
          <h1>{@lesson.title}</h1>
        </div>
        <div class="mission-meta">
          <span class={
            status_pill_class(
              if(@passed?, do: "passed", else: if(@available?, do: "available", else: "locked"))
            )
          }>
            {if @passed?, do: "passed", else: if(@available?, do: "ready", else: "locked")}
          </span>
          <span>{tier_label(@lesson.tier)}</span>
          <span>{@lesson.estimated_minutes} min</span>
        </div>
        <p class="hero-text">{@lesson.summary}</p>
        <div class="lesson-copy">{parse_teaching_content(@lesson.teaching_markdown)}</div>

        <div :if={@lesson.quick_terms != []} class="hints-card">
          <div class="section-heading">
            <p class="eyebrow">Quick Terms</p>
            <h3>Tap to expand beginner context</h3>
          </div>
          <div class="quick-terms-list">
            <details :for={term <- @lesson.quick_terms} class="quick-term-card">
              <summary>{term.term}</summary>
              <p>{term.explanation}</p>
            </details>
          </div>
        </div>

        <div class="hints-card">
          <div class="section-heading">
            <p class="eyebrow">Success Criteria</p>
            <h3>What this lesson expects</h3>
          </div>
          <div class="checkpoint-list">
            <p :for={check <- @lesson.checks} class="checkpoint-line">
              {check.checkpoint || check.label}
            </p>
          </div>
        </div>

        <div class="hints-card">
          <div class="section-heading">
            <p class="eyebrow">Hints</p>
            <h3>Spend focus to reveal guidance</h3>
          </div>
          <p :for={hint <- Enum.take(@lesson.hints, @hint_index)} class="hint-line">{hint}</p>
          <button
            type="button"
            phx-click="request_hint"
            class="secondary-cta"
            disabled={@hint_index >= length(@lesson.hints)}
          >
            Reveal Hint (-{@hint_cost} focus)
          </button>
        </div>
      </div>

      <div class="glass-panel editor-panel">
        <div class="editor-topline">
          <div>
            <p class="eyebrow">Workspace</p>
            <h2>Type real Elixir</h2>
          </div>
          <span :if={@run_state == :running} class="status-pill status-progress">Checking...</span>
        </div>

        <.form
          for={%{}}
          as={:submission}
          phx-submit="run_submission"
          class="editor-shell"
        >
          <div
            id="lesson-editor"
            phx-hook="CodeEditor"
            class="code-editor-frame"
            data-editor-value={@draft_code}
            data-editor-version={@editor_version}
          >
            <textarea
              id="lesson-code-input"
              name="submission[code]"
              data-role="editor-input"
              class="editor-sync-input"
              tabindex="-1"
              aria-hidden="true"
              readonly
            ><%= @draft_code %></textarea>
            <div
              id="lesson-editor-surface"
              data-role="editor-surface"
              phx-update="ignore"
              class="code-editor-surface"
            >
            </div>
            <div
              id="lesson-editor-vim-status"
              data-role="vim-status"
              class="vim-status-bar"
              phx-update="ignore"
            >
            </div>
          </div>

          <div class="editor-actions">
            <button type="button" phx-click="reset_starter" class="secondary-cta">
              Reset Starter
            </button>
            <button type="submit" class="primary-cta" disabled={@run_state == :running}>
              Run Lesson
            </button>
          </div>
        </.form>

        <div :if={@latest_result} class={result_card_class(@latest_result.status)}>
          <div class="section-heading">
            <p class="eyebrow">Runner</p>
            <h3>{@latest_result.summary}</h3>
          </div>
          <p><strong>Status:</strong> {human_result(@latest_result.status)}</p>
          <p><strong>Compile:</strong> {@latest_result.compile_output}</p>
          <pre class="runner-log">{@latest_result.test_output}</pre>
          <p class="muted-copy">Runtime: {@latest_result.runtime_ms}ms</p>
        </div>

        <div :if={@reward_result} class="reward-banner">
          <h3>Lesson cleared</h3>
          <p>
            +{@reward_result.xp_gained} XP, +{@reward_result.coffee_gained} beans, +{@reward_result.stat_changes.energy} energy
          </p>
          <div :if={@next_lessons != []} class="reward-next-list">
            <p class="eyebrow">Linked Next Lessons</p>
            <.link
              :for={next <- @next_lessons}
              navigate={~p"/lesson/#{next.slug}"}
              class="secondary-cta"
            >
              Next: {next.title}
            </.link>
          </div>
          <.link
            :if={@next_lessons == [] && @next_lesson && @next_lesson.slug != @lesson.slug}
            navigate={~p"/lesson/#{@next_lesson.slug}"}
            class="secondary-cta"
          >
            Next Lesson
          </.link>
        </div>
      </div>
    </section>
    """
  end

  defp hydrate(socket, lesson_slug) do
    profile =
      Progress.get_or_create_profile()
      |> Progress.apply_daily_decay_if_needed()

    lesson = Curriculum.get_lesson!(lesson_slug)
    lesson_progress = Progress.list_lesson_progress(profile)
    progress_by_slug = Map.new(lesson_progress, &{&1.lesson_slug, &1})
    passed_slugs = Progress.passed_lesson_slugs(profile)
    lesson_status = lesson_status(progress_by_slug, passed_slugs, lesson)

    assign(socket,
      page_title: lesson.title,
      profile: profile,
      lesson: lesson,
      draft_code: Progress.draft_for(profile, lesson.slug, lesson.starter_code),
      editor_version: next_editor_version(socket),
      available?: lesson_status in ["available", "in_progress", "passed"],
      passed?: lesson_status == "passed",
      active_run_id: nil,
      hint_index: 0,
      latest_result: nil,
      reward_result: nil,
      next_lesson: Curriculum.next_lesson_for_profile(profile),
      next_lessons: next_lessons_for(profile, lesson),
      run_state: :idle,
      progress_by_slug: progress_by_slug,
      passed_slugs: passed_slugs,
      hint_cost: @hint_focus_cost
    )
  end

  defp assign_result_state(socket, result, reward_result) do
    assign(socket,
      latest_result: result,
      reward_result: reward_result,
      run_state: :complete,
      next_lesson: Curriculum.next_lesson_for_profile(socket.assigns.profile),
      next_lessons: next_lessons_for(socket.assigns.profile, socket.assigns.lesson)
    )
  end

  defp refresh_progress(socket) do
    lesson_progress = Progress.list_lesson_progress(socket.assigns.profile)
    progress_by_slug = Map.new(lesson_progress, &{&1.lesson_slug, &1})
    passed_slugs = Progress.passed_lesson_slugs(socket.assigns.profile)
    lesson_status = lesson_status(progress_by_slug, passed_slugs, socket.assigns.lesson)

    assign(socket,
      progress_by_slug: progress_by_slug,
      passed_slugs: passed_slugs,
      available?: lesson_status in ["available", "in_progress", "passed"],
      passed?: lesson_status == "passed"
    )
  end

  defp next_editor_version(socket) do
    socket.assigns
    |> Map.get(:editor_version, 0)
    |> Kernel.+(1)
  end

  defp parse_teaching_content(nil), do: ""

  defp parse_teaching_content(text) do
    text
    |> String.trim()
    |> String.split(~r/\n\s*\n/, trim: true)
    |> Enum.reduce([], fn block, acc ->
      lines = String.split(block, "\n", trim: true)

      case lines do
        [header | body] when body != [] ->
          if Regex.match?(~r/^[A-Za-z\s]+:\s*$/, header) do
            acc ++ [{:section, String.trim_trailing(header, ":") |> String.trim(), body}]
          else
            acc ++ [{:paragraph, lines}]
          end

        [single_line] ->
          if Regex.match?(~r/^[A-Za-z\s]+:\s*$/, single_line) do
            acc ++ [{:section, String.trim_trailing(single_line, ":") |> String.trim(), []}]
          else
            acc ++ [{:paragraph, [single_line]}]
          end

        _ ->
          acc ++ [{:paragraph, lines}]
      end
    end)
    |> render_blocks()
  end

  defp render_blocks(blocks) do
    html =
      Enum.map_join(blocks, "", fn
        {:section, header, body_lines} ->
          body_html = Enum.map_join(body_lines, "\n", &render_line/1)

          """
          <div class="teaching-section">
            <div class="teaching-header">#{Phoenix.HTML.html_escape(header) |> Phoenix.HTML.safe_to_string()}</div>
            <div class="teaching-body">#{body_html}</div>
          </div>
          """

        {:paragraph, lines} ->
          body_html = Enum.map_join(lines, "\n", &render_line/1)

          """
          <div class="teaching-section">
            <div class="teaching-body">#{body_html}</div>
          </div>
          """
      end)

    Phoenix.HTML.raw(html)
  end

  defp render_line(line) do
    trimmed = String.trim(line)

    if String.starts_with?(trimmed, "`") and String.ends_with?(trimmed, "`") and
         byte_size(trimmed) > 2 do
      code_content =
        trimmed
        |> String.trim_leading("`")
        |> String.trim_trailing("`")
        |> Phoenix.HTML.html_escape()
        |> Phoenix.HTML.safe_to_string()

      ~s(<div class="code-line"><code>#{code_content}</code></div>)
    else
      render_inline_code(line)
    end
  end

  defp render_inline_code(line) do
    Regex.split(~r/(`[^`]+`)/, line, include_captures: true)
    |> Enum.map_join("", fn part ->
      if String.starts_with?(part, "`") and String.ends_with?(part, "`") do
        code =
          part
          |> String.trim_leading("`")
          |> String.trim_trailing("`")
          |> Phoenix.HTML.html_escape()
          |> Phoenix.HTML.safe_to_string()

        "<code>#{code}</code>"
      else
        Phoenix.HTML.html_escape(part) |> Phoenix.HTML.safe_to_string()
      end
    end)
  end

  defp next_lessons_for(profile, lesson) do
    linked_unpassed = Curriculum.linked_next_lessons(profile, lesson.slug)

    cond do
      linked_unpassed != [] ->
        linked_unpassed

      true ->
        linked_any = Curriculum.linked_next_lessons(profile, lesson.slug, include_passed: true)

        cond do
          linked_any != [] ->
            linked_any

          true ->
            case Curriculum.next_lesson_in_track(lesson.slug) do
              nil -> []
              next -> [next]
            end
        end
    end
  end
end
