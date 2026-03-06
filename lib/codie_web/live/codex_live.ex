defmodule CodieWeb.CodexLive do
  use CodieWeb, :live_view

  alias Codie.Progress

  @impl true
  def mount(_params, _session, socket) do
    snapshot =
      Progress.get_or_create_profile()
      |> Progress.dashboard_snapshot()

    {:ok,
     assign(socket,
       page_title: "Codex",
       profile: snapshot.profile,
       entries: snapshot.unlocked_entries
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section class="glass-panel">
      <div class="section-heading">
        <p class="eyebrow">Unlocked Reference</p>
        <h1>Codex</h1>
      </div>
      <p class="hero-text">
        Every passed lesson unlocks a focused reference entry. Use this as your quick in-app memory palace while you're learning and while you maintain the app later.
      </p>
    </section>

    <section class="codex-grid">
      <div :if={@entries == []} class="glass-panel">
        <h2>No entries yet</h2>
        <p class="muted-copy">Clear your first lessons in Foundations to populate the Codex.</p>
      </div>

      <article :for={entry <- @entries} class="glass-panel codex-entry">
        <p class="eyebrow">Reference</p>
        <h2>{entry.title}</h2>
        <p>{entry.summary}</p>

        <div class="codex-detail">
          <p class="eyebrow">Example</p>
          <pre><code>{entry.example}</code></pre>
        </div>

        <div class="codex-detail">
          <p class="eyebrow">Watch Out</p>
          <p>{entry.watch_out}</p>
        </div>

        <div class="codex-detail">
          <p class="eyebrow">When To Use It</p>
          <p>{entry.when_to_use}</p>
        </div>
      </article>
    </section>
    """
  end
end
