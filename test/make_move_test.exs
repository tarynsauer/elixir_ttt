defmodule MakeMoveTest do
  use ExUnit.Case, async: true
  import MakeMove 
  import ExUnit.CaptureIO
  import TestHelper, only: [number_of_markers_on_board: 1]

  test "computer player makes random move" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    player = %ComputerPlayer{marker: "X"}
    assert number_of_markers_on_board(make_move(player, board)) == 1 
  end

  test "ai player makes first move" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    player = %AiPlayer{marker: "X"}
    assert make_move(player, board) == [1, 2, 3, 4, "X", 6, 7, 8, 9]
  end

  test "human player gets move" do
    capture_io([input: "5\n", capture_prompt: false], fn ->
      board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      player = %HumanPlayer{marker: "X"}
      assert make_move(player, board) == [1, 2, 3, 4, "X", 6, 7, 8, 9]
    end)
  end

end
