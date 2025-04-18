defmodule Wendigo.Schema.PlayerTest do
  use ExUnit.Case, async: true
  alias Wendigo.Schema.Player

  # Test context
  setup do
    %{
      valid_params: %{
        name: "name#{Nanoid.generate()}",
        contact: "email#{Nanoid.generate()}@domain.com",
        team_id: Nanoid.generate()
      },
      invalid_params: %{
        name: "name_too_long#{Nanoid.generate(100)}",
        contact: "contact_too_long#{Nanoid.generate(100)}"
      }
    }
  end

  # Test Player changeset validations
  describe "Player.changeset" do
    test "succeeds on valid params", ctx do
      result = Player.changeset(ctx.valid_params)
      assert result.valid?
    end

    test "fails on invalid params", ctx do
      result = Player.changeset(ctx.invalid_params)
      refute result.valid?
      assert result.errors[:name], "expected error on player name"
      assert result.errors[:contact], "expected error on player contact"
    end

    test "fails on empty params" do
      result = Player.changeset(%{})
      refute result.valid?
      assert result.errors[:name], "expected error on player name"
      assert result.errors[:contact], "expected error on player contact"
      assert result.errors[:team_id], "expected error on player team_id"
    end
  end
end
