defmodule CodieWeb.LessonLiveTest do
  use CodieWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Codie.Curriculum
  alias Codie.Progress
  alias Codie.Progress.Profile
  alias Codie.Repo

  setup do
    profile = Progress.get_or_create_profile()
    {:ok, _profile} = Progress.reset_all_progress(profile)
    :ok
  end

  test "autosave keeps the editor version stable and reset starter bumps it", %{conn: conn} do
    lesson = Curriculum.get_lesson!("wake_codie")

    {:ok, view, html} = live(conn, ~p"/lesson/#{lesson.slug}")

    assert html =~ ~s(data-editor-version="1")
    assert has_element?(view, ".lesson-workspace-layout[data-layout-mode='overlay']")

    assert has_element?(
             view,
             ".lesson-workspace-layout[data-layout-mode='overlay'] #lesson-workspace-companion"
           )

    render_hook(view, "save_draft", %{code: ~S|"espresso"|})

    profile = Progress.get_or_create_profile()

    assert Progress.draft_for(profile, lesson.slug, "") == ~S|"espresso"|
    assert render(view) =~ ~s(data-editor-version="1")

    render_click(view, "reset_starter")

    assert render(view) =~ ~s(data-editor-version="2")
    assert Progress.draft_for(profile, lesson.slug, "") == lesson.starter_code
  end

  test "submitting a valid caffeine reward keeps the coffee celebration scoped to the reward banner",
       %{
         conn: conn
       } do
    profile = Progress.get_or_create_profile()
    lesson = Curriculum.get_lesson!("wake_codie")

    {:ok, _} =
      Progress.spend_focus(profile, profile.focus - 18)

    {:ok, view, _html} = live(conn, ~p"/lesson/#{lesson.slug}")

    html =
      view
      |> form(".editor-shell", %{submission: %{code: ~S|"coffee"|}})
      |> render_submit()

    assert html =~ "Checking..."
    assert eventually(fn -> render(view) =~ "Lesson cleared" end)
    assert render(view) =~ "Every lesson check passed."
    assert has_element?(view, "#lesson-run-feedback")

    assert has_element?(
             view,
             "#lesson-reward-banner #lesson-reward-companion[data-companion-placement='reward'][data-board-id='codie-avatar-board'][data-board-asset='/images/characters/codie/avatar-expression-board.png'][data-board-map='/images/characters/codie/avatar-expression-board.json']"
           )

    refute has_element?(view, "#lesson-reward-banner .lesson-workspace-companion-pop")
    assert has_element?(view, "#lesson-caffeine-spotlight", "Coffee reward")
    assert has_element?(view, "#lesson-caffeine-spotlight", "+2 caffeine")

    assert has_element?(view, "#lesson-result-card")
    assert has_element?(view, "#lesson-result-returned", ~S|"coffee"|)
    assert has_element?(view, "#lesson-reward-banner")
    assert has_element?(view, "#lesson-result-card .runner-meta-card", "Passed")
    assert has_element?(view, "#lesson-reward-banner .reward-stat-grid")
    assert has_element?(view, "#lesson-reward-banner .reward-stat-card", "XP")
    assert has_element?(view, "#lesson-reward-banner .reward-actions .secondary-cta")

    assert eventually(fn ->
             has_element?(
               view,
               "#lesson-reward-banner #lesson-reward-companion[data-companion-placement='reward'][data-codie-state='caffeine_gain'][data-codie-tone='gold'][data-codie-emotion='happily_lifting_coffee_mug'][data-codie-sprite='happily_lifting_coffee_mug']"
             )
           end)

    assert has_element?(
             view,
             "#lesson-reward-banner #lesson-reward-board .lesson-workspace-board-sprite[style*='--codie-loop-coffee-pop-hold:'][style*='--codie-loop-coffee-pop-lift:'][style*='--codie-loop-coffee-pop-sip:'][style*='--codie-loop-coffee-pop-finish:']"
           )

    assert eventually(fn ->
             Regex.match?(~r/data-companion-reaction-token="[1-9][0-9]*"/, render(view)) and
               (has_element?(view, "#lesson-reward-board-sprite-odd") or
                  has_element?(view, "#lesson-reward-board-sprite-even"))
           end)

    refute has_element?(view, ".lesson-workspace-rail #lesson-workspace-companion")

    assert has_element?(view, "#lesson-reward-banner")
    assert has_element?(view, "#lesson-reward-banner .reward-actions .secondary-cta")

    assert has_element?(
             view,
             "#lesson-reward-banner #lesson-reward-companion[data-companion-placement='reward'][data-codie-state='caffeine_gain'][data-codie-tone='gold'][data-codie-emotion='happily_lifting_coffee_mug'][data-codie-sprite='happily_lifting_coffee_mug']"
           )

    assert eventually(
             fn ->
               has_element?(view, "#lesson-reward-banner") and
                 has_element?(view, "#lesson-reward-banner .reward-actions .secondary-cta") and
                 has_element?(
                   view,
                   "#lesson-reward-banner #lesson-reward-companion[data-companion-placement='reward'][data-codie-state='caffeine_gain'][data-codie-tone='gold'][data-codie-emotion='happily_lifting_coffee_mug'][data-codie-sprite='happily_lifting_coffee_mug']"
                 )
             end,
             60
           )
  end

  test "re-passing an already cleared lesson keeps a single non-caffeine success companion in the reward banner",
       %{conn: conn} do
    profile = Progress.get_or_create_profile()
    lesson = Curriculum.get_lesson!("wake_codie")

    {:ok, _profile, _reward_result} = Progress.mark_lesson_passed(profile, lesson, ~S|"coffee"|)

    {:ok, view, _html} = live(conn, ~p"/lesson/#{lesson.slug}")

    html =
      view
      |> form(".editor-shell", %{submission: %{code: ~S|"coffee"|}})
      |> render_submit()

    assert html =~ "Checking..."

    assert eventually(fn ->
             has_element?(
               view,
               "#lesson-reward-banner #lesson-reward-companion[data-companion-placement='reward'][data-codie-state='lesson_passed'][data-codie-tone='mint'][data-codie-emotion='proud'][data-codie-sprite='proud']"
             )
           end)

    assert has_element?(view, "#lesson-reward-banner")
    assert has_element?(view, "#lesson-reward-banner #lesson-reward-companion")
    refute has_element?(view, "#lesson-reward-banner .lesson-workspace-companion-pop")

    refute has_element?(view, ".lesson-workspace-rail #lesson-workspace-companion")

    assert has_element?(
             view,
             "#lesson-reward-board .lesson-workspace-board-sprite[style*='--codie-loop-pass-grin:'][style*='--codie-loop-pass-laugh:'][style*='--codie-loop-pass-proud:'][style*='--codie-loop-pass-relief:']"
           )
  end

  test "requesting a hint maps Codie to the helpful sprite, then settles back to happy idle", %{
    conn: conn
  } do
    profile = Progress.get_or_create_profile()
    lesson = Curriculum.get_lesson!("wake_codie")

    profile
    |> Profile.changeset(%{energy: 82, focus: 78, mood: 80, caffeine: 76})
    |> Repo.update!()

    {:ok, view, _html} = live(conn, ~p"/lesson/#{lesson.slug}")

    assert has_element?(
             view,
             "#lesson-workspace-companion[data-codie-state='default'][data-codie-tone='warm'][data-codie-emotion='slight_smile'][data-codie-sprite='slight_smile']"
           )

    assert has_element?(
             view,
             "#lesson-workspace-board .lesson-workspace-board-sprite[style*='--codie-loop-happy-smile:'][style*='--codie-loop-happy-hold:'][style*='--codie-loop-happy-sip:'][style*='--codie-loop-happy-satisfied:']"
           )

    view
    |> element("button[phx-click='request_hint']")
    |> render_click()

    assert has_element?(
             view,
             "#lesson-workspace-companion[data-codie-state='hint_used'][data-codie-tone='gold'][data-codie-emotion='curious'][data-codie-sprite='curious']"
           )

    assert eventually(fn ->
             has_element?(
               view,
               "#lesson-workspace-companion[data-codie-state='default'][data-codie-tone='warm'][data-codie-emotion='slight_smile'][data-codie-sprite='slight_smile']"
             )
           end)
  end

  test "failed runs keep Codie on the issue, surface the missed payout, and settle after editing",
       %{conn: conn} do
    profile = Progress.get_or_create_profile()
    lesson = Curriculum.get_lesson!("wake_codie")

    profile
    |> Profile.changeset(%{energy: 18, focus: 62, mood: 61, caffeine: 12})
    |> Repo.update!()

    {:ok, view, _html} = live(conn, ~p"/lesson/#{lesson.slug}")

    assert has_element?(
             view,
             "#lesson-workspace-companion[data-codie-state='low_energy_or_low_mood'][data-codie-tone='rose'][data-codie-emotion='tired'][data-codie-sprite='tired']"
           )

    view
    |> form(".editor-shell", %{submission: %{code: "def"}})
    |> render_submit()

    assert eventually(fn -> has_element?(view, "#lesson-result-card") end)
    assert has_element?(view, "#lesson-failure-banner")
    assert has_element?(view, "#lesson-failure-banner .reward-stat-card", "XP at stake")
    refute has_element?(view, "#lesson-failure-banner .lesson-workspace-companion-pop")
    refute has_element?(view, "#lesson-workspace-companion .lesson-workspace-companion-pop")

    assert eventually(fn ->
             has_element?(
               view,
               "#lesson-workspace-companion[data-codie-state='mistake_or_failed_run'][data-codie-tone='blue'][data-codie-emotion='worried'][data-codie-sprite='worried']"
             )
           end)

    assert has_element?(
             view,
             "#lesson-failure-banner #lesson-failure-companion[data-companion-placement='feedback'][data-codie-state='mistake_or_failed_run'][data-codie-tone='blue'][data-codie-emotion='worried'][data-codie-sprite='worried']"
           )

    assert has_element?(
             view,
             "#lesson-failure-banner #lesson-failure-board .lesson-workspace-board-sprite[style*='--codie-loop-worry-worried:'][style*='--codie-loop-worry-anxious:'][style*='--codie-loop-worry-confused:'][style*='--codie-loop-worry-reset:']"
           )

    refute eventually(
             fn ->
               has_element?(
                 view,
                 "#lesson-workspace-companion[data-codie-state='low_energy_or_low_mood'][data-codie-tone='rose'][data-codie-emotion='tired'][data-codie-sprite='tired']"
               )
             end,
             60
           )

    render_hook(view, "save_draft", %{code: "defp"})

    refute has_element?(view, "#lesson-failure-companion")

    assert eventually(fn ->
             has_element?(
               view,
               "#lesson-workspace-companion[data-codie-state='low_energy_or_low_mood'][data-codie-tone='rose'][data-codie-emotion='tired'][data-codie-sprite='tired']"
             )
           end)

    assert has_element?(
             view,
             "#lesson-workspace-board .lesson-workspace-board-sprite[style*='--codie-loop-deep-tired:'][style*='--codie-loop-deep-sad:'][style*='--codie-loop-deep-yawn:']"
           )
  end

  test "moderate stat dips keep Codie on the intermediate fatigue loop", %{conn: conn} do
    profile = Progress.get_or_create_profile()
    lesson = Curriculum.get_lesson!("wake_codie")

    profile
    |> Profile.changeset(%{energy: 40, focus: 74, mood: 72, caffeine: 26})
    |> Repo.update!()

    {:ok, view, _html} = live(conn, ~p"/lesson/#{lesson.slug}")

    assert has_element?(
             view,
             "#lesson-workspace-companion[data-codie-state='fatigue_building'][data-codie-tone='violet'][data-codie-emotion='bored'][data-codie-sprite='bored']"
           )

    assert has_element?(
             view,
             "#lesson-workspace-board .lesson-workspace-board-sprite[style*='--codie-loop-fatigue-bored:'][style*='--codie-loop-fatigue-sad:'][style*='--codie-loop-fatigue-tired:']"
           )
  end

  test "low caffeine keeps Codie on a sleepy board loop without affecting other states", %{
    conn: conn
  } do
    profile = Progress.get_or_create_profile()
    lesson = Curriculum.get_lesson!("wake_codie")

    profile
    |> Profile.changeset(%{energy: 79, focus: 74, mood: 76, caffeine: 8})
    |> Repo.update!()

    {:ok, view, _html} = live(conn, ~p"/lesson/#{lesson.slug}")

    assert has_element?(
             view,
             "#lesson-workspace-companion[data-codie-state='low_caffeine'][data-codie-tone='violet'][data-codie-emotion='sleepy_yawning'][data-codie-sprite='sleepy_yawning']"
           )

    assert has_element?(
             view,
             "#lesson-workspace-board .lesson-workspace-board-sprite[style*='--codie-loop-tired:'][style*='--codie-loop-sleepy-yawning:'][style*='--codie-loop-sad:']"
           )
  end

  test "passing a lesson shows linked next lessons when available", %{conn: conn} do
    lesson = Curriculum.get_lesson!("string-shelf")

    {:ok, view, _html} = live(conn, ~p"/lesson/#{lesson.slug}")

    view
    |> form(".editor-shell", %{submission: %{code: ~S|"coffee"|}})
    |> render_submit()

    assert eventually(fn ->
             html = render(view)

             html =~ "Lesson cleared" and html =~ "Linked Next Lessons" and
               html =~ "Next: String Blend"
           end)
  end

  test "review mode keeps next navigation on linked lessons even when child is already passed", %{
    conn: conn
  } do
    profile = Progress.get_or_create_profile()
    string_shelf = Curriculum.get_lesson!("string-shelf")
    string_blend = Curriculum.get_lesson!("string-blend")

    {:ok, _} = Progress.save_draft(profile, string_shelf.slug, ~S|"coffee"|)

    {:ok, _} =
      Progress.record_submission(profile, string_shelf, %{
        result: "pass",
        compile_output: "Compiled cleanly.",
        test_output: "Every lesson check passed.",
        runtime_ms: 5,
        status: "completed",
        code: ~S|"coffee"|
      })

    {:ok, profile, _} = Progress.mark_lesson_passed(profile, string_shelf, ~S|"coffee"|)

    {:ok, _} = Progress.save_draft(profile, string_blend.slug, ~S|base = "coffee"
base <> " beans"|)

    {:ok, _} =
      Progress.record_submission(profile, string_blend, %{
        result: "pass",
        compile_output: "Compiled cleanly.",
        test_output: "Every lesson check passed.",
        runtime_ms: 5,
        status: "completed",
        code: ~S|base = "coffee"
base <> " beans"|
      })

    {:ok, _profile, _} =
      Progress.mark_lesson_passed(profile, string_blend, ~S|base = "coffee"
base <> " beans"|)

    {:ok, view, _html} = live(conn, ~p"/lesson/#{string_shelf.slug}")

    view
    |> form(".editor-shell", %{submission: %{code: ~S|"coffee"|}})
    |> render_submit()

    assert eventually(fn ->
             html = render(view)
             html =~ "Linked Next Lessons" and html =~ "Next: String Blend"
           end)
  end

  test "renders quick terms for lessons that define beginner context", %{conn: conn} do
    lesson = Curriculum.get_lesson!("list-supplies")

    {:ok, _view, html} = live(conn, ~p"/lesson/#{lesson.slug}")

    assert html =~ "Quick Terms"
    assert html =~ "List"
    assert html =~ "Linked list"
  end

  defp eventually(fun, attempts \\ 80)

  defp eventually(fun, attempts) when attempts > 0 do
    if fun.() do
      true
    else
      Process.sleep(25)
      eventually(fun, attempts - 1)
    end
  end

  defp eventually(_fun, 0), do: false
end
