# frozen_string_literal: true

require 'test_helper'

class RobotControllerExecuteTest < Minitest::Test
  include RobotSimulator
  include RobotSimulator::Commands

  def test_controller_can_execute_move_command
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = Controller.new(robot, board)
    command = MoveCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :success?
  end

  def test_controller_can_execute_left_command
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

  def test_controller_can_execute_right_command
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = Controller.new(robot, board)
    command = RightCommand.new(controller)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :success?
  end

  def test_controller_can_update_robot
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = Controller.new(robot, board)
    new_robot = Robot.new(Position.new(2, 2), Direction::SOUTH)

    # Act
    controller.update_robot(new_robot)

    # Assert
    assert_equal new_robot, controller.robot
  end
end
