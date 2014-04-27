defmodule Game do
  import Integer
  import Board
  import Validators
  import Ui, only: [request_player_move: 1]
  import HumanPlayer
  import ComputerPlayer
  import AiPlayer
  import MakeMove
  
  @x_marker "X"
  @o_marker "O"
  
  def new_game do
    board = new_board  
    player_x = get_player(@x_marker)
    player_o = get_player(@o_marker)
    play(board, player_x, player_o)
  end

  def play(board, player_x, player_o) do
    # loops through until board game_over
    # prompts current player for move
    # prints game over message 
  end

  def current_player(board, player_x, player_o) do
    x_count = Enum.filter(board, fn(x) -> x == (@x_marker || @o_marker) end)
    if even?(length x_count), do: player_x, else: player_o 
  end

  def get_next_move(board, player_x, player_o) do
    request_player_move(current_player(board, player_x, player_o).marker) 
    make_move(current_player(board, player_x, player_o), board)     
  end

end
