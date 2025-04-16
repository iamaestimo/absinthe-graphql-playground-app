defmodule WendigoWeb.Resolvers.PlayerResolver do
  @moduledoc """
  GraphQL resolver for players.
  """
  alias Wendigo.Context.Players
  alias WendigoWeb.Error

  def list_players(_parent, %{team_id: team_id}, _resolution) do
    {:ok, Players.on_team(team_id)}
  end

  def get_player(_parent, %{id: id}, _resolution) do
    case Players.get(id) do
      nil -> Error.new("Player not found: #{id}")
      player -> {:ok, player}
    end
  end

  @doc "Resolver function for creating players"
  def create_player(_parent, args, _resolution) do
    case Players.create(args) do
      {:error, cs} -> Error.new("Failed to create player", cs)
      result -> result
    end
  end

  @doc "Resolver function for deleting players"
  def delete_player(_parent, %{id: id}, _resolution) do
    case Players.get(id) do
      nil -> Error.new("Player not found: #{id}")
      player -> Players.delete(player)
    end
  end
end
