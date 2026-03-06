defmodule Codie.Progress.LessonProgress do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lesson_progress" do
    field :lesson_slug, :string
    field :track_slug, :string
    field :status, :string, default: "locked"
    field :attempt_count, :integer, default: 0
    field :best_result, :string
    field :last_submitted_code, :string
    field :first_passed_at, :utc_datetime
    field :last_attempted_at, :utc_datetime

    belongs_to :profile, Codie.Progress.Profile

    timestamps(type: :utc_datetime)
  end

  def changeset(lesson_progress, attrs) do
    lesson_progress
    |> cast(attrs, [
      :profile_id,
      :lesson_slug,
      :track_slug,
      :status,
      :attempt_count,
      :best_result,
      :last_submitted_code,
      :first_passed_at,
      :last_attempted_at
    ])
    |> validate_required([:profile_id, :lesson_slug, :track_slug, :status, :attempt_count])
    |> unique_constraint(:lesson_slug, name: :lesson_progress_profile_id_lesson_slug_index)
  end
end
