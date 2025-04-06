defmodule Wendigo.Context.Teams do
  @moduledoc """
  A data context for managing teams.
  """
  alias Wendigo.Repo
  alias Wendigo.Schema.{Player, Team}
  import Ecto.Query

  require Logger

  @doc "Get a team"
  def get(id), do: Repo.get(Team, id)

  @doc "Get teams for a season"
  def list(season_id) do
    Team
    |> where(season_id: ^season_id)
    |> Repo.all()
  end

  @doc "Get teams for a season in a league"
  def list(season_id, league_id) do
    Team
    |> where(season_id: ^season_id)
    |> where(league_id: ^league_id)
    |> Repo.all()
  end

  @doc "Get the list of players on a team"
  def list_players(id) do
    Player
    |> where(team_id: ^id)
    |> Repo.all()
  end
end
