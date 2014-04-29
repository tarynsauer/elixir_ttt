defmodule BoardTest do
  use ExUnit.Case
  import Board 
  import TestHelper, only: [number_of_markers_on_board: 1]

  test "creates a new board" do
    board = new_board
    assert board == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "gets column values" do
    board = new_board
    assert get_col(board, 0, 6) == [1, 4, 7]
  end

  test "indicates whether cell is open" do
    board = ["X", 2, 3, 4, 5, 6, 7, 8, 9]
    refute open_cell?(board, 0)
  end

  test "returns indexes of all open cells" do
    board = ["X", 2, 3, 4, 5, 6, 7, 8, 9]
    assert open_cells(board) == [1, 2, 3, 4, 5, 6, 7, 8] 
  end

  test "adds marker to the board" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert add_marker(board, 0) == ["X", 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "places move in a random open cell" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert number_of_markers_on_board(make_random_move(board)) == 1 
  end


  test "returns true, indicates no moves remaining" do
    board = ["X", "O", "X", 
             "X", "O", "O", 
             "O", "X", "X"]
    assert board_full?(board)
  end

  test "when board is empty, returns true" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert empty_board?(board)
  end

  test "returns true when a player has a winning row" do
    board = [1, 2, 3, 
             "O", "O", 6, 
             "X", "X", "X"]
    assert winning_game?(board)
  end

  test "returns true when a player has a winning column" do
    board = ["X", 2, 3, 
             "X", "O", 6, 
             "X", "O", 9]
    assert winning_game?(board)
  end

  test "returns true when a play has a winning diagonal line" do
    board = ["O", 2, 3, 
             "X", "O", 6, 
             "X", "X", "O"]
    assert winning_game?(board)
  end

  test "indicates game is over for win" do
    board = ["O", 2, 3, 
             "X", "O", 6, 
             "X", "X", "O"]
    assert game_over?(board)
  end

  test "indicates game is over for tie" do
    board = ["X", "O", "X", 
             "X", "O", "O", 
             "O", "X", "X"]
    assert game_over?(board)
  end

  test "indicates game is not over" do
    board = ["X", 2, "X", 
             4, "O", "O", 
             "O", "X", "X"]
    refute game_over?(board)
  end

end
