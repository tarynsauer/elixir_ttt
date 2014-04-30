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
    apply_minimax(add_marker(board, cell), ai_marker, ai_marker, 1, [0, -999, 999])     
  end

  def alphabeta(board, ai_marker, marker, depth, values) do
    Enum.flat_map_reduce(board, values, fn cell, acc ->
      if no_break?(acc) do
        apply_minimax(add_marker(board, cell),
        ai_marker, current_player_marker(board), depth, acc)
      else
        {:halt, acc}  ##need to return score,
      end
    end)
  end

  def apply_minimax(board, ai_marker, marker, depth, acc) do
    if game_over?(board) do
      score(board, ai_marker)
    else
      score = alphabeta(board, ai_marker, current_player_marker(board), (depth + 1), acc)
      alpha = get_alpha(ai_marker, marker, acc, score)
      beta = get_beta(ai_marker, marker, acc, score)
      [score, alpha, beta]
    end
  end

  def no_break?(acc) do
    Enum.at(acc, 2) < Enum.at(acc, 1)
  end

  def get_alpha(ai_marker, marker, acc, score) do
    alpha = Enum.at(acc, 1)
    if marker == ai_marker do  ### Might be opposite
      alpha
    else
      if score > alpha, do: score, else: alpha
    end
  end

  def get_beta(ai_marker, marker, acc, score) do
    beta = Enum.at(acc, 2)
    if marker == ai_marker do  ### Might be opposite
      if score < beta, do: score, else: beta
    else
      beta
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
