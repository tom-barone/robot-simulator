# frozen_string_literal: true

require 'test_helper'

class MoveCommandTest < Minitest::Test
  def test_move_command_can_be_created_with_controller
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    robot = RobotSimulator::Robot.new(RobotSimulator::Position.new(1, 1), RobotSimulator::Direction::NORTH)
    controller = RobotSimulator::RobotController.new(robot, board)

    # Act
    command = RobotSimulator::Commands::MoveCommand.new(controller)

    # Assert
    refute_nil command
  end

  def test_move_command_executes_successfully_when_move_is_valid
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    robot = RobotSimulator::Robot.new(RobotSimulator::Position.new(1, 1), RobotSimulator::Direction::NORTH)
    controller = RobotSimulator::RobotController.new(robot, board)
    command = RobotSimulator::Commands::MoveCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :success?
  end

  def test_move_command_fails_when_robot_would_fall_off_table
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    robot = RobotSimulator::Robot.new(RobotSimulator::Position.new(1, 4), RobotSimulator::Direction::NORTH)
    controller = RobotSimulator::RobotController.new(robot, board)
    command = RobotSimulator::Commands::MoveCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :error?
  end

  def test_move_command_fails_when_no_robot_placed
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    controller = RobotSimulator::RobotController.new(nil, board)
    command = RobotSimulator::Commands::MoveCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :error?
  end
end
