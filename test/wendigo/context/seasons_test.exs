defmodule Wendigo.Context.SeasonsTest do
  use Wendigo.DataCase, async: true
  alias Wendigo.Context.Seasons

  # Setup test context
  setup do
    %{
      args: %{
        name: "Test Season",
        start_date: Date.from_iso8601!("2025-06-01"),
        end_date: Date.from_iso8601!("2025-08-31")
      }
    }
  end

  # Test league context operations
  describe "Sesons context" do
    test "creates, gets, lists, updates, and deletes seasons", ctx do
      assert {:ok, season} = Seasons.create(ctx.args)
      assert season.name == ctx.args.name
      assert season == Seasons.get(season.id)
      assert [season] == Seasons.first_page()
      assert {:ok, updated} = Seasons.update(season, %{name: "Updated Season"})
      assert updated.name == "Updated Season"
      assert {:ok, deleted} = Seasons.delete(updated)
      assert season.id == deleted.id
    end
  end
end
