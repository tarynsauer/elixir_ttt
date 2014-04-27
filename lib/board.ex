defmodule Board do
  @standard_board [1, 2, 3, 4, 5, 6, 7, 8, 9]

  def new_board do
    @standard_board
  end

  def get_row(board, first, last) do
    range = Range.new(first, last)
    Enum.slice(board, range)
  end

  def get_col(board, first, last) do
    middle = first + 3
    [Enum.at(board, first), Enum.at(board, middle), Enum.at(board, last)]
  end

  def get_diag(board, first, last) do
    [Enum.at(board, first), Enum.at(board, 4), Enum.at(board, last)]
  end

  def open_cell?(board, cell_index) do
    cell_value = Enum.at(board, cell_index)
    is_integer(cell_value)
  end

  def add_marker(board, marker, cell_index) do
    List.replace_at(board, cell_index, marker)
  end

  def board_full?(board) do
    open_cells = Enum.filter(board, fn(x) -> (x != "X") && (x != "O") end)
    Enum.empty?(open_cells)
  end

  def winning_game?(board) do
    winning_row?(board) || winning_col?(board) || winning_diag?(board)
  end

  def winning_row?(board) do
    winning_line?(get_row(board, 0, 2)) || winning_line?(get_row(board, 3, 5)) ||
  winning_line?(get_row(board, 6, 8))
  end

  def winning_col?(board) do
    winning_line?(get_col(board, 0, 6)) || winning_line?(get_col(board, 1, 7))
    || winning_line?(get_col(board, 2, 9))
  end

  def winning_diag?(board) do
    winning_line?(get_diag(board, 0, 8)) || winning_line?(get_diag(board, 2, 6))
  end

  def winning_line?(line) do
    (length Enum.uniq(line)) == 1
  end

  def game_over?(board) do
    winning_game?(board) || board_full?(board)    
  end

end
