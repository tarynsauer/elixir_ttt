defmodule Board do
  import GameUtils

  def new_board(row_count) do
    Range.new(1, (row_count * row_count)) |> Enum.to_list
  end

  def get_row(board, first, last) do
    range = Range.new(first, last)
    Enum.slice(board, range)
  end

  def get_col(board, index, count, num_rows) do
    Enum.map(count, fn(n) -> (cell_val(board, (index + (n * num_rows)))) end)
  end

  def get_diag(board, index, step_val, count, num_rows) do
    if index == 0 do
      Enum.map(count, fn(n) -> (cell_val(board, (index + n) * step_val)) end)
    else
      Enum.map(count, fn(n) -> (cell_val(board, index + (n * step_val))) end)
    end
  end

  def all_rows(board) do
    num_rows = row_count(board)
    count = row_counter(num_rows)
    Enum.map count, fn(i) -> 
      get_row(board, (i * num_rows), ((i + 1) * num_rows) - 1)
    end
  end

  def all_cols(board) do
    num_rows = row_count(board)
    count = row_counter(num_rows)
    Enum.map count, fn(index) -> 
      get_col(board, index, count, num_rows)
    end
  end

  def all_diags(board) do
    num_rows = row_count(board)
    count = row_counter(num_rows)
    [get_diag(board, List.first(count), (num_rows + 1), count, num_rows),
    get_diag(board, List.last(count), (num_rows - 1), count, num_rows)]
  end

  def open_cells(board) do
    Enum.filter_map(board, fn(x) -> is_integer(x) end, &(&1 - 1))
  end

  def open_cell?(board, cell_index) do
    Enum.at(board, cell_index) |> is_integer
  end

  def add_marker(board, cell_index) do
    marker = current_player_marker(board)
    List.replace_at(board, cell_index, marker)
  end

  def make_random_move(board) do
    cell_index = List.first(Enum.shuffle(open_cells(board)))
    add_marker(board, cell_index)
  end

  def board_full?(board) do
    Enum.filter(board, fn(x) -> is_integer(x) end) |> Enum.empty?
  end

  def empty_board?(board) do
    Enum.all?(board, fn(x) -> is_integer(x) end)
  end

  def winning_game?(board) do
    lines = all_rows(board) ++ all_cols(board) ++ all_diags(board)
    Enum.any?(lines, fn(line) -> winning_line?(line) end)
  end

  def winning_line?(line) do
    (length Enum.uniq(line)) == 1
  end

  def game_over?(board) do
    winning_game?(board) || board_full?(board)    
  end

  def center_cell_index(board) do
    (round (length board) / 2) - 1
  end
end
