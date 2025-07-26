# frozen_string_literal: true

require 'test_helper'

class TestCommandParser < Minitest::Test
  include RobotSimulator

  def test_command_parser_can_be_created
    # Arrange - no setup needed

    # Act
    parser = Command::Parser.new

    # Assert
    refute_nil parser
  end

  def test_parser_creates_place_command_from_place_string_with_north
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    parser = Command::Parser.new

    # Act
    command = parser.parse('PLACE 0,0,NORTH', controller)

    # Assert
    assert_instance_of Command::Place, command
  end

  def test_parser_creates_place_command_from_place_string_with_south
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    parser = Command::Parser.new

    # Act
    command = parser.parse('PLACE 0,0,SOUTH', controller)

    # Assert
    assert_instance_of Command::Place, command
  end

  def test_parser_creates_place_command_from_place_string_with_east
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    parser = Command::Parser.new

    # Act
    command = parser.parse('PLACE 0,0,EAST', controller)

    # Assert
    assert_instance_of Command::Place, command
  end

  def test_parser_creates_place_command_from_place_string_with_west
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    parser = Command::Parser.new

    # Act
    command = parser.parse('PLACE 0,0,WEST', controller)

    # Assert
    assert_instance_of Command::Place, command
  end

  def test_parser_raises_error_for_invalid_direction
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    parser = Command::Parser.new

    # Act & Assert
    assert_raises(ArgumentError) do
      parser.parse('PLACE 0,0,INVALID', controller)
    end
  end

  def test_parser_raises_error_for_wrong_number_of_place_arguments
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    parser = Command::Parser.new

    # Act & Assert
    assert_raises(ArgumentError) do
      parser.parse('PLACE 0,0', controller)
    end
  end

  def test_parser_raises_error_for_invalid_place_command_format
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    parser = Command::Parser.new

    # Act & Assert
    assert_raises(ArgumentError) do
      parser.parse('PLACE 00000', controller)
    end
  end

  def test_parser_creates_move_command_from_move_string
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    parser = Command::Parser.new

    # Act
    command = parser.parse('MOVE', controller)

    # Assert
    assert_instance_of Command::Move, command
  end

  def test_parser_creates_left_command_from_left_string
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    parser = Command::Parser.new

    # Act
    command = parser.parse('LEFT', controller)

    # Assert
    assert_instance_of Command::Left, command
  end

  def test_parser_creates_right_command_from_right_string
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    parser = Command::Parser.new

    # Act
    command = parser.parse('RIGHT', controller)

    # Assert
    assert_instance_of Command::Right, command
  end

  def test_parser_creates_report_command_from_report_string
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    parser = Command::Parser.new

    # Act
    command = parser.parse('REPORT', controller)

    # Assert
    assert_instance_of Command::Report, command
  end
end
