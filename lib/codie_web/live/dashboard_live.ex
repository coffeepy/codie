defmodule CodieWeb.DashboardLive do
  use CodieWeb, :live_view

  alias Codie.Curriculum
  alias Codie.Progress
  alias CodieWeb.LessonCompanion

  @impl true
  def mount(_params, _session, socket) do
    {:ok, hydrate(socket)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section class="hero-grid">
      <div class="glass-panel hero-copy">
        <p class="eyebrow">Codie // Daily Build</p>
        <h1>Learn Elixir like it's a character-building RPG.</h1>
        <p class="hero-text">
          Codie is your tiny digital developer. Keep him focused, caffeinated, and steadily stronger by finishing real Elixir lessons that compile and pass.
        </p>
        <div class="hero-actions">
          <.link navigate={~p"/lesson/#{@next_lesson.slug}"} class="primary-cta">
            Continue: {@next_lesson.title}
          </.link>
          <.link navigate={~p"/learn/foundations"} class="secondary-cta">
            Open World Map
          </.link>
        </div>
      </div>

      <div class="glass-panel codie-card" data-codie-tone={@current_companion.tone}>
        <div class="codie-card-header">
          <div class="codie-avatar-board-shell">
            <div
              id="dashboard-current-companion"
              class="codie-avatar-board"
              data-codie-state={@current_companion.state}
              data-codie-tone={@current_companion.tone}
              data-codie-emotion={@current_companion.emotion}
              data-codie-sprite={@current_companion.sprite}
            >
              <div class="codie-avatar-board-glow"></div>
              <div
                class="codie-avatar-board-frame"
                role="img"
                aria-label={@current_companion.aria_label}
              >
                <div class="codie-avatar-board-sprite" style={@current_companion.sprite_style}></div>
              </div>
            </div>
            <p id="dashboard-current-companion-caption" class="codie-avatar-board-caption">
              {@current_companion.caption}
            </p>
          </div>
          <div class="codie-card-copy">
            <p class="eyebrow">Current Companion</p>
            <div class="codie-card-title-row">
              <h2>Codie</h2>
              <span class="codie-tone-pill">{@current_companion.label}</span>
            </div>
            <p class="codie-subtitle">{@current_companion.headline}</p>
            <p class="codie-status-copy">{@current_companion.message}</p>
          </div>
        </div>
        <div class="stats-grid">
          <div class="stat-card">
            <span>Energy</span>
            <strong>{@profile.energy}</strong>
            <div class="meter"><span style={"width: #{meter_width(@profile.energy)}"}></span></div>
          </div>
          <div class="stat-card">
            <span>Focus</span>
            <strong>{@profile.focus}</strong>
            <div class="meter"><span style={"width: #{meter_width(@profile.focus)}"}></span></div>
          </div>
          <div class="stat-card">
            <span>Mood</span>
            <strong>{@profile.mood}</strong>
            <div class="meter"><span style={"width: #{meter_width(@profile.mood)}"}></span></div>
          </div>
          <div class="stat-card">
            <span>Caffeine</span>
            <strong>{@profile.caffeine}</strong>
            <div class="meter"><span style={"width: #{meter_width(@profile.caffeine)}"}></span></div>
          </div>
        </div>
      </div>
    </section>

    <section class="dashboard-grid">
      <div class="glass-panel mission-panel">
        <div class="section-heading">
          <p class="eyebrow">Today's Quest</p>
          <h3>{@next_lesson.title}</h3>
        </div>
        <p>{@next_lesson.summary}</p>
        <div class="mission-meta">
          <span class={status_pill_class("available")}>Ready</span>
          <span>{@next_lesson.estimated_minutes} min</span>
          <span>{tier_label(@next_lesson.tier)}</span>
        </div>
        <pre class="mini-code">{@next_lesson.starter_code}</pre>
      </div>

      <div class="glass-panel">
        <div class="section-heading">
          <p class="eyebrow">Campaign Progress</p>
          <h3>Road to Expert</h3>
        </div>
        <div class="track-stack">
          <div :for={track <- @track_progress} class="track-row">
            <div>
              <.link navigate={~p"/learn/#{track.track_slug}"}>
                <strong>{track_title(@track_titles, track.track_slug)}</strong>
              </.link>
              <p>{Float.round(track.completion_percent, 1)}% complete</p>
            </div>
            <span class={status_pill_class(track.status)}>{track.status}</span>
          </div>
        </div>
      </div>

      <div class="glass-panel">
        <div class="section-heading">
          <p class="eyebrow">Recent Attempts</p>
          <h3>How the lab is going</h3>
        </div>
        <div class="attempt-feed">
          <p :if={@recent_runs == []} class="muted-copy">
            No submissions yet. Run the first lesson to start Codie's shift.
          </p>
          <div :for={run <- @recent_runs} class="attempt-row">
            <div>
              <strong>{run.lesson_slug |> String.replace("-", " ") |> String.capitalize()}</strong>
              <p>{human_result(run.result)}</p>
            </div>
            <span>{run.runtime_ms || 0}ms</span>
          </div>
        </div>
      </div>
    </section>
    """
  end

  defp hydrate(socket) do
    snapshot =
      Progress.get_or_create_profile()
      |> Progress.dashboard_snapshot()

    assign(socket,
      page_title: "Dashboard",
      profile: snapshot.profile,
      current_companion: LessonCompanion.companion(snapshot.profile),
      next_lesson: snapshot.next_lesson,
      track_progress: snapshot.track_progress,
      recent_runs: snapshot.recent_runs,
      track_titles: Map.new(Curriculum.active_tracks(), &{&1.slug, &1.title})
    )
  end

  defp track_title(track_titles, slug) do
    Map.get(track_titles, slug, slug |> String.replace("-", " ") |> String.capitalize())
  end
end
