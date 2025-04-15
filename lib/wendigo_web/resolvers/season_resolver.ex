defmodule WendigoWeb.Resolvers.SeasonResolver do
  @moduledoc """
  GraphQL resolver for seasons.
  """
  alias Wendigo.Context.Seasons
  alias WendigoWeb.Error

  def get_season(_parent, %{id: id}, _resolution) do
    case Seasons.get(id) do
      nil -> Error.new("Season not found: #{id}")
      season -> {:ok, season}
    end
  end

  def list_seasons(_parent, %{first: first, offset: offset}, _resolution) do
    {:ok, Seasons.list(first, offset)}
  end

  def list_seasons(_parent, %{first: first}, _resolution) do
    {:ok, Seasons.list(first)}
  end

  def list_seasons(_parent, _args, _resolution) do
    {:ok, Seasons.first_page()}
  end

  @doc "Resolver function for creating seasons"
  def create_season(_parent, args, _resolution) do
    case Seasons.create(args) do
      {:error, cs} -> Error.new("Failed to create season", cs)
      result -> result
    end
  end

  @doc "Resolver function for updating season name"
  def update_season(_parent, %{id: id, name: name}, _resolution) do
    case Seasons.get(id) do
      nil -> Error.new("Season not found: #{id}")
      season -> update_season(season, name)
    end
  end

  # Update season helper
  defp update_season(season, name) do
    case Seasons.update(season, %{name: name}) do
      {:error, cs} -> Error.new("Failed to update season", cs)
      result -> result
    end
  end

  @doc "Resolver function for deleting seasons"
  def delete_season(_parent, %{id: id}, _resolution) do
    case Seasons.get(id) do
      nil -> Error.new("Season not found: #{id}")
      season -> Seasons.delete(season)
    end
  end
end
