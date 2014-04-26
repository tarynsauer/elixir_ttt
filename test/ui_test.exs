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

end
