defmodule Codie.Curriculum.Lesson do
  @enforce_keys [
    :slug,
    :title,
    :track_slug,
    :tier,
    :summary,
    :teaching_markdown,
    :starter_code,
    :checks,
    :hints,
    :rewards,
    :prerequisites,
    :estimated_minutes,
    :codex_entries_unlocked
  ]

  defstruct [
    :slug,
    :title,
    :track_slug,
    :tier,
    :summary,
    :teaching_markdown,
    :starter_code,
    :solution_template,
    :checks,
    :hints,
    :rewards,
    :prerequisites,
    :estimated_minutes,
    :codex_entries_unlocked,
    :quick_terms
  ]
end
