defmodule UiTest do
  use ExUnit.Case, async: true
  import Ui
  import ExUnit.CaptureIO
  
  test "prints new game message" do
    assert capture_io(fn ->
      new_game_message
    end) == "********* New Game *********\n" 
  end

  test "prints row" do
    assert capture_io(fn ->
      print_row([1, 2, 3, 4, 5, 6, 7, 8, 9], 3, 0) 
    end) == "| 1 | 2 | 3 | \n" 
  end

  test "requests player type" do
    assert capture_io(fn ->
      request_player_type("X")
    end) == "Enter player type for 'X':\n" 
  end

  test "requests board size" do
    assert capture_io(fn ->
      request_board_size
    end) == "Enter number of board rows (3-6):\n" 
  end

  test "requests player move" do
    assert capture_io(fn ->
       request_player_move("X")
     end) == "Player 'X', make your move:\n" 
  end

  test "normalizes player type input" do
    capture_io([input: "Human\n", capture_prompt: false], fn ->
      type = get_type 
      assert type == "h"
    end)
  end

  test "returns player move input" do
    capture_io([input: "16\n", capture_prompt: false], fn ->
      input = get_input 
      assert input == "16"
    end)
  end

  test "prints invalid type message" do
     assert capture_io(fn ->
       invalid_type_message("X")
     end) == "Invalid type. " 
  end

  test "prints invalid move message" do
    assert capture_io(fn ->
      invalid_move_message("X")
    end) == "Invalid move. " 
  end

  test "prints invalid size message" do
    assert capture_io(fn ->
      invalid_size_message
    end) == "Invalid size. " 
  end

  test "prints 3x3 board" do
    assert capture_io(fn ->
      print_board(["X", 2, 3, 4, 5, 6, 7, 8, 9])
    end) == "| X | 2 | 3 | \n| 4 | 5 | 6 | \n| 7 | 8 | 9 | \n"
  end

  test "prints 4x4 board" do
    assert capture_io(fn ->
      print_board(["X", 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])
    end) == "| X | 2 | 3 | 4 | \n| 5 | 6 | 7 | 8 | \n| 9 | 10| 11| 12| \n| 13| 14| 15| 16| \n"
  end

  test "prints game over message for tie game" do
    assert capture_io(fn ->
       tie_game_message
     end) == "Game over. It's a tie!\n" 
  end

  test "prints game over message for winning game" do
    assert capture_io(fn ->
       winning_game_message("X")
     end) == "Game over. Player 'X' wins!\n" 
  end

end
