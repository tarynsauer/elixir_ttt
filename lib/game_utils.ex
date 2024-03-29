defmodule GameUtils do
  import Integer, only: [even?: 1]
  @x_marker "X"
  @o_marker "O"
  
  def x_marker do
    @x_marker
  end

  def o_marker do
    @o_marker
  end

  def has_marker?(cell) do
    !is_integer(cell)
  end

  def current_player_marker(board) do
    if player_x_turn?(board), do: x_marker, else: o_marker 
  end

  def player_x_turn?(board) do
    Enum.filter(board, fn(cell) -> has_marker?(cell) end) |> length |> even?
  end

  def winning_marker(board) do
    if player_x_turn?(board), do: o_marker, else: x_marker 
  end

  def row_count(board) do
    Enum.count(board) |> :math.sqrt |> round
  end

  def row_counter(num_rows) do
    Range.new(0, num_rows - 1) |> Enum.to_list
  end

  def cell_val(board, index) do
    Enum.at(board, index)
  end
  
  def parse_integer(string) do
    elem(Integer.parse(string), 0)
  end

end
