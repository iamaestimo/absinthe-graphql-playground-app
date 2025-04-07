defmodule Wendigo.Context.Seasons do
  @moduledoc """
  A data context for managing seasons.
  """
  alias Wendigo.{Repo, Schema.Season}
  import Ecto.Query

  require Logger

  @doc "Get a season"
  def get(id), do: Repo.get(Season, id)

  @doc "Get recent seasons"
  def list, do: list(10, 0)

  @doc "Get a page of seasons"
  def list(first, offset) do
    Season
    |> order_by(desc: :start_date)
    |> limit(^first)
    |> offset(^offset)
    |> Repo.all()
  end

  @doc "Defines a new ecto data source"
  def datasource, do: Dataloader.Ecto.new(Repo)
end
