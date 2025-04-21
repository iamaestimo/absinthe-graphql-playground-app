defmodule Wendigo.Context.Teams do
  @moduledoc """
  A data context for managing teams.
  """
  import Ecto.Query

  alias Wendigo.Repo
  alias Wendigo.Schema.Team

  require Logger

  # Put a max limit on any list queries
  @query_limit Application.compile_env(:wendigo, :max_page_size)

  @doc "Get a team"
  def get(id),
    do: Repo.get(Team, id)

  @doc "Get teams for a season"
  def list(season_id) do
    Team
    |> where(season_id: ^season_id)
    |> limit(^@query_limit)
    |> Repo.all()
  end

  @doc "Get teams for a season in a league"
  def list(season_id, league_id) do
    Team
    |> where(season_id: ^season_id)
    |> where(league_id: ^league_id)
    |> limit(^@query_limit)
    |> Repo.all()
  end

  @doc "Create a team"
  def create(args),
    do: Repo.insert(Team.changeset(args))

  @doc "Delete a team"
  def delete(%Team{} = team),
    do: Repo.delete(team)

  @doc "Defines a new ecto data source"
  def datasource,
    do: Dataloader.Ecto.new(Repo)
end
