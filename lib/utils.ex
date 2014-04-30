defmodule Utils do
  import Integer
  @x_marker "X"
  @o_marker "O"

  def x_player_turn?(board) do
    marker_count = Enum.filter(board, fn(x) -> !is_integer(x) end)
    even?(length marker_count) 
  end

  def winning_marker(board) do
    if x_player_turn?(board), do: @o_marker, else: @x_marker 
  end

  def current_player_marker(board) do
    if x_player_turn?(board), do: @x_marker, else: @o_marker 
  end

  def row_count(board) do
    round(:math.sqrt(Enum.count(board)))
  end

  def row_counter(num_rows) do
    Enum.to_list(Range.new(0, num_rows - 1)) 
  end

  def cell_val(board, index) do
    Enum.at(board, index)
  end
  
  def parse_integer(string) do
    elem(Integer.parse(string), 0)
  end

end
