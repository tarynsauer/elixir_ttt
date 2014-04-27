defmodule GameTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Game 

  test "returns the marker of the current player" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    player_x = %HumanPlayer{marker: "X"}
    player_o = %HumanPlayer{marker: "O"}
    assert current_player(board, player_x, player_o) == player_x 
  end

  test "returns the marker of the current player" do
    board = ["X", "O", "X", 4, 5, 6, 7, 8, 9]
    player_x = %HumanPlayer{marker: "X"}
    player_o = %HumanPlayer{marker: "O"}
    assert current_player(board, player_x, player_o) == player_o 
  end

  # test "promps player for move" do
  #   board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  #   player_x = %HumanPlayer{marker: "X"}
  #   player_o = %HumanPlayer{marker: "O"}
  #   assert capture_io([input: "1", capture_prompt: false], fn ->
  #     input = get_next_move(board, player_x, player_o)
  #     IO.write input
  #   end) == 0 
  #
  # end

end
