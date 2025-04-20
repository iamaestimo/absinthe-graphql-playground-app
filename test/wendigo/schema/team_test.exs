defmodule Wendigo.Schema.TeamTest do
  use ExUnit.Case, async: true
  alias Wendigo.Schema.Team

  # Test context
  setup do
    %{
      valid_params: %{
        name: "name#{Nanoid.generate()}",
        league_id: Nanoid.generate(),
        season_id: Nanoid.generate()
      },
      invalid_params: %{
        name: "name_too_long#{Nanoid.generate(100)}",
        league_id: Nanoid.generate(),
        season_id: Nanoid.generate()
      }
    }
  end

  # Test Team changeset validations
  describe "Team changeset" do
    test "succeeds on valid params", ctx do
      result = Team.changeset(ctx.valid_params)
      assert result.valid?
    end

    test "fails on invalid params", ctx do
      result = Team.changeset(ctx.invalid_params)
      refute result.valid?
      assert result.errors[:name], "expected error on team name"
    end

    test "fails on empty params" do
      result = Team.changeset(%{})
      refute result.valid?
      assert result.errors[:name], "expected error on team name"
      assert result.errors[:league_id], "expected error on team league_id"
      assert result.errors[:season_id], "expected error on team season_id"
    end
  end
end
