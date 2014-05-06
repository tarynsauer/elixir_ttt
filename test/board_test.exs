defmodule BoardTest do
  use ExUnit.Case, async: true
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

  test "cell is not open" do
    board = ["X", 2, 3, 4, 5, 6, 7, 8, 9]
    refute open_cell?(board, 0)
  end

  test "lists indexes of all open cells" do
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

  test "board is empty" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert empty_board?(board)
  end

  test "lists all row value lists" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert all_rows(board) == [[1, 2, 3], [4, 5, 6], [7, 8, 9]] 
  end

  test "lists all column value lists" do
    board = [1, 2, 3, 
             4, 5, 6, 
             7, 8, 9]
    assert all_cols(board) == [[1, 4, 7], [2, 5, 8], [3, 6, 9]] 
  end

  test "lists both diagonal value lists" do
    board = [1, 2, 3, 
             4, 5, 6, 
             7, 8, 9]
    assert all_diags(board) == [[1, 5, 9], [3, 5, 7]] 

  end

  test "player has a winning row" do
    board = [1, 2, 3, 
             "O", "O", 6, 
             "X", "X", "X"]
    assert winning_game?(board)
  end

  test "player has a winning column" do
    board = ["X", 2, 3, 
             "X", "O", 6, 
             "X", "O", 9]
    assert winning_game?(board)
  end

  test "player has a winning diagonal line" do
    board = ["O", 2, 3, 
             "X", "O", 6, 
             "X", "X", "O"]
    assert winning_game?(board)
  end
  
  test "game is over if a player won" do
    board = ["O", 2, 3, 
             "X", "O", 6, 
             "X", "X", "O"]
    assert game_over?(board)
  end

  test "game is over if there's a tie" do
    board = ["X", "O", "X", 
             "X", "O", "O", 
             "O", "X", "X"]
    assert game_over?(board)
  end

  test "game is not over" do
    board = ["X", 2, "X", 
             4, "O", "O", 
             "O", "X", "X"]
    refute game_over?(board)
  end

  test "returns center index for 3x3" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert center_cell_index(board) == 4
  end

  test "returns center index for 4x4" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    assert center_cell_index(board) == 7 
  end

end
