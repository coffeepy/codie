defmodule Codie.Curriculum.Check do
  @enforce_keys [:type, :label, :config, :failure_message]
  defstruct [:type, :label, :config, :failure_message, :checkpoint]
end
