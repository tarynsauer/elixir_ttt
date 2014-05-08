defmodule IntegrationTest do
  use ExUnit.Case, async: true
  import Game 
  import Validators, only: [validate_move: 3]
  import TestHelper, only: [number_of_markers_on_board: 1]

  @moduletag :integration

  test "promps player for move" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    player_x = %ComputerPlayer{marker: "X"}
    player_o = %HumanPlayer{marker: "O"}
    assert number_of_markers_on_board(get_next_move(board, player_x, player_o))
    == 1 
  end

  test "does not add invalid move" do
    board = ["X", 2, 3, 4, 5, 6, 7, 8, 9]
    assert validate_move(board, "1", "O") == ["X", 2, 3, 4, 5, 6, 7, 8, 9]
  end

end
