defmodule Codie.Progress.SubmissionRun do
  use Ecto.Schema
  import Ecto.Changeset

  schema "submission_runs" do
    field :lesson_slug, :string
    field :result, :string
    field :compile_output, :string
    field :test_output, :string
    field :runtime_ms, :integer
    field :status, :string

    belongs_to :profile, Codie.Progress.Profile

    timestamps(type: :utc_datetime)
  end

  def changeset(submission_run, attrs) do
    submission_run
    |> cast(attrs, [
      :profile_id,
      :lesson_slug,
      :result,
      :compile_output,
      :test_output,
      :runtime_ms,
      :status
    ])
    |> validate_required([:profile_id, :lesson_slug, :status])
  end
end
