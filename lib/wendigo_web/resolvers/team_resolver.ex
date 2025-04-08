defmodule WendigoWeb.Resolvers.TeamResolver do
  @moduledoc """
  GraphQL resolver for teams and players.
  """
  alias Wendigo.Context.Teams
  alias WendigoWeb.Error

  def get_team(_parent, %{id: id}, _resolution) do
    case Teams.get(id) do
      nil -> Error.new("Team not found: #{id}")
      team -> {:ok, team}
    end
  end

  def list_teams(_parent, %{season_id: season_id}, _resolution) do
    {:ok, Teams.list(season_id)}
  end

  def list_teams(_parent, %{season_id: season_id, league_id: league_id}, _resolution) do
    {:ok, Teams.list(season_id, league_id)}
  end

  def list_players(_parent, %{team_id: team_id}, _resolution) do
    {:ok, Teams.list_players(team_id)}
  end

  def get_player(_parent, %{id: id}, _resolution) do
    case Teams.get_player(id) do
      nil -> Error.new("Player not found: #{id}")
      player -> {:ok, player}
    end
  end
end
