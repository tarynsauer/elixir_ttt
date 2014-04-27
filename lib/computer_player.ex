defmodule ComputerPlayer do
  import Board, only: [add_marker: 3]

  defstruct marker: "X" 

  def all_open_cells(board) do
    Enum.filter_map(board, fn(x) -> is_integer(x) end, &(&1 - 1))
  end

  def make_random_move(board, marker) do
    cell_index = List.first(Enum.shuffle(board)) - 1
    add_marker(board, marker, cell_index)
  end
end
