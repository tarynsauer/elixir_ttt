defmodule GameTest do
  use ExUnit.Case
  import Game 

  test "returns the marker of the current player" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert current_player(board) == "X"
  end

end
