defmodule Wendigo.Context.Seasons do
  @moduledoc """
  A data context for managing seasons.
  """
  alias Wendigo.Repo
  alias Wendigo.Schema.Season

  import Ecto.Query
  import Wendigo.Context.Clamp, only: [clamp: 1, non_negative: 1]

  # Read default page size from compile-time config
  @default_page_size Application.compile_env(:wendigo, :min_page_size)

  @doc "Get a season"
  def get(id), do: Repo.get(Season, id)

  @doc "Get the first page of seasons"
  def first_page, do: list(@default_page_size)

  @doc "Get a page of seasons"
  def list(first, offset \\ 0) do
    Season
    |> order_by(desc: :start_date)
    |> limit(^clamp(first))
    |> offset(^non_negative(offset))
    |> Repo.all()
  end

  @doc "Create a season"
  def create(args),
    do: Repo.insert(Season.changeset(args))

  @doc "Update a season"
  def update(season, args),
    do: Repo.update(Season.changeset(season, args))

  @doc "Delete a season"
  def delete(season),
    do: Repo.delete(season)

  @doc "Defines a new ecto data source"
  def datasource, do: Dataloader.Ecto.new(Repo)
end
