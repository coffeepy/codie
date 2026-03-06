defmodule Codie.Runner.Submission do
  @enforce_keys [:lesson_slug, :code, :profile_id, :attempt_number]
  defstruct [:lesson_slug, :code, :profile_id, :attempt_number]
end
