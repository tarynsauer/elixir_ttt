defmodule PlayerTest do
  use ExUnit.Case, async: true
  import Player

  test "creates a human player" do
    player = create_player("X", "h") 
    assert player.__struct__ == HumanPlayer 
  end

  test "creates a computer player" do
    player = create_player("X", "c") 
    assert player.__struct__ == ComputerPlayer 
  end

  test "creates an ai player" do
    player = create_player("X", "a") 
    assert player.__struct__ == AiPlayer 
  end

  test "human player has a marker" do
    player = create_player("X", "h") 
    assert player.marker == "X" 
  end

  test "computer player has a marker" do
    player = create_player("X", "c") 
    assert player.marker == "X" 
  end

  test "ai player has a marker" do
    player = create_player("X", "a") 
    assert player.marker == "X" 
  end

end
