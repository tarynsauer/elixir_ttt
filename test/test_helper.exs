defmodule TestHelper do
  ExUnit.start
  ExUnit.configure exclude: [integration: true]

  def number_of_markers_on_board(board) do
    length Enum.filter(board, fn(x) -> !is_integer(x) end)
  end
end
