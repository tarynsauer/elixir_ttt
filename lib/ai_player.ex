defmodule AiPlayer do
  defstruct marker: "X" 
  @win 1
  @lose -1
  @tie 0
  import Utils
  import Board

  def ai_move(board, ai_marker) do
    if empty_board?(board) do
      make_random_move(board) 
    else
      add_marker(board, best_move(board, ai_marker))
    end
  end

  def best_move(board, ai_marker) do
    best_scored_move = Enum.max(scored_moves(board, ai_marker))
    Enum.at(best_scored_move, 1)
  end

  def scored_moves(board, ai_marker) do
    cells = open_cells(board)
    Enum.map(cells, fn cell -> 
    [move_score(board, ai_marker, cell)] ++ [cell] end)    
  end

  def move_score(board, ai_marker, cell) do
    apply_minimax(add_marker(board, cell), ai_marker,
    ai_marker, 1)     
  end

  def minimax(board, ai_marker, marker, depth) do
    cells = open_cells(board)
    Enum.map(cells, fn cell -> (apply_minimax(add_marker(board,
    cell), ai_marker, current_player_marker(board), (depth + 1)) / depth) end)     
  end

  def apply_minimax(board, ai_marker, marker, depth) do
    if game_over?(board) do
      score(board, ai_marker)
    else
      scores = minimax(board, ai_marker, marker, depth)
      if ai_marker == marker do
        Enum.min(scores)
      else
        Enum.max(scores)
      end
    end
  end

  def ai_player_win?(board, ai_marker) do
   current_player_marker(board) != ai_marker
  end

  def score(board, ai_marker) do
    if winning_game?(board) do
      if ai_player_win?(board, ai_marker), do: @win, else: @lose 
    else
      @tie
    end
  end

end
