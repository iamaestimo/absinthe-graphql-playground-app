defmodule Wendigo.Schema.LeagueTest do
  use ExUnit.Case, async: true
  alias Wendigo.Schema.League

  # Test context
  setup do
    %{
      valid_params: %{
        name: "name#{Nanoid.generate()}",
        level: "level#{Nanoid.generate()}"
      },
      only_name: %{
        name: "name#{Nanoid.generate()}"
      },
      invalid_params: %{
        name: "too_long_name#{Nanoid.generate(100)}"
      }
    }
  end

  # Test league changeset validations
  describe "League.changeset" do
    test "succeeds on valid params", ctx do
      result = League.changeset(ctx.valid_params)
      assert result.valid?
    end

    test "succeeds when only a name is given", ctx do
      result = League.changeset(ctx.only_name)
      assert result.valid?
    end

    test "fails on invalid params", ctx do
      result = League.changeset(ctx.invalid_params)
      refute result.valid?
      assert result.errors[:name], "expected error on league name"
    end

    test "fails on empty params" do
      result = League.changeset(%{})
      refute result.valid?
      assert result.errors[:name], "expected error on league name"
    end
  end
end
