defmodule CodieWeb.DevAccessUrlLogger do
  @moduledoc false

  require Logger

  def child_spec(opts \\ []) do
    endpoint = Keyword.get(opts, :endpoint, CodieWeb.Endpoint)

    Supervisor.child_spec(
      {Task, fn -> log_endpoint_access_url(endpoint) end},
      id: {__MODULE__, endpoint},
      restart: :temporary
    )
  end

  def log_endpoint_access_url(endpoint \\ CodieWeb.Endpoint) do
    endpoint.server_info(:http)
    |> log_runtime_access_url(endpoint.struct_url())
  end

  def log_runtime_access_url({:ok, {_ip, port}}, %URI{} = base_uri) when is_integer(port) do
    Logger.info("Open Codie at #{runtime_url(base_uri, port)}")
  end

  def log_runtime_access_url({:error, reason}, _base_uri) do
    Logger.debug("Could not determine runtime access URL: #{inspect(reason)}")
  end

  def runtime_url(%URI{} = base_uri, port) when is_integer(port) do
    scheme = base_uri.scheme || "http"
    host = base_uri.host || "localhost"
    path = if base_uri.path in [nil, "/"], do: "", else: base_uri.path

    "#{scheme}://#{host}:#{port}#{path}"
  end
end
