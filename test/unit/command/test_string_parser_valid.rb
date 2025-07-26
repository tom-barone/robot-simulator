# frozen_string_literal: true

require 'test_helper'

class TestStringParserValid < Minitest::Test
  include RobotSimulator

  def setup
    @board = Board.new(5, 5)
    @controller = Controller.new(nil, @board)
    @parser = Command::StringParser.new
  end

  def test_parser_creates_move_command_from_move_string
    # Arrange - setup done in setup method

    # Act
    command = @parser.parse('MOVE', @controller)

    # Assert
    assert_instance_of Command::Move, command
  end

  def test_parser_creates_left_command_from_left_string
    # Arrange - setup done in setup method

    # Act
    command = @parser.parse('LEFT', @controller)

    # Assert
    assert_instance_of Command::Left, command
  end

  def test_parser_creates_right_command_from_right_string
    # Arrange - setup done in setup method

    # Act
    command = @parser.parse('RIGHT', @controller)

    # Assert
    assert_instance_of Command::Right, command
  end

  def test_parser_creates_report_command_from_report_string
    # Arrange - setup done in setup method

    # Act
    command = @parser.parse('REPORT', @controller)

    # Assert
    assert_instance_of Command::Report, command
  end

  def test_parser_creates_place_command_with_all_directions
    # Arrange - setup done in setup method
    directions = %w[NORTH SOUTH EAST WEST]

    directions.each do |direction|
      # Act
      command = @parser.parse("PLACE 0,0,#{direction}", @controller)

      # Assert
      assert_instance_of Command::Place, command
      assert_equal Position.new(0, 0), command.position
      assert_equal direction, command.direction.to_s.upcase
    end
  end

  def test_parser_handles_commands_with_extra_whitespace
    # Arrange - setup done in setup method

    # Act
    command = @parser.parse('  MOVE  ', @controller)

    # Assert
    assert_instance_of Command::Move, command
  end

  def test_parser_handles_place_command_with_different_coordinates
    # Arrange - setup done in setup method

    # Act
    command = @parser.parse('PLACE 2,3,EAST', @controller)

    # Assert
    assert_instance_of Command::Place, command
  end
end
