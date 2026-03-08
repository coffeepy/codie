defmodule CodieWeb.CodieAvatarBoardTest do
  use ExUnit.Case, async: true

  alias CodieWeb.CodieAvatarBoard

  test "exports board geometry and frame map for the Codie avatar sheet" do
    board = CodieAvatarBoard.board()
    export = CodieAvatarBoard.export()

    assert board.board_id == "codie-avatar-board"
    assert board.asset_path == "/images/characters/codie/avatar-expression-board.png"
    assert board.map_path == "/images/characters/codie/avatar-expression-board.json"
    assert board.columns == 8
    assert board.rows == 4
    assert board.cell_size == %{width: 364, height: 360}

    assert get_in(export, ["grid", "columns"]) == 8
    assert get_in(export, ["grid", "rows"]) == 4
    assert length(export["frames"]) == 32
    assert Enum.at(export["frames"], 0)["emotion"] == "neutral"
    assert Enum.at(export["frames"], 31)["emotion"] == "satisfied_after_sip"
  end

  test "maps live app states onto specific Codie emotions" do
    assert CodieAvatarBoard.state(:default).sprite == "slight_smile"
    assert CodieAvatarBoard.state(:default).tone == "warm"
    assert CodieAvatarBoard.state(:fatigue_building).sprite == "bored"
    assert CodieAvatarBoard.state(:fatigue_building).tone == "violet"
    assert CodieAvatarBoard.state(:hint_used).frame == {1, 3}
    assert CodieAvatarBoard.state(:hint_used).tone == "gold"
    assert CodieAvatarBoard.state(:caffeine_gain).emotion == :happily_lifting_coffee_mug
    assert CodieAvatarBoard.state(:caffeine_gain).transient?
    assert CodieAvatarBoard.state(:lesson_passed).emotion == :proud
    assert CodieAvatarBoard.state(:mistake_or_failed_run).sprite == "worried"
    assert CodieAvatarBoard.state(:low_caffeine).frame == {7, 2}
    assert CodieAvatarBoard.state(:low_caffeine).tone == "violet"
    assert CodieAvatarBoard.state(:low_energy_or_low_mood).sprite == "tired"
  end
end
