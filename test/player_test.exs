defmodule PlayerTest do
  use ExUnit.Case, async: true
  import Player

  test "creates a new player" do
    player = create_player("X", "h") 
    assert player.marker == "X" 
  end

end
