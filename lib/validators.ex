defmodule Validators do
  import Player
  import Ui
  import Board, only: [open_cell?: 2, add_marker: 3]

  @valid_types player_types

  def valid_type?(type) do
    type = String.downcase(type)
    Enum.any?(@valid_types, fn(x) -> x == type end)
  end

  def valid_cell_index?(board, cell_index) do
    (0 <= cell_index) && (cell_index < 10) && open_cell?(board, cell_index)
  end

  def valid_move?(board, move) do
    valid_integer?(move) && valid_cell_index?(board, get_cell_index(move))
  end

  def valid_integer?(move) do
    try do 
      is_tuple(Integer.parse(move))
    end
  end

  def get_cell_index(move) do
    parsed_move = Integer.parse(move)
    elem(parsed_move, 0) - 1
  end

  def play_valid_move(board, move, marker) do
    cell_index = get_cell_index(move)
    add_marker(board, marker, cell_index) 
  end

  def handle_invalid_move(board, marker) do
    invalid_move_message(marker)
    request_player_move(marker)
    board
  end

  def validate_move(board, move, marker) do
    if valid_move?(board, move) do
      play_valid_move(board, move, marker)
    else
      handle_invalid_move(board, marker)
    end
  end

  def validate_type(type, marker) do
    if valid_type?(type) do
      create_player(marker, type)
    else
      invalid_type_message(marker)
      get_player(marker)
    end
  end

  def get_player(marker) do
    request_player_type(marker)
    type = get_input
    validate_type(type, marker)
  end

  def get_move(board, marker) do
    request_player_move(marker)
    move = get_input
    validate_move(board, move, marker)
  end

end
