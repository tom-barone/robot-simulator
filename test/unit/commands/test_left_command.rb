# frozen_string_literal: true

require 'test_helper'

class LeftCommandTest < Minitest::Test
  include RobotSimulator
  include RobotSimulator::Commands

  def test_left_command_can_be_created_with_controller
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(RobotSimulator::Position.new(1, 1), Direction::NORTH)
    controller = Controller.new(robot, board)

    # Act
    command = LeftCommand.new(controller)

    # Assert
    refute_nil command
  end

  def test_left_command_executes_successfully_when_robot_is_placed
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = Controller.new(robot, board)
    command = LeftCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :success?
  end

  def test_left_command_fails_when_no_robot_placed
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    command = Commands::LeftCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :error?
  end
end
