defmodule Run do
  import Game, only: [new_game: 0]

  def main(_) do
    new_game 
  end
end
