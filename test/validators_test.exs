defmodule ValidatorsTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  import Validators   
  @new_3x3_board [1, 2, 3, 4, 5, 6, 7, 8, 9]
  @new_4x4_board [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]

  test "creates player if type is valid" do
    assert validate_type("h", "X") == %HumanPlayer{marker: "X"}
  end

  test "move is valid" do
    board = @new_3x3_board
    assert valid_move?(board, "1")
  end

  test "move is invalid for letter input" do
    board = @new_3x3_board
    refute valid_move?(board, "G")
  end

  test "move is invalid for symbol input" do
    refute valid_move?(["X", 2, 3, 4, 5, 6, 7, 8, 9], "/")
  end

  test "move is invalid when cell is occupied" do
    refute valid_move?(["X", 2, 3, 4, 5, 6, 7, 8, 9], "1")
  end
 
  test "returns true for cell within range" do
    board = @new_4x4_board
    assert valid_move?(board, "11")
  end

  test "returns false for cell within range" do
    board = @new_4x4_board
    refute valid_move?(board, "0")
  end

  test "returns false for moves outside of the range" do
    board = @new_4x4_board 
    refute within_range?(board, 16) 
  end

  test "returns true for moves within the range" do
    board = @new_4x4_board
    assert within_range?(board, 15) 
  end

  test "size is invalid when outside the range" do
    refute valid_board_size?("1")
  end

  test "size is invalid for bad value" do
    refute valid_board_size?("''")
  end

  test "size is valid" do
    assert valid_board_size?("3")
  end

  test "prints invalid move message for bad move input" do
    assert capture_io(fn ->
      validate_move(["X", 2, 3, 4, 5, 6, 7, 8, 9], ";lkj;ewejor", "O")
    end) == "Invalid move. Player 'O', make your move:\n" 
  end

  test "adds move to board when valid" do
    board = @new_3x3_board 
    assert validate_move(board, "1", "X") == ["X", 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "gets new input when invalid type" do
    capture_io([input: "Human\n", capture_prompt: false], fn ->
      assert validate_type("c", "X") == %ComputerPlayer{marker: "X"} 
    end)
  end

  test "gets new input when invalid size" do
    capture_io([input: "4\n", capture_prompt: false], fn ->
      assert validate_board_size("X") == @new_4x4_board 
    end)
  end

end
