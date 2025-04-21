defmodule Wendigo.Context.LeaguesTest do
  use Wendigo.DataCase, async: true
  alias Wendigo.Context.Leagues

  # Setup test context
  setup do
    %{args: %{name: "Test League", level: "Advanced"}}
  end

  # Test league context operations
  describe "Leagues context" do
    test "creates, gets, lists, updates, and deletes leagues", ctx do
      assert {:ok, league} = Leagues.create(ctx.args)
      assert league.name == ctx.args.name
      assert league == Leagues.get(league.id)
      assert [league] == Leagues.first_page()
      assert {:ok, updated} = Leagues.update(league, %{name: "Updated League"})
      assert updated.name == "Updated League"
      assert {:ok, deleted} = Leagues.delete(updated)
      assert league.id == deleted.id
    end
  end
end
