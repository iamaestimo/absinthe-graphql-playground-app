defmodule Wendigo.Context.Leagues do
  @moduledoc """
  A data context for managing leagues.
  """
  alias Wendigo.{Repo, Schema.League}
  import Ecto.Query

  require Logger

  @doc "Get a league"
  def get(id), do: Repo.get(League, id)

  @doc "Get the first page of leagues"
  def list, do: list(10, 0)

  @doc "Get a page of leagues"
  def list(first, offset) do
    League
    |> order_by(asc: :inserted_at)
    |> limit(^first)
    |> offset(^offset)
    |> Repo.all()
  end

  @doc "Defines a new ecto data source"
  def datasource, do: Dataloader.Ecto.new(Repo)
end
