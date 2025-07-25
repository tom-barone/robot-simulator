# frozen_string_literal: true

require 'test_helper'

class PlaceCommandIntegrationTest < Minitest::Test
  include RobotSimulator

  def test_place_command_succeeds_with_valid_position
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    position = Position.new(2, 2)
    direction = Direction::NORTH
    command = Commands::PlaceCommand.new(controller, position, direction)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :success?
  end

  def test_place_command_updates_robot_position_correctly
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    position = Position.new(2, 2)
    direction = Direction::NORTH
    command = Commands::PlaceCommand.new(controller, position, direction)

    # Act
    command.execute

    # Assert
    assert_equal 2, controller.robot.position.x
  end

  def test_place_command_updates_robot_direction_correctly
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    position = Position.new(2, 2)
    direction = Direction::EAST
    command = Commands::PlaceCommand.new(controller, position, direction)

    # Act
    command.execute

    # Assert
    assert_equal Direction::EAST, controller.robot.direction
  end

  def test_place_command_fails_with_invalid_position_outside_bounds
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    position = Position.new(5, 5)
    direction = Direction::NORTH
    command = Commands::PlaceCommand.new(controller, position, direction)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :error?
  end

  def test_place_command_leaves_robot_unchanged_when_invalid_position
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::SOUTH)
    controller = Controller.new(robot, board)
    position = Position.new(5, 5)
    direction = Direction::NORTH
    command = Commands::PlaceCommand.new(controller, position, direction)

    # Act
    command.execute

    # Assert
    assert_equal Direction::SOUTH, controller.robot.direction
  end
end
