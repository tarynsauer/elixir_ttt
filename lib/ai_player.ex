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
    apply_minimax(add_marker(board, cell), ai_marker, ai_marker, 1, {-999, 999})     
  end

  def alphabeta(board, ai_marker, marker, depth, alphabeta) do
    cells = open_cells(board)
    Enum.reduce(cells, alphabeta, fn (cell, acc) ->
      if !break?(alphabeta) do
        new_board = add_marker(board, cell)
        score = apply_minimax(new_board, ai_marker, current_player_marker(board), (depth + 1), acc) / depth
        alpha = get_alpha(ai_marker, new_board, score, acc)
        beta = get_beta(ai_marker, new_board, score, acc)
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

  def break?(alphabeta) do
    elem(alphabeta, 0) >= elem(alphabeta, 1)
  end

  def maximizing_player?(board, ai_marker) do
    current_player_marker(board) == ai_marker
  end

  def return_best_score(alphabeta, marker, ai_marker) do
    if (marker == ai_marker) && !nil?(alphabeta), do: elem(alphabeta, 0), else: elem(alphabeta, 1) 
  end

  def get_alpha(ai_marker, board, score, alphabeta) do
    alpha = elem(alphabeta, 0)
    if maximizing_player?(board, ai_marker) do  ### Might be opposite
      alpha
    else
      if score > alpha, do: score, else: alpha
    end
  end

  def get_beta(ai_marker, board, score, alphabeta) do
    beta = elem(alphabeta, 1)
    if maximizing_player?(board, ai_marker) do  ### Might be opposite
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
