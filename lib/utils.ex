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

end
