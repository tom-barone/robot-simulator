# frozen_string_literal: true

require 'test_helper'

class RobotControllerTest < Minitest::Test
  include RobotSimulator

  def test_controller_can_execute_commands
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = RobotController.new(robot, board)
    command = Commands::MoveCommand.new(controller)

    # Act
    result = controller.execute_command(command)

    # Assert
    assert_predicate result, :success?
  end

  def test_controller_has_robot_and_board_accessible
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)

    # Act
    controller = RobotController.new(robot, board)

    # Assert
    assert_equal robot, controller.robot
    assert_equal board, controller.board
  end
end
