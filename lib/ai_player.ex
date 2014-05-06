defmodule AiPlayer do
  defstruct marker: "X" 
  @win 1
  @lose -1
  @tie 0
  @neg_inf -999
  @pos_inf 999
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
    apply_minimax(add_marker(board, cell), ai_marker, ai_marker, 1, {@neg_inf, @pos_inf})     
  end

  def alphabeta(board, ai_marker, marker, depth, alphabeta) do
    cells = open_cells(board)
    Enum.reduce(cells, alphabeta, fn (cell, acc) ->
      if need_best_move?(acc) do
        score = apply_minimax(add_marker(board, cell), ai_marker, current_player_marker(board), (depth + 1), acc) / depth
        alpha = get_alpha(ai_marker, marker, score, acc)
        beta = get_beta(ai_marker, marker, score, acc)
        acc = {alpha, beta}
      end
      acc
    end) |> return_best_score(marker, ai_marker)
  end

  def apply_minimax(board, ai_marker, marker, depth, alphabeta) do
    if game_over?(board) do
      score(board, ai_marker)
    else
      alphabeta(board, ai_marker, current_player_marker(board), depth, alphabeta)
    end
  end

  def need_best_move?(alphabeta) do
    elem(alphabeta, 0) < elem(alphabeta, 1)
  end

  def maximizing_player?(marker, ai_marker) do
    marker != ai_marker
  end

  def return_best_score(alphabeta, marker, ai_marker) do
    if (marker == ai_marker), do: elem(alphabeta, 0), else: elem(alphabeta, 1) 
  end

  def get_alpha(ai_marker, marker, score, alphabeta) do
    alpha = elem(alphabeta, 0)
    if maximizing_player?(marker, ai_marker) do  
      alpha
    else
      if score > alpha, do: score, else: alpha
    end
  end

  def get_beta(ai_marker, marker, score, alphabeta) do
    beta = elem(alphabeta, 1)
    if maximizing_player?(marker, ai_marker) do  
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
