defmodule CodieWeb.LessonCompanion do
  use CodieWeb, :html

  alias CodieWeb.CodieAvatarBoard

  def companion(profile, latest_result \\ nil, reward_result \\ nil, trigger \\ nil) do
    build_companion(profile, latest_result, reward_result, trigger, :rail)
  end

  def companion(profile, latest_result, reward_result, trigger, placement) do
    build_companion(profile, latest_result, reward_result, trigger, placement)
  end

  attr :profile, :map, default: nil
  attr :latest_result, :map, default: nil
  attr :reward_result, :map, default: nil
  attr :trigger, :atom, default: nil
  attr :reaction_token, :integer, default: 0
  attr :placement, :atom, default: :rail
  attr :show_pop, :boolean, default: true
  attr :dom_id, :string, default: "lesson-workspace"

  def lesson_companion(assigns) do
    assigns =
      assign(
        assigns,
        :companion,
        companion(
          assigns.profile,
          assigns.latest_result,
          assigns.reward_result,
          assigns.trigger,
          assigns.placement
        )
      )

    ~H"""
    <aside
      id={"#{@dom_id}-companion"}
      class={[
        "lesson-workspace-companion",
        @companion.transient? && @show_pop && "is-transient",
        @placement == :reward && "is-reward-anchored",
        @placement == :feedback && "is-feedback-anchored"
      ]}
      data-companion-character={@companion.character}
      data-companion-placement={Atom.to_string(@placement)}
      data-companion-reaction-token={@reaction_token}
      data-companion-state={@companion.state}
      data-board-id={@companion.board_id}
      data-board-asset={@companion.asset_path}
      data-board-map={@companion.map_path}
      data-codie-state={@companion.state}
      data-codie-tone={@companion.tone}
      data-codie-emotion={@companion.emotion}
      data-codie-sprite={@companion.sprite}
    >
      <div :if={@show_pop && @companion.transient?} class="lesson-workspace-companion-pop">
        <p class="eyebrow">{@companion.label}</p>
        <h3>{@companion.headline}</h3>
        <p>{@companion.message}</p>
      </div>

      <div class="lesson-workspace-board-shell">
        <div class="lesson-workspace-board-glow"></div>
        <div
          id={"#{@dom_id}-board"}
          class="lesson-workspace-board-frame"
          role="img"
          aria-label={@companion.aria_label}
        >
          <div
            :if={rem(@reaction_token, 2) == 0}
            id={"#{@dom_id}-board-sprite-even"}
            class="lesson-workspace-board-sprite"
            style={@companion.sprite_style}
          >
          </div>
          <div
            :if={rem(@reaction_token, 2) == 1}
            id={"#{@dom_id}-board-sprite-odd"}
            class="lesson-workspace-board-sprite"
            style={@companion.sprite_style}
          >
          </div>
        </div>
        <p class="lesson-workspace-board-caption">{@companion.caption}</p>
      </div>
    </aside>
    """
  end

  defp build_companion(profile, latest_result, reward_result, trigger, placement) do
    board = CodieAvatarBoard.board()
    state = active_state(profile, reward_result, trigger, placement)
    state_data = Map.fetch!(board.states, state)

    %{
      character: "codie",
      state: Atom.to_string(state),
      tone: state_data.tone,
      emotion: Atom.to_string(state_data.emotion),
      sprite: state_data.sprite,
      label: state_data.label,
      headline: state_data.headline,
      message: state_message(state, latest_result, state_data.message),
      caption: state_data.caption,
      transient?: state_data.transient?,
      board_id: board.board_id,
      asset_path: board.asset_path,
      map_path: board.map_path,
      aria_label: "Codie board state #{state_data.caption}",
      sprite_style: sprite_style(board, state, state_data.frame)
    }
  end

  defp active_state(_profile, %{stat_changes: %{caffeine: caffeine_gain}}, _trigger, _placement)
       when caffeine_gain > 0,
       do: :caffeine_gain

  defp active_state(_profile, %{stat_changes: %{caffeine: caffeine_gain}}, _trigger, :reward)
       when caffeine_gain <= 0,
       do: :lesson_passed

  defp active_state(_profile, _reward_result, :caffeine_gain, _placement), do: :caffeine_gain
  defp active_state(_profile, _reward_result, :hint_used, _placement), do: :hint_used
  defp active_state(_profile, _reward_result, :lesson_passed, _placement), do: :lesson_passed

  defp active_state(_profile, _reward_result, :mistake_or_failed_run, _placement),
    do: :mistake_or_failed_run

  defp active_state(nil, _reward_result, _trigger, _placement), do: :default

  defp active_state(profile, _reward_result, _trigger, _placement) do
    cond do
      profile.energy <= 25 or profile.mood <= 30 -> :low_energy_or_low_mood
      profile.caffeine <= 10 -> :low_caffeine
      profile.energy <= 42 or profile.mood <= 48 or profile.caffeine <= 28 -> :fatigue_building
      true -> :default
    end
  end

  defp state_message(:mistake_or_failed_run, latest_result, default_message) do
    case Map.get(latest_result || %{}, :status) do
      value when value in [:fail_compile, "fail_compile"] ->
        "Codie clocks the compile issue immediately and points you back at the broken line."

      value when value in [:runtime_error, "runtime_error", :runner_error, "runner_error"] ->
        "Codie winces at the blown-up run and waits for the next safer pass."

      _ ->
        default_message
    end
  end

  defp state_message(_state, _latest_result, default_message), do: default_message

  defp sprite_style(board, :default, frame) do
    sprite_style_with_loop(board, frame, [
      {"happy-smile", :slight_smile},
      {"happy-hold", :happy},
      {"happy-sip", :amused_smirk},
      {"happy-satisfied", :relieved}
    ])
  end

  defp sprite_style(board, :low_caffeine, frame) do
    sprite_style_with_loop(board, frame, [
      {"tired", :tired},
      {"sleepy-yawning", :sleepy_yawning},
      {"sad", :sad}
    ])
  end

  defp sprite_style(board, :fatigue_building, frame) do
    sprite_style_with_loop(board, frame, [
      {"fatigue-bored", :bored},
      {"fatigue-sad", :sad},
      {"fatigue-tired", :tired}
    ])
  end

  defp sprite_style(board, :low_energy_or_low_mood, frame) do
    sprite_style_with_loop(board, frame, [
      {"deep-tired", :tired},
      {"deep-sad", :sad},
      {"deep-yawn", :sleepy_yawning}
    ])
  end

  defp sprite_style(board, :caffeine_gain, frame) do
    sprite_style_with_loop(board, frame, [
      {"coffee-pop-hold", :happily_lifting_coffee_mug},
      {"coffee-pop-lift", :happily_sipping_coffee},
      {"coffee-pop-sip", :satisfied_after_sip},
      {"coffee-pop-finish", :happy}
    ])
  end

  defp sprite_style(board, :lesson_passed, frame) do
    sprite_style_with_loop(board, frame, [
      {"pass-grin", :happy},
      {"pass-laugh", :amused_smirk},
      {"pass-proud", :proud},
      {"pass-relief", :relieved}
    ])
  end

  defp sprite_style(board, :mistake_or_failed_run, frame) do
    sprite_style_with_loop(board, frame, [
      {"worry-worried", :worried},
      {"worry-anxious", :anxious_nervous},
      {"worry-confused", :confused},
      {"worry-reset", :worried}
    ])
  end

  defp sprite_style(board, _state, frame), do: base_sprite_style(board, frame) |> Enum.join("; ")

  defp sprite_style_with_loop(board, frame, loop_frames) do
    base_sprite_style(board, frame)
    |> Kernel.++(
      Enum.map(loop_frames, fn {loop_name, emotion} ->
        "--codie-loop-#{loop_name}: #{background_position(board, emotion_frame(board, emotion))}"
      end)
    )
    |> Enum.join("; ")
  end

  defp base_sprite_style(board, frame) do
    [
      "background-image: url('#{board.asset_path}')",
      "background-repeat: no-repeat",
      "background-size: #{board.columns * 100}% #{board.rows * 100}%",
      "background-position: #{background_position(board, frame)}"
    ]
  end

  defp emotion_frame(board, emotion),
    do: board.emotion_map |> Map.fetch!(emotion) |> Map.fetch!(:frame)

  defp background_position(board, {column, row}) do
    "#{position_percent(column, board.columns)} #{position_percent(row, board.rows)}"
  end

  defp position_percent(_index, 1), do: "0%"
  defp position_percent(index, count), do: "#{index * 100 / (count - 1)}%"
end
