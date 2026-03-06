defmodule Codie.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CodieWeb.Telemetry,
      Codie.Repo,
      {Ecto.Migrator,
       repos: Application.fetch_env!(:codie, :ecto_repos), skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:codie, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Codie.PubSub},
      {Task.Supervisor, name: Codie.Runner.TaskSupervisor},
      # Start to serve requests, typically the last entry
      CodieWeb.Endpoint
    ] ++ runtime_access_url_children()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Codie.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CodieWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") == nil
  end

  defp runtime_access_url_children() do
    if Application.get_env(:codie, CodieWeb.Endpoint, [])[:runtime_access_url] do
      [CodieWeb.DevAccessUrlLogger]
    else
      []
    end
  end
end
