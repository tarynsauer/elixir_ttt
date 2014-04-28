defmodule GameTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Game 
  import TestHelper, only: [number_of_markers_on_board: 1]

  test "returns the marker of the current player" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    player_x = %HumanPlayer{marker: "X"}
    player_o = %HumanPlayer{marker: "O"}
    assert current_player(board, player_x, player_o) == player_x 
  end

  test "returns the marker of the current player" do
    board = ["X", "O", "X", 4, 5, 6, 7, 8, 9]
    player_x = %HumanPlayer{marker: "X"}
    player_o = %HumanPlayer{marker: "O"}
    assert current_player(board, player_x, player_o) == player_o 
  end

  test "indicates whether it's X's turn" do
    board = ["X", "O", "X", 4, 5, 6, 7, 8, 9]
    refute x_player_turn?(board)
  end

  test "returns marker of the current player's opponent" do
    board = ["X", "O", "X", 4, 5, 6, 7, 8, 9]
    assert winning_marker(board) == "X"
  end

  test "promps player for move" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    player_x = %ComputerPlayer{marker: "X"}
    player_o = %HumanPlayer{marker: "O"}
    assert number_of_markers_on_board(get_next_move(board, player_x, player_o))
    == 1 
  end

  test "prints tie game message for tie board" do
     board = ["X", "O", "X", "X", "O", "O", "O", "X", "X"] 
     assert capture_io(fn ->
       game_over_message(board) 
     end) =="Game over.\nIt's a tie!\nX O X\nX O O\nO X X\n"
  end

  test "prints winning game message for winning board" do
     board = ["O", "O", 3, 
              "X", "O", "X", 
              "X", "X", "O"] 
     assert capture_io(fn ->
       game_over_message(board) 
     end) =="Game over.\nPlayer 'O' wins!\nO O 3\nX O X\nX X O\n"
  end

  test "prints game over message for winning board" do
    player_x = %ComputerPlayer{marker: "X"}
    player_o = %HumanPlayer{marker: "O"}
     board = ["O", "O", 3, 
              "X", "O", "X", 
              "X", "X", "O"] 
     assert capture_io(fn ->
       play(board, player_x, player_o) 
     end) =="Game over.\nPlayer 'O' wins!\nO O 3\nX O X\nX X O\n"
  end

end
