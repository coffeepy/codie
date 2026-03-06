defmodule Codie.Progress.Unlock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "unlocks" do
    field :kind, :string
    field :key, :string
    field :granted_at, :utc_datetime

    belongs_to :profile, Codie.Progress.Profile

    timestamps(type: :utc_datetime)
  end

  def changeset(unlock, attrs) do
    unlock
    |> cast(attrs, [:profile_id, :kind, :key, :granted_at])
    |> validate_required([:profile_id, :kind, :key, :granted_at])
    |> unique_constraint(:key, name: :unlocks_profile_id_kind_key_index)
  end
end
