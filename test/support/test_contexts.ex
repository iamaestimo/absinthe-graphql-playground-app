defmodule Wendigo.TestContexts do
  @moduledoc false
  alias Wendigo.Context.{Leagues, Seasons, Teams}

  @doc "Create a test season"
  def setup_season do
    Seasons.create(%{
      name: "Test Season",
      start_date: Date.from_iso8601!("2025-06-01"),
      end_date: Date.from_iso8601!("2025-08-31")
    })
  end

  @doc "Create a test league"
  def setup_league,
    do: Leagues.create(%{name: "Test League"})

  @doc "Create a test team"
  def setup_team do
    {:ok, season} = setup_season()
    {:ok, league} = setup_league()
    Teams.create(%{name: "Test Team", season_id: season.id, league_id: league.id})
  end
end
