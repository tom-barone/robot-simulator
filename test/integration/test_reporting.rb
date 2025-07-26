# frozen_string_literal: true

require 'test_helper'

class ReportingTest < Minitest::Test
  include RobotSimulator

  def test_report_robot_returns_robot_position_when_placed
    # Arrange
    simulator = Simulator.new(5, 5)
    position = Position.new(2, 3)
    direction = Direction::WEST
    simulator.place_robot(position, direction)

    # Act
    result = simulator.report_robot

    # Assert
    assert_predicate result, :success?
    assert_equal '2,3,WEST', result.value
  end

  def test_report_robot_returns_error_when_no_robot_placed
    # Arrange
    simulator = Simulator.new(5, 5)

    # Act
    result = simulator.report_robot

    # Assert
    assert_predicate result, :error?
    assert_instance_of NoRobotPlacedError, result.error
  end

  def test_report_robot_returns_correct_value_after_complex_movement
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(1, 1), Direction::NORTH)

    # Act - Execute complex movement sequence
    simulator.move_robot      # (1, 2, NORTH)
    simulator.turn_right      # (1, 2, EAST)
    simulator.move_robot      # (2, 2, EAST)
    simulator.turn_left       # (2, 2, NORTH)
    result = simulator.report_robot

    # Assert
    assert_predicate result, :success?
    assert_equal '2,2,NORTH', result.value
  end
end
