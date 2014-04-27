defmodule Game do
  import Integer
  import Board
  
  @x_marker "X"
  @o_marker "O"
  # def new_game do
  #   board = create_board  
  #   player_x = get_player(:X)
  #   player_o = get_player(:O)
  #   play(board, player_x, player_o)
  # end
  #
  # def play(board, player_x, player_o) do
  #
  # end

  def current_player(board) do
    x_count = Enum.filter(board, fn(x) -> x == @x_marker end)
    if even?(length x_count), do: @x_marker, else: @o_marker 
  end

end
