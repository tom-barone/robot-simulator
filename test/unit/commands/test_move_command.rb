# frozen_string_literal: true

require 'test_helper'

class MoveCommandTest < Minitest::Test
  include RobotSimulator
  include RobotSimulator::Commands

  def test_move_command_can_be_created_with_controller
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = RobotController.new(robot, board)

    # Act
    command = MoveCommand.new(controller)

    # Assert
    refute_nil command
  end

  def test_move_command_executes_successfully_when_move_is_valid
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = RobotController.new(robot, board)
    command = MoveCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :success?
  end

  def test_move_command_fails_when_robot_would_fall_off_table
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 4), Direction::NORTH)
    controller = RobotController.new(robot, board)
    command = MoveCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :error?
  end

  def test_move_command_fails_when_no_robot_placed
    # Arrange
    board = Board.new(5, 5)
    controller = RobotController.new(nil, board)
    command = MoveCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :error?
  end
end
