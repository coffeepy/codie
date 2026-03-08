defmodule CodieWeb.TrackMapLive do
  use CodieWeb, :live_view

  alias Codie.Curriculum
  alias Codie.Progress

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"track_slug" => track_slug}, _uri, socket) do
    {:noreply, route_track(socket, track_slug)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section class="glass-panel track-hero">
      <div>
        <p class="eyebrow">Campaign Zone</p>
        <h1>{@track.title}</h1>
        <p class="hero-text">{@track.summary}</p>
      </div>
      <div class="track-hero-meta">
        <span class={status_pill_class(@track_row.status)}>{@track_row.status}</span>
        <strong>{Float.round(@track_row.completion_percent, 1)}%</strong>
      </div>
    </section>

    <section :if={@lessons == []} class="glass-panel">
      <p class="eyebrow">Locked Sector</p>
      <h2>Content scaffolded, not authored yet</h2>
      <p class="hero-text">{@track.teaser}</p>
      <.link navigate={~p"/learn/foundations"} class="secondary-cta">Back to Foundations</.link>
    </section>

    <section :if={@lessons != []} class="track-grid">
      <div
        :for={{lesson, index} <- Enum.with_index(@lessons)}
        class={["lesson-node", lesson_status(@progress_by_slug, @passed_slugs, lesson)]}
      >
        <div class="node-topline">
          <span class="node-index">#{index + 1}</span>
          <span class={status_pill_class(lesson_status(@progress_by_slug, @passed_slugs, lesson))}>
            {lesson_status(@progress_by_slug, @passed_slugs, lesson)}
          </span>
        </div>
        <h3>{lesson.title}</h3>
        <p>{lesson.summary}</p>
        <div class="mission-meta">
          <span>{tier_label(lesson.tier)}</span>
          <span>{lesson.estimated_minutes} min</span>
        </div>
        <.link
          :if={lesson_status(@progress_by_slug, @passed_slugs, lesson) != "locked"}
          navigate={~p"/lesson/#{lesson.slug}"}
          class="secondary-cta"
        >
          Open Lesson
        </.link>
        <span
          :if={lesson_status(@progress_by_slug, @passed_slugs, lesson) == "locked"}
          class="muted-copy"
        >
          Clear earlier lessons to unlock.
        </span>
      </div>
    </section>
    """
  end

  defp hydrate(socket, track_slug) do
    profile =
      Progress.get_or_create_profile()
      |> Progress.apply_daily_decay_if_needed()

    track = Curriculum.get_track!(track_slug)
    lesson_progress = Progress.list_lesson_progress(profile)
    progress_by_slug = Map.new(lesson_progress, &{&1.lesson_slug, &1})
    track_row = Enum.find(Progress.list_track_progress(profile), &(&1.track_slug == track_slug))

    assign(socket,
      page_title: "#{track.title} Map",
      profile: profile,
      track: track,
      lessons: Curriculum.list_lessons(track_slug),
      progress_by_slug: progress_by_slug,
      passed_slugs: Progress.passed_lesson_slugs(profile),
      track_row: track_row || %{status: "locked", completion_percent: 0.0}
    )
  end

  defp route_track(socket, track_slug) do
    if Curriculum.archived_track?(track_slug) do
      socket
      |> put_flash(
        :info,
        "Foundations (Legacy) is archived. Returning to the active foundations track."
      )
      |> push_navigate(to: ~p"/learn/foundations")
    else
      hydrate(socket, track_slug)
    end
  end
end
