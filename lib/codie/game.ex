defmodule Codie.Game do
  @moduledoc """
  Progression and stat math for Codie's game loop.
  """

  alias Codie.Curriculum.Lesson
  alias Codie.Curriculum.Reward
  alias Codie.Progress.Profile

  defmodule RewardResult do
    @enforce_keys [:xp_gained, :coffee_gained, :stat_changes, :unlocks]
    defstruct [:xp_gained, :coffee_gained, :stat_changes, :unlocks]
  end

  @max_stat 100

  def level_for_xp(xp) when is_integer(xp) and xp >= 0 do
    div(xp, 120) + 1
  end

  def preview_rewards(_profile, %Lesson{rewards: %Reward{} = reward}) do
    reward_result(reward, [])
  end

  def grant_rewards(profile, %Lesson{} = lesson) do
    preview_rewards(profile, lesson)
  end

  def apply_daily_decay(_profile, missed_days) when missed_days <= 0 do
    %{energy: 0, focus: 0, mood: 0, caffeine: 0}
  end

  def apply_daily_decay(_profile, missed_days) do
    extra = max(missed_days - 1, 0)

    %{
      energy: -min(10 + extra * 5, 25),
      focus: -min(5 + extra * 4, 18),
      mood: -min(4 + extra * 3, 14),
      caffeine: -min(extra, 3)
    }
  end

  def apply_stat_delta(%Profile{} = profile, deltas, extras \\ %{}) do
    new_xp = profile.xp + Map.get(extras, :xp, 0)
    new_coffee = profile.coffee_beans + Map.get(extras, :coffee_beans, 0)

    %{
      xp: new_xp,
      level: level_for_xp(new_xp),
      coffee_beans: max(new_coffee, 0),
      energy: clamp(profile.energy + Map.get(deltas, :energy, 0)),
      focus: clamp(profile.focus + Map.get(deltas, :focus, 0)),
      mood: clamp(profile.mood + Map.get(deltas, :mood, 0)),
      caffeine: clamp(profile.caffeine + Map.get(deltas, :caffeine, 0))
    }
  end

  defp reward_result(%Reward{} = reward, unlocks) do
    %RewardResult{
      xp_gained: reward.xp,
      coffee_gained: reward.coffee,
      stat_changes: %{
        energy: reward.energy,
        focus: reward.focus,
        mood: reward.mood,
        caffeine: reward.caffeine
      },
      unlocks: unlocks
    }
  end

  defp clamp(value), do: value |> max(0) |> min(@max_stat)
end
