defmodule ValidatorsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Validators   

  test "creates player when type is valid" do
    assert validate_type("h", "X") == %HumanPlayer{marker: "X"}
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

  test "returns false for bad input" do
    refute valid_move?(["X", 2, 3, 4, 5, 6, 7, 8, 9], "/")
  end

  test "handles bad input" do
    assert capture_io(fn ->
      validate_move(["X", 2, 3, 4, 5, 6, 7, 8, 9], ";lkj;ewejor", "O")
    end) == "Invalid move. Player O, make your move:\n" 
  end

  test "adds valid move to board" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert validate_move(board, "1", "X") == ["X", 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "doesn't add invalid move to board" do
    board = ["X", 2, 3, 4, 5, 6, 7, 8, 9]
    assert validate_move(board, "1", "O") == ["X", 2, 3, 4, 5, 6, 7, 8, 9]
  end

end
