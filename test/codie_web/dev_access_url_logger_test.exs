defmodule CodieWeb.DevAccessUrlLoggerTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureLog

  alias CodieWeb.DevAccessUrlLogger

  test "runtime_url uses the actual bound port" do
    base_uri = URI.parse("http://localhost")

    assert DevAccessUrlLogger.runtime_url(base_uri, 59_582) == "http://localhost:59582"
  end

  test "runtime_url preserves a configured path" do
    base_uri = URI.parse("http://localhost/app")

    assert DevAccessUrlLogger.runtime_url(base_uri, 4040) == "http://localhost:4040/app"
  end

  test "logs a clickable access URL with the runtime port" do
    log =
      capture_log(fn ->
        DevAccessUrlLogger.log_runtime_access_url(
          {:ok, {{127, 0, 0, 1}, 59_582}},
          URI.parse("http://localhost")
        )
      end)

    assert log =~ "Open Codie at http://localhost:59582"
  end
end
