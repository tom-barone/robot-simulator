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
    command = @parser.parse('MOVE')

    # Assert
    assert_instance_of Command::Move, command
  end

  def test_parser_creates_left_command_from_left_string
    # Arrange - setup done in setup method

    # Act
    command = @parser.parse('LEFT')

    # Assert
    assert_instance_of Command::Left, command
  end

  def test_parser_creates_right_command_from_right_string
    # Arrange - setup done in setup method

    # Act
    command = @parser.parse('RIGHT')

    # Assert
    assert_instance_of Command::Right, command
  end

  def test_parser_creates_report_command_from_report_string
    # Arrange - setup done in setup method

    # Act
    command = @parser.parse('REPORT')

    # Assert
    assert_instance_of Command::Report, command
  end

  def test_parser_creates_place_command_with_all_directions
    # Arrange - setup done in setup method
    directions = %w[NORTH SOUTH EAST WEST]

    directions.each do |direction|
      # Act
      command = @parser.parse("PLACE 0,0,#{direction}")

      # Assert
      assert_instance_of Command::Place, command
      assert_equal Position.new(0, 0), command.position
      assert_equal direction, command.direction.to_s.upcase
    end
  end

  def test_parser_handles_commands_with_extra_whitespace
    # Arrange - setup done in setup method

    # Act
    command = @parser.parse('  MOVE  ')

    # Assert
    assert_instance_of Command::Move, command
  end

  def test_parser_handles_place_command_with_different_coordinates
    # Arrange - setup done in setup method

    # Act
    command = @parser.parse('PLACE 2,3,EAST')

    # Assert
    assert_instance_of Command::Place, command
  end

  def test_parser_creates_put_obstacle_command_from_put_obstacle_string
    # Arrange - setup done in setup method

    # Act
    command = @parser.parse('PUT_OBSTACLE 0,0')

    # Assert
    assert_instance_of Command::PutObstacle, command
  end

  def test_parser_creates_find_command_from_find_string
    # Arrange - setup done in setup method

    # Act
    command = @parser.parse('FIND 2,3')

    # Assert
    assert_instance_of Command::Find, command
    assert_equal Position.new(2, 3), command.goal_position
  end

  def test_parser_creates_find_moves_command_from_find_moves_string
    # Arrange - setup done in setup method

    # Act
    command = @parser.parse('FIND_MOVES 2,3')

    # Assert
    assert_instance_of Command::FindMoves, command
    assert_equal Position.new(2, 3), command.goal_position
  end
end
