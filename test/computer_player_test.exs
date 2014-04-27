defmodule ComputerPlayerTest do
  use ExUnit.Case
  import ComputerPlayer 

  def number_of_markers_on_board(board) do
    length Enum.filter([1, 2, "X"], fn(x) -> x == "X" end)
  end

  test "returns list of indexes of all open cells" do
     board = [1, 2, 3, "X", 5, 6, 7, 8, 9]
    assert all_open_cells(board) == [0, 1, 2, 4, 5, 6, 7, 8]
  end

  test "places move in a random open cell" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert number_of_markers_on_board(make_random_move(board, "X")) == 1 
  end

end
