defmodule BoardTest do
  use ExUnit.Case
  import Board 
  import TestHelper, only: [number_of_markers_on_board: 1]

  test "creates a new 3 x 3 board" do
    board = new_board(3)
    assert board == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "creates a new 4 x 4 board" do
    board = new_board(4)
    assert board == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
  end

  test "gets column values" do
    board = new_board(3)
    assert get_col(board, 0, [0, 1, 2], 3) == [1, 4, 7]
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

  test "returns a list of row value lists" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert all_rows(board) == [[1, 2, 3], [4, 5, 6], [7, 8, 9]] 
  end

  test "returns a list of column value lists" do
    board = [1, 2, 3, 
             4, 5, 6, 
             7, 8, 9]
    assert all_cols(board) == [[1, 4, 7], [2, 5, 8], [3, 6, 9]] 
  end

  test "returns a list of diagonal value lists" do
    board = [1, 2, 3, 
             4, 5, 6, 
             7, 8, 9]
    assert all_diags(board) == [[1, 5, 9], [3, 5, 7]] 

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
