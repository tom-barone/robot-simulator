# frozen_string_literal: true

require 'test_helper'

class MoveCommandTest < Minitest::Test
  include RobotSimulator

  def test_move_command_can_be_created_with_controller
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = Controller.new(robot, board)

    # Act
    command = Command::Move.new(controller)

    # Assert
    refute_nil command
  end

  def test_move_command_executes_successfully_when_move_is_valid
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = Controller.new(robot, board)
    command = Command::Move.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :success?
  end

  def test_move_command_fails_when_robot_would_fall_off_table
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 4), Direction::NORTH)
    controller = Controller.new(robot, board)
    command = Command::Move.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :error?
    assert_instance_of RobotWouldFallError, result.error
  end

  def test_move_command_fails_when_no_robot_placed
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    command = Command::Move.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :error?
    assert_instance_of NoRobotPlacedError, result.error
  end
end
