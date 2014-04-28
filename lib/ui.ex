defmodule Ui do
  import Board, only: [get_row: 3] 

  def print_line(text) do
    IO.puts text 
  end

  def print(text) do
    IO.write text
  end

  def get_input do
    input = IO.gets ">"
    input = String.downcase(input)
    String.slice(input, 0..0)
  end

  def request_player_type(marker) do
    print_line "Enter player type for #{marker}:"
  end

  def request_player_move(marker) do
    print_line "Player #{marker}, make your move:"
  end

  def invalid_type_message(marker) do
    print "Invalid type. "
  end

  def invalid_move_message(marker) do
    print "Invalid move. "
  end

  def game_over_message do
    print "Game over. "
  end

  def tie_game_message do
   game_over_message
   print_line "It's a tie!"
  end

  def winning_game_message(marker) do
    game_over_message
    print_line "Player '#{marker}' wins!"
  end

  def print_row(row) do
    print_line Enum.join(row, " ")
  end

  def print_board(board) do
    print_row get_row(board, 0, 2) 
    print_row get_row(board, 3, 5)
    print_row get_row(board, 6, 8) 
  end
  
end
