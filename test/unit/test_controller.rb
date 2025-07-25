# frozen_string_literal: true

require 'test_helper'

class ControllerTest < Minitest::Test
  include RobotSimulator

  def test_controller_has_robot_and_board_accessible
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)

    # Act
    controller = Controller.new(robot, board)

    # Assert
    assert_equal robot, controller.robot
    assert_equal board, controller.board
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
