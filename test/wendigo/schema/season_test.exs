defmodule Wendigo.Schema.SeasonTest do
  use ExUnit.Case, async: true
  alias Wendigo.Schema.Season

  # Test context
  setup do
    %{
      valid_params: %{
        name: "name#{Nanoid.generate()}",
        start_date: Date.from_iso8601!("2025-06-01"),
        end_date: Date.from_iso8601!("2025-08-31")
      },
      invalid_params: %{
        name: "name_too_long#{Nanoid.generate(100)}",
        start_date: Date.from_iso8601!("2025-06-01"),
        end_date: Date.from_iso8601!("2025-08-31")
      }
    }
  end

  # Test season changeset validations
  describe "Season.changeset" do
    test "succeeds on valid params", ctx do
      result = Season.changeset(ctx.valid_params)
      assert result.valid?
    end

    test "fails on invalid params", ctx do
      result = Season.changeset(ctx.invalid_params)
      refute result.valid?
      assert result.errors[:name], "expected error on season name"
    end

    test "fails on empty params" do
      result = Season.changeset(%{})
      refute result.valid?
      assert result.errors[:name], "expected error on season name"
      assert result.errors[:start_date], "expected error on season start_date"
      assert result.errors[:end_date], "expected error on season end_date"
    end
  end
end
