defmodule Wendigo.Context.Clamp do
  @moduledoc false

  # Read page size limits from compile-time config
  @min_page_size Application.compile_env(:wendigo, :min_page_size)
  @max_page_size Application.compile_env(:wendigo, :max_page_size)

  @doc "Clamp a page size within a range"
  def clamp(first) when first < @min_page_size, do: @min_page_size
  def clamp(first) when first > @max_page_size, do: @max_page_size
  def clamp(first), do: first
end
