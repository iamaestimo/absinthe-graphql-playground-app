defmodule WendigoWeb.Resolvers.SeasonResolver do
  @moduledoc """
  GraphQL resolver for seasons.
  """
  alias Wendigo.Context.Seasons
  alias Wendigo.Schema.Team
  alias WendigoWeb.Error

  def get_season(_parent, %{id: id}, _resolution), do: get_season(id)
  def get_season(%Team{} = team, _args, _resolution), do: get_season(team.season_id)

  defp get_season(id) do
    case Seasons.get(id) do
      nil -> Error.new("Season not found: #{id}")
      season -> {:ok, season}
    end
  end

  def list_seasons(_parent, %{first: first}, _resolution) do
    {:ok, Seasons.list(first, 0)}
  end

  def list_seasons(_parent, %{first: first, offset: offset}, _resolution) do
    {:ok, Seasons.list(first, offset)}
  end

  def list_seasons(_parent, _args, _resolution) do
    {:ok, Seasons.list()}
  end
end
