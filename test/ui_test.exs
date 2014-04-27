defmodule UiTest do
  use ExUnit.Case
  import Ui
  import ExUnit.CaptureIO

  test "requests player type" do
     assert capture_io(fn ->
       request_player_type("X")
     end) == "Enter player type for X:\n" 
  end

  test "requests player move" do
    assert capture_io(fn ->
       request_player_move("X")
     end) == "Player X, make your move:\n" 
  end

  test "normalizes player type input" do
    assert capture_io([input: "Human", capture_prompt: false], fn ->
      input = get_input 
      IO.write input
    end) == "human"
  end

  test "prints invalid type message" do
     assert capture_io(fn ->
       invalid_type_message("X")
     end) == "Invalid type.\nEnter player type for X:\n" 
  end

  test "prints invalid move message" do
     assert capture_io(fn ->
       invalid_move_message("X")
     end) == "Invalid move.\nPlayer X, make your move:\n" 
  end

  test "prints board" do
     assert capture_io(fn ->
       print_board(["X", 2, 3, 4, 5, 6, 7, 8, 9])
     end) == "X 2 3\n4 5 6\n7 8 9\n" 
  end

end
