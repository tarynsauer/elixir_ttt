import Ui, only: [get_input: 0]
import Validators, only: [validate_move, 3]

defprotocol MakeMove do
  @doc "Returns cell index of player move"
  @only [HumanPlayer, ComputerPlayer, AiPlayer]
  def make_move(player, board)
end

defimpl MakeMove, for: HumanPlayer do
  def make_move(_, board) do
    move = get_input 
    #validate_move(board, move, player.marker) 
  end
end

defimpl MakeMove, for: ComputerPlayer do
  def make_move(_, board) do 
    # make_random_move(board, player.marker)
  end
end

defimpl MakeMove, for: AiPlayer do
  def make_move(_, board), do: "ai move" 
end
