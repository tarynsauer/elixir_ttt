defmodule ValidatorsTest do
  use ExUnit.Case
  import Validators   

  test "creates player when type is valid" do
    assert validate_type("human", "X") == %HumanPlayer{marker: "X"}
  end

  test "returns true if move is valid" do
    assert valid_move?([1, 2, 3, 4, 5, 6, 7, 8, 9], "1")
  end

  test "returns false if move is invalid" do
    refute valid_move?([1, 2, 3, 4, 5, 6, 7, 8, 9], "G")
  end

  test "returns false if board move occupied" do
    refute valid_move?(["X", 2, 3, 4, 5, 6, 7, 8, 9], "1")
  end

  # test "creates player for valid type input" do
  #   output = capture_io([input: "human", capture_prompt: false], fn ->
  #     get_player("X") 
  #   end) 
  #   assert output == %Player{marker: "X", type: "human"}
  # end

  
end
