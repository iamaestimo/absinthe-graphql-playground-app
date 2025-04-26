defmodule WendigoWeb.Resolvers.LeagueResolver do
  @moduledoc """
  GraphQL resolver for leagues.
  """
  alias Wendigo.Context.Leagues
  alias WendigoWeb.Error

  def get_league(_parent, %{id: id}, _resolution) do
    case Leagues.get(id) do
      nil ->
        # Instead of returning a handled error, raise an exception
        raise "League not found with ID: #{id}" # Or use a specific exception type if you prefer
      league ->
        {:ok, league}
    end
    # case Leagues.get(id) do
    #   nil -> Error.new("League not found: #{id}")
    #   league -> {:ok, league}
    # end
  end

  def list_leagues(_parent, %{first: first, offset: offset}, _resolution) do
    {:ok, Leagues.list(first, offset)}
  end

  def list_leagues(_parent, %{first: first}, _resolution) do
    {:ok, Leagues.list(first)}
  end

  def list_leagues(_parent, _args, _resolution) do
    {:ok, Leagues.first_page()}
  end

  @doc "Resolver function for creating leagues"
  def create_league(_parent, args, _resolution) do
    case Leagues.create(args) do
      {:error, cs} -> Error.new("Failed to create league", cs)
      result -> result
    end
  end

  @doc "Resolver function for updating league name"
  def update_league(_parent, %{id: id, name: name}, _resolution) do
    case Leagues.get(id) do
      nil -> Error.new("league not found: #{id}")
      league -> update_league(league, name)
    end
  end

  # Update league helper
  defp update_league(league, name) do
    case Leagues.update(league, %{name: name}) do
      {:error, cs} -> Error.new("Failed to update league", cs)
      result -> result
    end
  end

  @doc "Resolver function for deleting leagues"
  def delete_league(_parent, %{id: id}, _resolution) do
    case Leagues.get(id) do
      nil -> Error.new("League not found: #{id}")
      league -> Leagues.delete(league)
    end
  end
end
