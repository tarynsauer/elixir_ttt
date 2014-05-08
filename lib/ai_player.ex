defmodule AiPlayer do
  import GameUtils
  import Board

  defstruct marker: x_marker 

  @win 1
  @lose -1
  @tie 0
  @neg_inf -999
  @pos_inf 999

  def ai_move(board, ai_marker) do
    if empty_board?(board) do
      take_center_cell(board) 
    else
      add_marker(board, best_move(board, ai_marker))
    end
  end
  
  def best_move(board, ai_marker) do
    Enum.max(scored_moves(board, ai_marker)) |> Enum.at(1)
  end

  def scored_moves(board, ai_marker) do
    open_cells(board) |> Enum.map(fn cell -> 
    [move_score(board, ai_marker, cell)] ++ [cell] end)    
  end

  def move_score(board, ai_marker, cell) do
    add_marker(board, cell)
    |> apply_minimax(ai_marker, 1, {@neg_inf, @pos_inf})     
  end

  def alphabeta(board, ai_marker, depth, alphabeta) do
    open_cells(board) |> Enum.reduce(alphabeta, fn (cell, acc) ->
      if search_tree?(acc) do
        marker = current_player_marker(board)
        new_board = add_marker(board, cell)
        score = apply_minimax(new_board, ai_marker, (depth + 1), acc) / depth
        alpha = get_alpha(ai_marker, marker, score, acc)
        beta = get_beta(ai_marker, marker, score, acc)
        acc = {alpha, beta}
      end
      acc
    end) |> best_score(current_player_marker(board), ai_marker)
  end

  def apply_minimax(board, ai_marker, depth, alphabeta) do
    if game_over?(board) do
      score(board, ai_marker)
    else
      alphabeta(board, ai_marker, depth, alphabeta)
    end
  end
   
  def score(board, ai_marker) do
    if winning_game?(board) do
      if ai_player_win?(board, ai_marker), do: @win, else: @lose 
    else
      @tie
    end
  end

  def best_score(alphabeta, marker, ai_marker) do
    if maximizing_player?(marker, ai_marker), do: beta(alphabeta), else: alpha(alphabeta) 
  end

  def search_tree?(alphabeta) do
    alpha(alphabeta) < beta(alphabeta)
  end

  def maximizing_player?(marker, ai_marker) do
    marker != ai_marker
  end

  def get_alpha(ai_marker, marker, score, alphabeta) do
    alpha = alpha(alphabeta)
    if maximizing_player?(marker, ai_marker) do  
      alpha
    else
      if score > alpha, do: score, else: alpha
    end
  end

  def get_beta(ai_marker, marker, score, alphabeta) do
    beta = beta(alphabeta)
    if maximizing_player?(marker, ai_marker) do  
      if score < beta, do: score, else: beta
    else
      beta
    end
  end

  def ai_player_win?(board, ai_marker) do
    current_player_marker(board) != ai_marker
  end

  def alpha(alphabeta) do
    elem(alphabeta, 0)
  end

  def beta(alphabeta) do
    elem(alphabeta, 1)
  end

  def take_center_cell(board) do
    index = center_cell_index(board) 
    add_marker(board, index)
  end

end
