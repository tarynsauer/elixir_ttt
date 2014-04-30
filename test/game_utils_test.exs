defmodule GameUtilsTest do
  use ExUnit.Case
  import GameUtils 

  test "cell has marker" do
    assert has_marker?("X") 
  end

  test "cell has no marker" do
    refute has_marker?(1) 
  end

  test "player X has next turn" do
    board = ["O", "X", 3, 4, 5, 6, 7, 8, 9]
    assert player_x_turn?(board)
  end

  test "player O has next turn" do
    board = ["O", "X", "X", 4, 5, 6, 7, 8, 9]
    refute player_x_turn?(board)
  end

  test "winning player marker" do
    board = ["X", "X", "X", 4, 5, 6, 7, "O", "O"]
    assert winning_marker(board) == "X" 
  end

  test "lists cell row indexes" do
    assert row_counter(3) == [0, 1, 2] 
  end

  test "cell's value" do
    board = ["O", "X", "X", 4, 5, 6, 7, 8, 9]
    assert cell_val(board, 0) == "O"
  end

  test "returns string as integer value" do
    assert parse_integer("1") == 1 
  end

end
