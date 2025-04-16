defmodule Wendigo.Context.Leagues do
  @moduledoc """
  A data context for managing leagues.
  """
  alias Wendigo.Repo
  alias Wendigo.Schema.League

  import Ecto.Query
  import Wendigo.Context.Clamp, only: [clamp: 1, non_negative: 1]

  # Read default page size from compile-time config
  @default_page_size Application.compile_env(:wendigo, :min_page_size)

  @doc "Get a league"
  def get(id), do: Repo.get(League, id)

  @doc "Get the first page of leagues"
  def first_page, do: list(@default_page_size)

  @doc "Get a page of leagues"
  def list(first, offset \\ 0) do
    League
    |> order_by(asc: :inserted_at)
    |> limit(^clamp(first))
    |> offset(^non_negative(offset))
    |> Repo.all()
  end

  @doc "Create a league"
  def create(args),
    do: Repo.insert(League.changeset(args))

  @doc "Update a league"
  def update(league, args),
    do: Repo.update(League.changeset(league, args))

  @doc "Delete a league"
  def delete(league),
    do: Repo.delete(league)

  @doc "Defines a new ecto data source"
  def datasource, do: Dataloader.Ecto.new(Repo)
end
