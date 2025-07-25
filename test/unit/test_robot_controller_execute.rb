# frozen_string_literal: true

require 'test_helper'

class RobotControllerExecuteTest < Minitest::Test
  def test_controller_can_execute_move_command
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    robot = RobotSimulator::Robot.new(RobotSimulator::Position.new(1, 1), RobotSimulator::Direction::NORTH)
    controller = RobotSimulator::Controller.new(robot, board)
    command = RobotSimulator::Commands::MoveCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :success?
  end

  def test_controller_can_execute_left_command
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    robot = RobotSimulator::Robot.new(RobotSimulator::Position.new(1, 1), RobotSimulator::Direction::NORTH)
    controller = RobotSimulator::Controller.new(robot, board)
    command = RobotSimulator::Commands::LeftCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :success?
  end

  def test_controller_can_execute_right_command
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    robot = RobotSimulator::Robot.new(RobotSimulator::Position.new(1, 1), RobotSimulator::Direction::NORTH)
    controller = RobotSimulator::Controller.new(robot, board)
    command = RobotSimulator::Commands::RightCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :success?
  end

  def test_controller_can_update_robot
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    robot = RobotSimulator::Robot.new(RobotSimulator::Position.new(1, 1), RobotSimulator::Direction::NORTH)
    controller = RobotSimulator::Controller.new(robot, board)
    new_robot = RobotSimulator::Robot.new(RobotSimulator::Position.new(2, 2), RobotSimulator::Direction::SOUTH)

    # Act
    controller.update_robot(new_robot)

    # Assert
    assert_equal new_robot, controller.robot
  end
end
