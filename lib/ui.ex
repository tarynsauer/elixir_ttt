defmodule Ui do

  def print_line(text) do
    IO.puts text 
  end

  def get_input do
    input = IO.gets ">"
    String.downcase(input)
  end

  def request_player_type(marker) do
    print_line "Enter player type for #{marker}:"
  end

  def print_row(row) do
    print_line Enum.join(row, " ")
  end

  def get_row(board, first, last) do
    range = Range.new(first, last)
    Enum.slice(board, range)
  end

  def print_board(board) do
    print_row get_row(board, 0, 2) 
    print_row get_row(board, 3, 5)
    print_row get_row(board, 6, 8) 
  end
end
