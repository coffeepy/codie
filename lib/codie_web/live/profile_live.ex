defmodule CodieWeb.ProfileLive do
  use CodieWeb, :live_view

  alias Codie.Curriculum
  alias Codie.Progress

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(page_title: "Profile") |> hydrate()}
  end

  @impl true
  def handle_event("reset_all_progress", _params, socket) do
    {:ok, _profile} = Progress.reset_all_progress(socket.assigns.profile)

    {:noreply,
     socket
     |> put_flash(:info, "All local lesson progress has been reset.")
     |> hydrate()}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section class="profile-grid">
      <div class="glass-panel">
        <div class="section-heading">
          <p class="eyebrow">Operator</p>
          <h1>{@profile.name}</h1>
        </div>
        <div class="stats-grid">
          <div class="stat-card">
            <span>Level</span>
            <strong>{@profile.level}</strong>
          </div>
          <div class="stat-card">
            <span>XP</span>
            <strong>{@profile.xp}</strong>
          </div>
          <div class="stat-card">
            <span>Beans</span>
            <strong>{@profile.coffee_beans}</strong>
          </div>
          <div class="stat-card">
            <span>Streak</span>
            <strong>{@profile.streak_days}</strong>
          </div>
        </div>
      </div>

      <div class="glass-panel">
        <div class="section-heading">
          <p class="eyebrow">Track Status</p>
          <h2>Campaign Completion</h2>
        </div>
        <div class="track-stack">
          <div :for={track <- @tracks} class="track-row">
            <div>
              <.link navigate={~p"/learn/#{track.track_slug}"}>
                <strong>{track_title(@track_titles, track.track_slug)}</strong>
              </.link>
              <p>{Float.round(track.completion_percent, 1)}%</p>
            </div>
            <span class={status_pill_class(track.status)}>{track.status}</span>
          </div>
        </div>
      </div>

      <div class="glass-panel">
        <div class="section-heading">
          <p class="eyebrow">Lesson Archive</p>
          <h2>Attempts Saved Locally</h2>
        </div>
        <div class="attempt-feed">
          <p :if={@attempts == []} class="muted-copy">
            No saved attempts yet.
          </p>
          <div :for={attempt <- @attempts} class="attempt-row">
            <div>
              <strong>
                {attempt.lesson_slug |> String.replace("-", " ") |> String.capitalize()}
              </strong>
              <p>{human_result(attempt.best_result)}</p>
            </div>
            <span>{attempt.attempt_count} tries</span>
          </div>
        </div>
      </div>

      <div class="glass-panel">
        <div class="section-heading">
          <p class="eyebrow">Local Data</p>
          <h2>Reset All Progress</h2>
        </div>
        <p class="muted-copy">
          This clears lesson attempts, completions, unlocked codex entries, streaks, and stats for this local profile.
        </p>
        <button
          type="button"
          phx-click="reset_all_progress"
          data-confirm="Reset all local progress? This cannot be undone."
          class="danger-cta"
        >
          Reset All Progress
        </button>
      </div>
    </section>
    """
  end

  defp hydrate(socket) do
    profile =
      Progress.get_or_create_profile()
      |> Progress.apply_daily_decay_if_needed()

    assign(socket,
      profile: profile,
      tracks: Progress.list_active_track_progress(profile),
      attempts: Progress.list_lesson_progress(profile),
      track_titles: Map.new(Curriculum.active_tracks(), &{&1.slug, &1.title})
    )
  end

  defp track_title(track_titles, slug) do
    Map.get(track_titles, slug, slug |> String.replace("-", " ") |> String.capitalize())
  end
end
