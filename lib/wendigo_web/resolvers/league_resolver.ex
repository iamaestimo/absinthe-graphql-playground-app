defmodule WendigoWeb.Resolvers.LeagueResolver do
  @moduledoc """
  GraphQL resolver for leagues.
  """
  alias Wendigo.Context.Leagues
  alias WendigoWeb.Error

  def get_league(_parent, %{id: id}, _resolution) do
    case Leagues.get(id) do
      nil -> Error.new("League not found: #{id}")
      league -> {:ok, league}
    end
  end

  def list_leagues(_parent, %{first: first}, _resolution) do
    {:ok, Leagues.list(first)}
  end

  def list_leagues(_parent, %{first: first, offset: offset}, _resolution) do
    {:ok, Leagues.list(first, offset)}
  end

  def list_leagues(_parent, _args, _resolution) do
    {:ok, Leagues.first_page()}
  end
end
