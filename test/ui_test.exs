defmodule UiTest do
  use ExUnit.Case
  import Ui
  import ExUnit.CaptureIO

  test "requests player type" do
     assert capture_io(fn ->
       request_player_type("X")
     end) == "Enter player type for X:\n" 
  end

  test "normalizes player type input" do
    assert capture_io([input: "Human", capture_prompt: false], fn ->
      input = get_input 
      IO.write input
    end) == "human"
  end

  test "prints board" do
     assert capture_io(fn ->
       print_board(["X", 2, 3, 4, 5, 6, 7, 8, 9])
     end) == "X 2 3\n4 5 6\n7 8 9\n" 
  end

end
