defmodule CodieWeb.AppHelpers do
  alias Codie.Curriculum

  def meter_width(value) when is_number(value) do
    "#{value |> round() |> max(0) |> min(100)}%"
  end

  def lesson_status(progress_by_slug, passed_slugs, lesson) do
    case Map.get(progress_by_slug, lesson.slug) do
      %{status: "passed"} ->
        "passed"

      %{status: "in_progress"} ->
        "in_progress"

      _ ->
        if(Curriculum.lesson_available?(passed_slugs, lesson.slug),
          do: "available",
          else: "locked"
        )
    end
  end

  def status_pill_class("passed"), do: "status-pill status-passed"
  def status_pill_class("available"), do: "status-pill status-available"
  def status_pill_class("in_progress"), do: "status-pill status-progress"
  def status_pill_class("completed"), do: "status-pill status-passed"
  def status_pill_class(_), do: "status-pill status-locked"

  def result_card_class(:pass), do: "result-card result-pass"
  def result_card_class("pass"), do: "result-card result-pass"
  def result_card_class(:fail_test), do: "result-card result-warn"
  def result_card_class("fail_test"), do: "result-card result-warn"
  def result_card_class(:fail_compile), do: "result-card result-warn"
  def result_card_class("fail_compile"), do: "result-card result-warn"
  def result_card_class(:runner_error), do: "result-card result-danger"
  def result_card_class("runner_error"), do: "result-card result-danger"
  def result_card_class(:runtime_error), do: "result-card result-danger"
  def result_card_class("runtime_error"), do: "result-card result-danger"
  def result_card_class(:rejected_submission), do: "result-card result-danger"
  def result_card_class("rejected_submission"), do: "result-card result-danger"
  def result_card_class(:timeout), do: "result-card result-danger"
  def result_card_class("timeout"), do: "result-card result-danger"
  def result_card_class(_), do: "result-card"

  def result_status_pill_class(:pass), do: "status-pill status-passed"
  def result_status_pill_class("pass"), do: "status-pill status-passed"
  def result_status_pill_class(:fail_test), do: "status-pill status-progress"
  def result_status_pill_class("fail_test"), do: "status-pill status-progress"
  def result_status_pill_class(:fail_compile), do: "status-pill status-progress"
  def result_status_pill_class("fail_compile"), do: "status-pill status-progress"
  def result_status_pill_class(:runtime_error), do: "status-pill status-danger"
  def result_status_pill_class("runtime_error"), do: "status-pill status-danger"
  def result_status_pill_class(:timeout), do: "status-pill status-danger"
  def result_status_pill_class("timeout"), do: "status-pill status-danger"
  def result_status_pill_class(:rejected_submission), do: "status-pill status-danger"
  def result_status_pill_class("rejected_submission"), do: "status-pill status-danger"
  def result_status_pill_class(:runner_error), do: "status-pill status-danger"
  def result_status_pill_class("runner_error"), do: "status-pill status-danger"
  def result_status_pill_class(_), do: "status-pill status-locked"

  def human_result(nil), do: "No attempts yet"
  def human_result(:pass), do: "Passed"
  def human_result("pass"), do: "Passed"
  def human_result(:fail_test), do: "Check failed"
  def human_result("fail_test"), do: "Check failed"
  def human_result(:fail_compile), do: "Compile issue"
  def human_result("fail_compile"), do: "Compile issue"
  def human_result(:runtime_error), do: "Runtime error"
  def human_result("runtime_error"), do: "Runtime error"
  def human_result(:timeout), do: "Timed out"
  def human_result("timeout"), do: "Timed out"
  def human_result(:rejected_submission), do: "Blocked API"
  def human_result("rejected_submission"), do: "Blocked API"
  def human_result(:runner_error), do: "Runner issue"
  def human_result("runner_error"), do: "Runner issue"

  def human_result(other),
    do: other |> to_string() |> String.replace("_", " ") |> String.capitalize()

  def signed_amount(value) when is_number(value) and value > 0, do: "+#{value}"
  def signed_amount(value) when is_number(value), do: "#{value}"

  def tier_label(:boss), do: "Boss"
  def tier_label(_), do: "Lesson"
end
