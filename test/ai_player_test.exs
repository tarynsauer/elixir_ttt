defmodule AiPlayerTest do
  use ExUnit.Case
  import AiPlayer 
  import TestHelper, only: [number_of_markers_on_board: 1]

  test "if winning board, returns win score" do
     board = ["X", "X", "X", "O", "O", 6, 7, 8, 9]
     assert score(board, "X") == 1
  end

  test "if no-win board, returns tie score" do
     board = ["X", "X", 3, "O", "O", 6, 7, 8, 9]
     assert score(board, "X") == 0 
  end

  test "if losing board, returns lose score" do
     board = ["X", "X", 3, "O", "O", "O", 7, 8, "X"]
     assert score(board, "X") == -1 
  end

  test "chooses random cell for empty board" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert number_of_markers_on_board(ai_move(board, "X")) == 1 
  end

  test "takes winning move" do
    board = [1, "X", "X", 
             "X", "O", "O", 
             "X", "O", "O"]
    assert ai_move(board, "X") == ["X", "X", "X", "X", "O", "O", "X", "O", "O"] 
  end

  test "takes winning space when one is available" do
    board = [1, "X", "X", 
              4, "O", "O", 
               7, 8, 9]
    assert best_move(board, "X") == 0 
  end

  test "takes winning row space when one is available" do
    board = [1, "X", "X", 
              4, "O", "O", 
               7, 8, 9]
    assert best_move(board, "X") == 0 
  end

  test "takes winning diagonal space when one is available" do
    board = [1, "O", "X", 
              4, "X", "O", 
               7, 8, 9]
    assert best_move(board, "X") == 6 
  end

  test "blocks opponent win" do
    board = [1, "X", "X", 
             "X", "O", "O", 
             "O", "X", 9]
    assert best_move(board, "O") == 0 
  end

  test "chooses win over block" do
    board = [1, "X", "X", 
             4, "O", "O", 
             "O", "X", "X"]
    assert best_move(board, "O") == 3 
  end

  test "chooses win over block or non-win" do
    board = [1, "O", "O", 
             4, "X", "X", 
             "X", 8, "O"]
    assert best_move(board, "X") == 3 
  end

  test "chooses block over multiple non-wins" do
    board = [1, "O", "O", 
             4, 5, "X", 
             "X", 8, 9]
    assert best_move(board, "X") == 0 
  end

  test "chooses opposite side with one side cell taken" do
    board = [1, "X", 3, 
             4, 5, 6, 
             7, 8, 9]
    assert best_move(board, "O") == 7 
  end

  test "chooses win when same cell is block and win" do
    board = [1, "X", "X", 
             4, "O", 6, 
             7, "X", "O"]
    assert best_move(board, "O") == 0 
  end

  test "chooses center cell for the win" do
    board = ["O", "X", "X", 
              4, 5, 6, 
              7, "X", "O"]
    assert best_move(board, "O") == 4 
  end

  test "chooses pre-emptive block" do
    board = ["X", 2, "O", 
              "O", 5, 6, 
              "X", 8, 9]
    assert best_move(board, "X") == 8 
  end

  test "chooses middle for the win" do
    board = ["X", 2, "O", 
              "O", 5, 6, 
              "X", "O", "X"]
    assert best_move(board, "X") == 4 
  end

  test "chooses side for the win" do
    board = ["X", 2, "O", 
              "O", "O", 6, 
              "X", 8, "X"]
    assert best_move(board, "X") == 7 
  end

end
