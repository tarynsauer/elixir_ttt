defmodule Player do
  @human_player "h"
  @computer_player "c"
  @ai_player "a"

  def create_player(marker, type) do
    case type do
      @human_player ->
        create_human_player(marker) 
      @computer_player ->
        create_computer_player(marker) 
      @ai_player ->
        create_ai_player(marker)   
    end
  end

  def create_human_player(marker) do
    %HumanPlayer{marker: marker}
  end

  def create_computer_player(marker) do
    %ComputerPlayer{marker: marker}
  end

  def create_ai_player(marker) do
    %AiPlayer{marker: marker}
  end

  def player_types do
    [@human_player, @computer_player, @ai_player]
  end

end
