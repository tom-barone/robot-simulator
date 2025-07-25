# frozen_string_literal: true

require 'test_helper'

class RobotControllerTest < Minitest::Test
  include RobotSimulator

  def test_controller_can_move_robot_when_position_is_valid
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = RobotController.new(robot, board)

    # Act
    result = controller.move_robot

    # Assert
    assert_predicate result, :success?
  end

  def test_controller_returns_error_when_move_would_be_invalid
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 4), Direction::NORTH)
    controller = RobotController.new(robot, board)

    # Act
    result = controller.move_robot

    # Assert
    assert_predicate result, :error?
  end

  def test_controller_can_turn_robot_left
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = RobotController.new(robot, board)

    # Act
    controller.turn_robot_left

    # Assert
    assert_equal Direction::WEST, controller.robot.direction
  end

  def test_controller_can_turn_robot_right
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = RobotController.new(robot, board)

    # Act
    controller.turn_robot_right

    # Assert
    assert_equal Direction::EAST, controller.robot.direction
  end
end
