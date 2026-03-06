defmodule Codie.Progress.DailyStateEvent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "daily_state_events" do
    field :event_type, :string
    field :payload, :map

    belongs_to :profile, Codie.Progress.Profile

    timestamps(type: :utc_datetime)
  end

  def changeset(daily_state_event, attrs) do
    daily_state_event
    |> cast(attrs, [:profile_id, :event_type, :payload])
    |> validate_required([:profile_id, :event_type, :payload])
  end
end
