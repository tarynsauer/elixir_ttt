defmodule Game do
  import GameUtils
  import Board
  import Validators
  import Ui
  import MakeMove

  def new_game do
    board = get_board_size  
    player_x = get_player(x_marker)
    player_o = get_player(o_marker)
    play(board, player_x, player_o)
  end

  def play(board, player_x, player_o) do
    if game_over?(board) do
      game_over_message(board)      
    else
      get_next_move(board, player_x, player_o) |> play(player_x, player_o)
    end
  end
  
  def get_next_move(board, player_x, player_o) do
    request_player_move(current_player(board, player_x, player_o).marker) 
    print_board(board)
    make_move(current_player(board, player_x, player_o), board)     
  end

  def current_player(board, player_x, player_o) do
    if player_x_turn?(board), do: player_x, else: player_o 
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
