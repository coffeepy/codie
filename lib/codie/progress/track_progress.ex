defmodule Codie.Progress.TrackProgress do
  use Ecto.Schema
  import Ecto.Changeset

  schema "track_progress" do
    field :track_slug, :string
    field :status, :string, default: "locked"
    field :completion_percent, :float, default: 0.0

    belongs_to :profile, Codie.Progress.Profile

    timestamps(type: :utc_datetime)
  end

  def changeset(track_progress, attrs) do
    track_progress
    |> cast(attrs, [:profile_id, :track_slug, :status, :completion_percent])
    |> validate_required([:profile_id, :track_slug, :status, :completion_percent])
    |> unique_constraint(:track_slug, name: :track_progress_profile_id_track_slug_index)
  end
end
