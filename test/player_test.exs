defmodule PlayerTest do
  use ExUnit.Case
  import Player

  test "creates a new player" do
    player = create_player("X", "human") 
    assert player.marker == "X" 
    assert player.type == "human"
  end

end
