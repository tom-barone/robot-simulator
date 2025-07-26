# frozen_string_literal: true

require 'test_helper'

class ReportCommandTest < Minitest::Test
  include RobotSimulator

  def test_report_command_can_be_created
    # Arrange

    # Act
    command = Command::Report.new

    # Assert
    refute_nil command
  end

  def test_report_command_executes_robot_reporting
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = Controller.new(robot, board)
    command = Command::Report.new

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
  end

  def test_report_command_returns_robot_report_as_value
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(2, 3), Direction::EAST)
    controller = Controller.new(robot, board)
    command = Command::Report.new

    # Act
    result = command.execute(controller)

    # Assert
    assert_equal '2,3,EAST', result.value
  end

  def test_report_command_fails_when_no_robot_placed
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    command = Command::Report.new

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :error?
    assert_instance_of NoRobotPlacedError, result.error
  end
end
