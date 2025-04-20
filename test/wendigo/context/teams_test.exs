defmodule Wendigo.Context.TeamsTest do
  use ExUnit.Case, async: true

  alias Ecto.Adapters.SQL.Sandbox
  alias Wendigo.Context.Teams
  alias Wendigo.TestContexts

  # Setup test context
  setup do
    :ok = Sandbox.checkout(Wendigo.Repo)
    {:ok, season} = TestContexts.setup_season()
    {:ok, league} = TestContexts.setup_league()
    %{args: %{name: "Test team", season_id: season.id, league_id: league.id}}
  end

  # Test league context operations
  describe "Teams context" do
    test "creates, gets, lists, and deletes teams", ctx do
      assert {:ok, team} = Teams.create(ctx.args)
      assert team.name == ctx.args.name
      assert team == Teams.get(team.id)
      assert [team] == Teams.list(ctx.args.season_id, ctx.args.league_id)
      assert {:ok, deleted} = Teams.delete(team)
      assert team.id == deleted.id
    end
  end
end
