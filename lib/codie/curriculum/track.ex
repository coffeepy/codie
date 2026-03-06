defmodule Codie.Curriculum.Track do
  @enforce_keys [:slug, :title, :summary, :theme, :estimated_lesson_count, :teaser]
  defstruct [:slug, :title, :summary, :theme, :estimated_lesson_count, :teaser]
end
