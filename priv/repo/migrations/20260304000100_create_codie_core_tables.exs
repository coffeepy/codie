defmodule Codie.Repo.Migrations.CreateCodieCoreTables do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :name, :string, null: false, default: "Player One"
      add :avatar_seed, :string, null: false, default: "bean"
      add :current_track_slug, :string, null: false, default: "foundations"
      add :current_lesson_slug, :string, null: false, default: "wake_codie"
      add :xp, :integer, null: false, default: 0
      add :level, :integer, null: false, default: 1
      add :coffee_beans, :integer, null: false, default: 0
      add :energy, :integer, null: false, default: 72
      add :focus, :integer, null: false, default: 68
      add :mood, :integer, null: false, default: 64
      add :caffeine, :integer, null: false, default: 0
      add :streak_days, :integer, null: false, default: 0
      add :last_practiced_on, :date
      add :last_decay_applied_on, :date
      add :timezone, :string, null: false, default: "Etc/UTC"

      timestamps(type: :utc_datetime)
    end

    create table(:track_progress) do
      add :profile_id, references(:profiles, on_delete: :delete_all), null: false
      add :track_slug, :string, null: false
      add :status, :string, null: false, default: "locked"
      add :completion_percent, :float, null: false, default: 0.0

      timestamps(type: :utc_datetime)
    end

    create unique_index(:track_progress, [:profile_id, :track_slug])

    create table(:lesson_progress) do
      add :profile_id, references(:profiles, on_delete: :delete_all), null: false
      add :lesson_slug, :string, null: false
      add :track_slug, :string, null: false
      add :status, :string, null: false, default: "locked"
      add :attempt_count, :integer, null: false, default: 0
      add :best_result, :string
      add :last_submitted_code, :text
      add :first_passed_at, :utc_datetime
      add :last_attempted_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end

    create unique_index(:lesson_progress, [:profile_id, :lesson_slug])

    create table(:submission_runs) do
      add :profile_id, references(:profiles, on_delete: :delete_all), null: false
      add :lesson_slug, :string, null: false
      add :result, :string
      add :compile_output, :text
      add :test_output, :text
      add :runtime_ms, :integer
      add :status, :string, null: false, default: "completed"

      timestamps(type: :utc_datetime)
    end

    create index(:submission_runs, [:profile_id, :inserted_at])

    create table(:unlocks) do
      add :profile_id, references(:profiles, on_delete: :delete_all), null: false
      add :kind, :string, null: false
      add :key, :string, null: false
      add :granted_at, :utc_datetime, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:unlocks, [:profile_id, :kind, :key])

    create table(:daily_state_events) do
      add :profile_id, references(:profiles, on_delete: :delete_all), null: false
      add :event_type, :string, null: false
      add :payload, :map, null: false, default: %{}

      timestamps(type: :utc_datetime)
    end
  end
end
