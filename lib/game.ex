defmodule Game do
  import Integer
  import Board
  import Validators
  import Ui
  import MakeMove

  @x_marker "X"
  @o_marker "O"

  def new_game do
    board = get_board_size  
    player_x = get_player(@x_marker)
    player_o = get_player(@o_marker)
    play(board, player_x, player_o)
  end

  def play(board, player_x, player_o) do
    if game_over?(board) do
      game_over_message(board)      
    else
      board = get_next_move(board, player_x, player_o)
      play(board, player_x, player_o)
    end
  end
  
  def get_next_move(board, player_x, player_o) do
    request_player_move(current_player(board, player_x, player_o).marker) 
    print_board(board)
    make_move(current_player(board, player_x, player_o), board)     
  end

  def player_x_turn?(board) do
    marker_count = Enum.filter(board, fn(x) -> !is_integer(x) end)
    even?(length marker_count) 
  end

  def current_player(board, player_x, player_o) do
    if player_x_turn?(board), do: player_x, else: player_o 
  end

  def winning_marker(board) do
    if player_x_turn?(board), do: @o_marker, else: @x_marker 
  end

  def game_over_message(board) do
    if winning_game?(board) do
      winning_game_message(winning_marker(board))
    else
      tie_game_message
    end
    print_board(board)
  end

end
