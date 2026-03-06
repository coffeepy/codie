defmodule Codie.Progress.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profiles" do
    field :name, :string, default: "Player One"
    field :avatar_seed, :string, default: "bean"
    field :current_track_slug, :string, default: "foundations"
    field :current_lesson_slug, :string, default: "string-shelf"
    field :xp, :integer, default: 0
    field :level, :integer, default: 1
    field :coffee_beans, :integer, default: 0
    field :energy, :integer, default: 72
    field :focus, :integer, default: 68
    field :mood, :integer, default: 64
    field :caffeine, :integer, default: 0
    field :streak_days, :integer, default: 0
    field :last_practiced_on, :date
    field :last_decay_applied_on, :date
    field :timezone, :string, default: "Etc/UTC"

    timestamps(type: :utc_datetime)
  end

  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [
      :name,
      :avatar_seed,
      :current_track_slug,
      :current_lesson_slug,
      :xp,
      :level,
      :coffee_beans,
      :energy,
      :focus,
      :mood,
      :caffeine,
      :streak_days,
      :last_practiced_on,
      :last_decay_applied_on,
      :timezone
    ])
    |> validate_required([
      :name,
      :avatar_seed,
      :current_track_slug,
      :current_lesson_slug,
      :xp,
      :level,
      :coffee_beans,
      :energy,
      :focus,
      :mood,
      :caffeine,
      :streak_days,
      :timezone
    ])
  end
end
