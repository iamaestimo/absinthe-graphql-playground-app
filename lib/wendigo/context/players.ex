defmodule Wendigo.Context.Players do
  @moduledoc """
  A data context for managing players.
  """
  import Ecto.Query

  alias Wendigo.Repo
  alias Wendigo.Schema.Player

  # Put a max limit on any list queries
  @query_limit Application.compile_env(:wendigo, :max_page_size)

  @doc "Get a player"
  def get(id),
    do: Repo.get(Player, id)

  @doc "Get the list of players on a team"
  def on_team(team_id) do
    Player
    |> where(team_id: ^team_id)
    |> limit(^@query_limit)
    |> Repo.all()
  end

  @doc "Create a player"
  def create(args),
    do: Repo.insert(Player.changeset(args))

  @doc "Delete a player"
  def delete(%Player{} = player),
    do: Repo.delete(player)

  @doc "Defines a new ecto data source"
  def datasource,
    do: Dataloader.Ecto.new(Repo)
end
