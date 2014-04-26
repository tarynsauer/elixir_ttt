defmodule Player do
  defstruct marker: "X", type: "human"

  def create_player(marker, type) do
    %Player{marker: marker, type: type}
  end

end
