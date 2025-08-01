# frozen_string_literal: true

require 'test_helper'

class CommandPutObstacleTest < Minitest::Test
  include RobotSimulator

  def test_put_obstacle_can_be_initialized_with_position
    # Arrange
    position = Position.new(2, 3)

    # Act
    command = Command::PutObstacle.new(position)

    # Assert
    assert_equal position, command.position
  end

  def test_execute_places_obstacle_on_empty_board
    # Arrange
    board = Board.new(5, 5)
    position = Position.new(2, 3)
    controller = Controller.new(nil, board)
    command = Command::PutObstacle.new(position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
  end

  def test_execute_returns_error_when_obstacle_placed_outside_board
    # Arrange
    board = Board.new(5, 5)
    position = Position.new(5, 3)
    controller = Controller.new(nil, board)
    command = Command::PutObstacle.new(position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :error?
  end

  def test_execute_returns_error_when_obstacle_placed_on_existing_obstacle
    # Arrange
    board = Board.new(5, 5)
    position = Position.new(2, 3)
    board_with_obstacle = board.add_obstacle(position)
    controller = Controller.new(nil, board_with_obstacle)
    command = Command::PutObstacle.new(position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :error?
  end

  def test_execute_returns_error_when_obstacle_placed_on_robot_position
    # Arrange
    board = Board.new(5, 5)
    position = Position.new(2, 3)
    robot = Robot.new(position, Direction::NORTH)
    controller = Controller.new(robot, board)
    command = Command::PutObstacle.new(position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :error?
  end
end
