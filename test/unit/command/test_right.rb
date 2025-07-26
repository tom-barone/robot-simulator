# frozen_string_literal: true

require 'test_helper'

class RightCommandTest < Minitest::Test
  include RobotSimulator

  def test_right_command_executes_successfully_when_robot_is_placed
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = Controller.new(robot, board)
    command = Command::Right.new

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    assert_equal Direction::EAST, controller.robot.direction
  end

  def test_right_command_fails_when_no_robot_placed
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    command = Command::Right.new

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :error?
    assert_instance_of NoRobotPlacedError, result.error
  end
end
