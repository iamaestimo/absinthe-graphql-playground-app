defmodule Wendigo.Context.PlayersTest do
  use ExUnit.Case, async: true

  alias Ecto.Adapters.SQL.Sandbox
  alias Wendigo.Context.Players
  alias Wendigo.TestContexts

  # Setup test context
  setup do
    :ok = Sandbox.checkout(Wendigo.Repo)
    {:ok, team} = TestContexts.setup_team()
    %{args: %{name: "Jon Doe", contact: "jon.doe@email.com", team_id: team.id}}
  end

  # Test players context operations
  describe "Players context" do
    test "creates, gets, lists, and deletes players", ctx do
      assert {:ok, player} = Players.create(ctx.args)
      assert player.name == ctx.args.name
      assert player == Players.get(player.id)
      assert [player] == Players.on_team(ctx.args.team_id)
      assert {:ok, deleted} = Players.delete(player)
      assert deleted.id == player.id
    end
  end
end
