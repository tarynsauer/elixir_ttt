defmodule Ui do

  def print_message(message) do
    IO.puts message
  end

  def get_input do
    input = IO.gets ">"
    String.downcase(input)
  end

  def request_player_type(marker) do
    print_message "Enter player type for #{marker}:"
  end

end
