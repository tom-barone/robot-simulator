# frozen_string_literal: true

require 'test_helper'

class LeftCommandTest < Minitest::Test
  def test_left_command_can_be_created_with_controller
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    robot = RobotSimulator::Robot.new(RobotSimulator::Position.new(1, 1), RobotSimulator::Direction::NORTH)
    controller = RobotSimulator::RobotController.new(robot, board)

    # Act
    command = RobotSimulator::LeftCommand.new(controller)

    # Assert
    refute_nil command
  end

  def test_left_command_executes_successfully_when_robot_is_placed
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    robot = RobotSimulator::Robot.new(RobotSimulator::Position.new(1, 1), RobotSimulator::Direction::NORTH)
    controller = RobotSimulator::RobotController.new(robot, board)
    command = RobotSimulator::LeftCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :success?
  end

  def test_left_command_fails_when_no_robot_placed
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    controller = RobotSimulator::RobotController.new(nil, board)
    command = RobotSimulator::LeftCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :error?
  end
end
