defmodule Board do
  def create_board do
    [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def open_cell?(board, cell_index) do
    cell_value = Enum.at(board, cell_index)
    is_integer(cell_value)
  end

  def add_marker(board, marker, cell_index) do
    List.replace_at(board, cell_index, marker)
  end

end
