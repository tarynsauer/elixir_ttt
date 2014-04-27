defmodule Player do
  @human_player "human"
  @computer_player "computer"
  @ai_player "ai"

  defstruct marker: "X", type: @human_player 

  def create_player(marker, type) do
    %Player{marker: marker, type: type}
  end

  def player_types do
    [@human_player, @computer_player, @ai_player]
  end

end
