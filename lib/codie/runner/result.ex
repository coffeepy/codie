defmodule Codie.Runner.Result do
  @enforce_keys [
    :status,
    :compile_output,
    :test_output,
    :returned_value,
    :runtime_ms,
    :summary,
    :annotations,
    :reward_preview
  ]

  defstruct [
    :status,
    :compile_output,
    :test_output,
    :returned_value,
    :runtime_ms,
    :summary,
    :annotations,
    :reward_preview
  ]
end
