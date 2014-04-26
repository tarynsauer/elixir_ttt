defmodule BoardTest do
  use ExUnit.Case
  import Board 

  test "creates a new board" do
    board = create_board()
    assert board == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "indicates whether cell is open" do
    board = ["X", 2, 3, 4, 5, 6, 7, 8, 9]
    refute open_cell?(board, 0)
  end

  test "adds marker to the board" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert add_marker(board, "X", 0) == ["X", 2, 3, 4, 5, 6, 7, 8, 9]
  end

end
