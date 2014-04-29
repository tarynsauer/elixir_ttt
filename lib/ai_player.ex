defmodule AiPlayer do
  defstruct marker: "X" 
  @win 1
  @lose -1
  @tie 0
  import Utils
  import Board

  def ai_move(board, marker) do
    if empty_board?(board) do
      make_random_move(board, marker) 
    else
      add_marker(board, best_move(board, marker))
    end
  end

  def best_move(board, current_player_marker) do
    best_scored_move = Enum.max(scored_moves(board, current_player_marker))
    Enum.at(best_scored_move, 1)
  end

  def scored_moves(board, current_player_marker) do
    cells = open_cells(board)
    Enum.map(cells, fn cell -> 
    [move_score(board, current_player_marker, cell)] ++ [cell] end)    
  end

  def move_score(board, current_player_marker, cell) do
    apply_minimax(add_marker(board, cell), current_player_marker,
    current_player_marker, 1)     
  end

  def minimax(board, current_player_marker, marker, depth) do
    cells = open_cells(board)
    Enum.map(cells, fn cell -> (apply_minimax(add_marker(board,
    cell), current_player_marker, current_player_marker(board), (depth + 1)) / depth) end)     
  end

  def apply_minimax(board, current_player_marker, marker, depth) do
    if game_over?(board) do
      score(board, current_player_marker)
    else
      scores = minimax(board, current_player_marker, marker, depth)
      if current_player_marker == marker do
        Enum.min(scores)
      else
        Enum.max(scores)
      end
    end
  end

  def current_player_win?(board, marker) do
    winning_marker(board) == marker
  end

  def score(board, current_player_marker) do
    if winning_game?(board) do
      if current_player_marker(board) != current_player_marker, do: @win, else: @lose 
    else
      @tie
    end
  end

end
