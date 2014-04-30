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

  test "returns false if size range is invalid" do
    refute valid_board_size?("1")
  end

  test "returns false if size is bad" do
    refute valid_board_size?("''")
  end

  test "returns true if size is valid" do
    assert valid_board_size?("3")
  end

  test "returns false for bad input" do
    refute valid_move?(["X", 2, 3, 4, 5, 6, 7, 8, 9], "/")
  end

  test "handles bad move input" do
    assert capture_io(fn ->
      validate_move(["X", 2, 3, 4, 5, 6, 7, 8, 9], ";lkj;ewejor", "O")
    end) == "Invalid move. Player 'O', make your move:\n" 
  end

  test "adds valid move to board" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert validate_move(board, "1", "X") == ["X", 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "doesn't add invalid move to board" do
    board = ["X", 2, 3, 4, 5, 6, 7, 8, 9]
    assert validate_move(board, "1", "O") == ["X", 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "doesn't apply bad type input, requests re-entry" do
    capture_io([input: "Human\n", capture_prompt: false], fn ->
      assert validate_type("c", "X") == %ComputerPlayer{marker: "X"} 
    end)
  end

  test "doesn't apply bad size input, requests re-entry" do
    capture_io([input: "4\n", capture_prompt: false], fn ->
      assert validate_board_size("X") == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
      13, 14, 15, 16] 
    end)
  end

end
