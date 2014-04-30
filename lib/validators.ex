defmodule Validators do
  import Player
  import Ui
  import Board, only: [new_board: 1, open_cell?: 2, add_marker: 2]
  import Utils

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

  def valid_size?(size) do
    parsed_size = parse_integer(size)
    (3 <= parsed_size) && (parsed_size <= 6)
  end

  def valid_board_size?(size) do
    valid_integer?(size) && valid_size?(size)
  end

  def valid_integer?(move) do
    try do 
      is_tuple(Integer.parse(move))
    end
  end

  def get_cell_index(move) do
    parse_integer(move) - 1
  end

  def play_valid_move(board, move, marker) do
    cell_index = get_cell_index(move)
    add_marker(board, cell_index) 
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

  def validate_board_size(size) do
    if valid_board_size?(size) do
      parsed_size = parse_integer(size) 
      new_board(parsed_size) 
    else
      invalid_size_message
      get_board_size
    end
  end

  def get_player(marker) do
    request_player_type(marker)
    type = get_input
    validate_type(type, marker)
  end

  def get_board_size do
    request_board_size
    size = get_input
    validate_board_size(size)
  end

  def get_move(board, marker) do
    request_player_move(marker)
    move = get_input
    validate_move(board, move, marker)
  end

end
