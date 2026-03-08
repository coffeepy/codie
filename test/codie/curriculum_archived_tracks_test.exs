defmodule Codie.CurriculumArchivedTracksTest do
  use ExUnit.Case, async: true

  alias Codie.Curriculum

  test "active_tracks filters the archived foundations track from learner-facing lists" do
    active_slugs = Curriculum.active_tracks() |> Enum.map(& &1.slug)

    assert Curriculum.archived_track?("foundations-old")
    refute Curriculum.archived_track?("foundations")
    refute "foundations-old" in active_slugs
    assert "foundations" in active_slugs
  end

  test "active_tracks also filters track progress rows through the same helper" do
    rows = [%{track_slug: "foundations"}, %{track_slug: "foundations-old"}]

    assert Curriculum.active_tracks(rows) == [%{track_slug: "foundations"}]
  end
end
