defmodule Ui do
  import Board, only: [get_row: 3] 
  import GameUtils, only: [row_count: 1, row_counter: 1]

  def print_line(text) do
    IO.puts text 
  end

  def print(text) do
    IO.write text
  end

  def get_input do
    input = IO.gets">"
    String.strip(input, ?\n)
  end

  def get_type do
    input = IO.getn">" 
    String.downcase(input)
  end

  def new_game_message do
    print_line "********* New Game *********"
  end

  def request_player_type(marker) do
    print_line "Enter player type for '#{marker}':"
  end

  def request_player_move(marker) do
    print_line "Player '#{marker}', make your move:"
  end

  def request_board_size do
    print_line "Enter number of board rows (3-6):"
  end

  def invalid_type_message(marker) do
    print "Invalid type. "
  end

  def invalid_move_message(marker) do
    print "Invalid move. "
  end

  def invalid_size_message do
    print "Invalid size. "
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

  def single_character?(value) do
    is_integer(value) && value > 9
  end

  def add_cell_dividers(row) do
    nums = Enum.map(row, fn(x) -> if single_character?(x), do: to_string(x) <> "| ", else: to_string(x) <> " | " end) |> Enum.join("")
    "| " <> nums
  end

  def row_to_string(board, first, last) do
    get_row(board, first, last) |> add_cell_dividers
  end

  def print_row(board, num_rows, index) do
    first = index * num_rows
    last =  num_rows * (index + 1) - 1
    print_line row_to_string(board, first, last)
  end

  def print_board(board) do
    num_rows = row_count(board)
    count = row_counter(num_rows)
    Enum.each count, fn index -> 
      print_row(board, num_rows, index)
    end
  end
  
end
