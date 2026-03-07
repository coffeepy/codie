defmodule CodieWeb.CodieAvatarBoard do
  @moduledoc false

  @board_id "codie-avatar-board"
  @asset_path "/images/characters/codie/avatar-expression-board.png"
  @map_path "/images/characters/codie/avatar-expression-board.json"
  @columns 8
  @rows 4
  @source_width 2912
  @source_height 1440

  @emotion_rows [
    [:neutral, :slight_smile, :happy, :joyful_grin, :laughing, :amused_smirk, :proud, :relieved],
    [:sad, :teary_crying, :worried, :anxious_nervous, :scared, :shocked, :confused, :skeptical],
    [
      :angry,
      :annoyed,
      :frustrated,
      :disgusted,
      :determined,
      :focused_concentrating,
      :tired,
      :sleepy_yawning
    ],
    [
      :embarrassed_blushing,
      :curious,
      :awe_positive_surprise,
      :bored,
      :happily_holding_coffee_mug,
      :happily_lifting_coffee_mug,
      :happily_sipping_coffee,
      :satisfied_after_sip
    ]
  ]

  @frames (for {row_emotions, row} <- Enum.with_index(@emotion_rows),
               {emotion, column} <- Enum.with_index(row_emotions) do
             sprite = Atom.to_string(emotion)

             %{
               index: row * @columns + column,
               emotion: emotion,
               sprite: sprite,
               caption:
                 emotion |> Atom.to_string() |> String.replace("_", " ") |> String.capitalize(),
               column: column,
               row: row
             }
           end)

  @emotion_map Map.new(@frames, fn frame ->
                 {frame.emotion,
                  %{
                    emotion: frame.emotion,
                    sprite: frame.sprite,
                    frame: {frame.column, frame.row},
                    caption: frame.caption
                  }}
               end)

  @app_state_map %{
    default: :slight_smile,
    fatigue_building: :bored,
    hint_used: :curious,
    caffeine_gain: :happily_lifting_coffee_mug,
    lesson_passed: :joyful_grin,
    mistake_or_failed_run: :worried,
    low_caffeine: :sleepy_yawning,
    low_energy_or_low_mood: :tired
  }

  @state_copy %{
    default: %{
      tone: "warm",
      label: "On shift",
      headline: "Ready to pair",
      message: "Codie keeps watch from the lesson corner while you work.",
      transient?: false
    },
    fatigue_building: %{
      tone: "violet",
      label: "Energy dip",
      headline: "Losing a little steam",
      message:
        "Codie starts cycling through a softer droop before tipping all the way into the tired end of the board.",
      transient?: false
    },
    hint_used: %{
      tone: "gold",
      label: "Pairing mode",
      headline: "Hint incoming",
      message: "Codie leans in with a curious look and nudges you toward the next clue.",
      transient?: true
    },
    caffeine_gain: %{
      tone: "gold",
      label: "Fresh sip",
      headline: "Caffeine gained",
      message:
        "Codie grabs the mug for a quick pick-me-up, then settles back into the current groove.",
      transient?: true
    },
    lesson_passed: %{
      tone: "mint",
      label: "Fresh pour",
      headline: "Lesson cleared",
      message: "Codie lights up for the win, then settles back into the workflow.",
      transient?: true
    },
    mistake_or_failed_run: %{
      tone: "blue",
      label: "Rubber duck mode",
      headline: "Patch in progress",
      message: "Codie stays on the current issue until you edit or retry the run.",
      transient?: false
    },
    low_caffeine: %{
      tone: "violet",
      label: "Low caffeine",
      headline: "Coffee is wearing off",
      message: "No urgent event is active, so Codie starts drifting into a sleepy yawn.",
      transient?: false
    },
    low_energy_or_low_mood: %{
      tone: "rose",
      label: "Energy dip",
      headline: "Running on fumes",
      message:
        "With energy or mood running low, Codie settles into a tired expression until the next small win.",
      transient?: false
    }
  }

  def board do
    %{
      board_id: @board_id,
      asset_path: @asset_path,
      map_path: @map_path,
      columns: @columns,
      rows: @rows,
      source_size: %{width: @source_width, height: @source_height},
      cell_size: %{width: div(@source_width, @columns), height: div(@source_height, @rows)},
      emotion_map: emotion_map(),
      app_state_map: app_state_map(),
      states: states()
    }
  end

  def states do
    Map.new(@app_state_map, fn {state, emotion} ->
      {state, Map.merge(Map.fetch!(@state_copy, state), Map.fetch!(@emotion_map, emotion))}
    end)
  end

  def state(state), do: Map.fetch!(states(), state)
  def emotion_map, do: @emotion_map
  def app_state_map, do: @app_state_map

  def export do
    %{
      "board_id" => @board_id,
      "asset_path" => @asset_path,
      "map_path" => @map_path,
      "source_size" => %{"width" => @source_width, "height" => @source_height},
      "grid" => %{"columns" => @columns, "rows" => @rows},
      "cell_size" => %{
        "width" => div(@source_width, @columns),
        "height" => div(@source_height, @rows)
      },
      "frames" =>
        Enum.map(@frames, fn frame ->
          %{
            "index" => frame.index,
            "emotion" => Atom.to_string(frame.emotion),
            "sprite" => frame.sprite,
            "caption" => frame.caption,
            "column" => frame.column,
            "row" => frame.row
          }
        end),
      "app_state_map" =>
        Map.new(@app_state_map, fn {state, emotion} ->
          emotion_data = Map.fetch!(@emotion_map, emotion)
          state_data = Map.fetch!(@state_copy, state)
          {column, row} = emotion_data.frame

          {Atom.to_string(state),
           %{
             "emotion" => Atom.to_string(emotion),
             "sprite" => emotion_data.sprite,
             "caption" => emotion_data.caption,
             "column" => column,
             "row" => row,
             "tone" => state_data.tone,
             "label" => state_data.label,
             "headline" => state_data.headline,
             "message" => state_data.message,
             "transient" => state_data.transient?
           }}
        end)
    }
  end
end
