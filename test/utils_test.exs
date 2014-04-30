defmodule UtilsTest do
  use ExUnit.Case
  import Utils 

  test "returns number of rows in the board" do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert row_count(board) == 3 
  end

end
