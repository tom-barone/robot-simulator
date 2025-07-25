# frozen_string_literal: true

require 'test_helper'

class RobotControllerTest < Minitest::Test
  def test_controller_can_move_robot_when_position_is_valid
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    robot = RobotSimulator::Robot.new(RobotSimulator::Position.new(1, 1), RobotSimulator::Direction::NORTH)
    controller = RobotSimulator::RobotController.new(robot, board)

    # Act
    controller.move_robot

    # Assert
    assert_equal 1, controller.robot.position.x
    assert_equal 2, controller.robot.position.y
  end

  def test_controller_ignores_move_when_position_would_be_invalid
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    robot = RobotSimulator::Robot.new(RobotSimulator::Position.new(1, 4), RobotSimulator::Direction::NORTH)
    controller = RobotSimulator::RobotController.new(robot, board)

    # Act
    controller.move_robot

    # Assert
    assert_equal 1, controller.robot.position.x
    assert_equal 4, controller.robot.position.y
  end

  def test_controller_can_turn_robot_left
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    robot = RobotSimulator::Robot.new(RobotSimulator::Position.new(1, 1), RobotSimulator::Direction::NORTH)
    controller = RobotSimulator::RobotController.new(robot, board)

    # Act
    controller.turn_robot_left

    # Assert
    assert_equal RobotSimulator::Direction::WEST, controller.robot.direction
  end

  def test_controller_can_turn_robot_right
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    robot = RobotSimulator::Robot.new(RobotSimulator::Position.new(1, 1), RobotSimulator::Direction::NORTH)
    controller = RobotSimulator::RobotController.new(robot, board)

    # Act
    controller.turn_robot_right

    # Assert
    assert_equal RobotSimulator::Direction::EAST, controller.robot.direction
  end
end
