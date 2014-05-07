defmodule GameTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  import Game 

  test "returns player with X marker" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    player_x = %HumanPlayer{marker: "X"}
    player_o = %HumanPlayer{marker: "O"}
    assert current_player(board, player_x, player_o) == player_x 
  end
  
  test "returns player with O marker" do
    board = ["X", "O", "X", 4, 5, 6, 7, 8, 9]
    player_x = %HumanPlayer{marker: "X"}
    player_o = %HumanPlayer{marker: "O"}
    assert current_player(board, player_x, player_o) == player_o 
  end

  test "prints tie game message for tie board" do
     board = ["X", "O", "X", "X", "O", "O", "O", "X", "X"] 
     assert capture_io(fn ->
       game_over_message(board) 
     end) == "\n**** Game Over ****\nIt's a tie!\n| X | O | X | \n| X | O | O | \n| O | X | X | \n"
  end

  test "prints winning game message for winning board" do
     board = ["O", "O", 3, 
              "X", "O", "X", 
              "X", "X", "O"] 
     assert capture_io(fn ->
       game_over_message(board) 
     end) == "\n**** Game Over ****\nPlayer 'O' wins!\n| O | O | 3 | \n| X | O | X | \n| X | X | O | \n"
  end

  test "prints game over message for winning board" do
    player_x = %ComputerPlayer{marker: "X"}
    player_o = %HumanPlayer{marker: "O"}
     board = ["O", "O", 3, 
              "X", "O", "X", 
              "X", "X", "O"] 
     assert capture_io(fn ->
       play(board, player_x, player_o) 
     end) == "\n**** Game Over ****\nPlayer 'O' wins!\n| O | O | 3 | \n| X | O | X | \n| X | X | O | \n"
  end

end
