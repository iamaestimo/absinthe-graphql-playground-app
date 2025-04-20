defmodule Wendigo.Context.ClampTest do
  use ExUnit.Case, async: true
  import Wendigo.Context.Clamp, only: [clamp: 1, non_negative: 1]

  # Read page size limits from compile-time config
  @min_page_size Application.compile_env(:wendigo, :min_page_size)
  @max_page_size Application.compile_env(:wendigo, :max_page_size)

  # Test league changeset validations
  describe "non_negative" do
    test "returns 0 for negative numbers" do
      assert non_negative(-10) == 0
    end

    test "returns the input number for positive numbers" do
      assert non_negative(10) == 10
    end

    test "returns zero for zero" do
      assert non_negative(0) == 0
    end
  end

  # Test league changeset validations
  describe "clamp" do
    test "returns min page size when out of range (lower bound)" do
      assert clamp(-10) == @min_page_size
      assert clamp(0) == @min_page_size
      assert clamp(5) == @min_page_size
    end

    test "returns max page size when out of range (upper bound)" do
      assert clamp(1_000_000) == @max_page_size
    end

    test "returns the input page size when in range" do
      assert clamp(25) == 25
    end
  end
end
