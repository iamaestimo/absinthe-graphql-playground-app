defmodule WendigoWeb.GraphQL.Schema do
  @moduledoc """
  The Wendigo GraphQL schema. Defines queries and mutations.
  """
  use Absinthe.Schema

  alias Wendigo.Context.{Leagues, Players, Seasons, Teams}
  alias WendigoWeb.Resolvers.{LeagueResolver, PlayerResolver, SeasonResolver, TeamResolver}

  import_types(Absinthe.Type.Custom)
  import_types(WendigoWeb.GraphQL.Types)

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
      resolve(&PlayerResolver.list_players/3)
    end

    @desc "Get a player"
    field :player, :player do
      arg(:id, non_null(:id))
      resolve(&PlayerResolver.get_player/3)
    end
  end

  mutation do
    @desc "Create a season"
    field :create_season, :season do
      arg(:name, non_null(:string))
      arg(:start_date, non_null(:date))
      arg(:end_date, non_null(:date))
      resolve(&SeasonResolver.create_season/3)
    end

    @desc "Rename a season"
    field :rename_season, :season do
      arg(:id, non_null(:id))
      arg(:name, non_null(:string))
      resolve(&SeasonResolver.update_season/3)
    end

    @desc "Delete a season"
    field :delete_season, :season do
      arg(:id, non_null(:id))
      resolve(&SeasonResolver.delete_season/3)
    end

    @desc "Create a league"
    field :create_league, :league do
      arg(:name, non_null(:string))
      arg(:level, :string)
      resolve(&LeagueResolver.create_league/3)
    end

    @desc "Rename a league"
    field :rename_league, :league do
      arg(:id, non_null(:id))
      arg(:name, non_null(:string))
      resolve(&LeagueResolver.update_league/3)
    end

    @desc "Delete a league"
    field :delete_league, :league do
      arg(:id, non_null(:id))
      resolve(&LeagueResolver.delete_league/3)
    end

    @desc "Create a team"
    field :create_team, :team do
      arg(:name, non_null(:string))
      arg(:season_id, non_null(:id))
      arg(:league_id, non_null(:id))
      arg(:captain, :string)
      resolve(&TeamResolver.create_team/3)
    end

    @desc "Delete a team"
    field :delete_team, :team do
      arg(:id, non_null(:id))
      resolve(&TeamResolver.delete_team/3)
    end

    @desc "Create a player"
    field :create_player, :player do
      arg(:name, non_null(:string))
      arg(:contact, non_null(:string))
      arg(:team_id, non_null(:id))
      arg(:usahn, :string)
      arg(:position, :string)
      arg(:jersey_number, :string)
      resolve(&PlayerResolver.create_player/3)
    end

    @desc "Delete a player"
    field :delete_player, :player do
      arg(:id, non_null(:id))
      resolve(&PlayerResolver.delete_player/3)
    end
  end

  # Dataloader

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Leagues, Leagues.datasource())
      |> Dataloader.add_source(Players, Players.datasource())
      |> Dataloader.add_source(Seasons, Seasons.datasource())
      |> Dataloader.add_source(Teams, Teams.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  # Middleware
  def middleware(middleware, _field, _object) do
    middleware ++ [WendigoWeb.Middleware.ErrorReporter]
  end
end
