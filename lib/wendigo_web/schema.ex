defmodule WendigoWeb.Schema do
  @moduledoc """
  The Wendigo GraphQL schema. Defines queries and mutations.
  """
  alias Wendigo.Context.{Leagues, Seasons, Teams}
  alias Wendigo.Datasource
  alias WendigoWeb.Resolvers.{LeagueResolver, SeasonResolver, TeamResolver}
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(WendigoWeb.Schema.Types)

  query do
    @desc "Get a league"
    field :league, :league do
      arg(:id, non_null(:id))
      resolve(&LeagueResolver.get_league/3)
    end

    @desc "List leagues"
    field :leagues, list_of(:league) do
      arg(:first, :integer)
      arg(:offset, :integer)
      resolve(&LeagueResolver.list_leagues/3)
    end

    @desc "Get a season"
    field :season, :season do
      arg(:id, non_null(:id))
      resolve(&SeasonResolver.get_season/3)
    end

    @desc "List seasons"
    field :seasons, list_of(:season) do
      arg(:first, :integer)
      arg(:offset, :integer)
      resolve(&SeasonResolver.list_seasons/3)
    end

    @desc "Get a team"
    field :team, :team do
      arg(:id, non_null(:id))
      resolve(&TeamResolver.get_team/3)
    end

    @desc "List teams"
    field :teams, list_of(:team) do
      arg(:season_id, non_null(:id))
      arg(:league_id, :id)
      resolve(&TeamResolver.list_teams/3)
    end

    @desc "List players on a team"
    field :players, list_of(:player) do
      arg(:team_id, non_null(:id))
      resolve(&TeamResolver.list_players/3)
    end
  end

  # Dataloader

  def context(ctx) do
    source = Datasource.new()

    loader =
      Dataloader.new()
      |> Dataloader.add_source(Leagues, source)
      |> Dataloader.add_source(Seasons, source)
      |> Dataloader.add_source(Teams, source)

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
