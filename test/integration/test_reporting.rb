# frozen_string_literal: true

require 'test_helper'

class ReportingTest < Minitest::Test
  include RobotSimulator

  def test_report_robot_returns_robot_position_when_placed
    # Arrange
    simulator = Simulator.new(5, 5)
    position = Position.new(2, 3)
    direction = Direction::WEST
    place_command = Command::Place.new(position, direction)
    place_command.execute(simulator.controller)

    # Act
    report_command = Command::Report.new
    result = report_command.execute(simulator.controller)

    # Assert
    assert_predicate result, :success?
    assert_equal '2,3,WEST', result.value
  end

  def test_report_robot_returns_error_when_no_robot_placed
    # Arrange
    simulator = Simulator.new(5, 5)

    # Act
    report_command = Command::Report.new
    result = report_command.execute(simulator.controller)

    # Assert
    assert_predicate result, :error?
    assert_instance_of NoRobotPlacedError, result.error
  end

  def test_report_robot_returns_correct_value_after_complex_movement
    # Arrange
    simulator = Simulator.new(5, 5)
    place_robot_at_start_position(simulator)

    # Act - Execute complex movement sequence
    execute_complex_movement_sequence(simulator)
    result = report_robot_position(simulator)

    # Assert
    assert_predicate result, :success?
    assert_equal '2,2,NORTH', result.value
  end

  private

  def place_robot_at_start_position(simulator)
    place_command = Command::Place.new(Position.new(1, 1), Direction::NORTH)
    place_command.execute(simulator.controller)
  end

  def execute_complex_movement_sequence(simulator)
    Command::Move.new.execute(simulator.controller)      # (1, 2, NORTH)
    Command::Right.new.execute(simulator.controller)     # (1, 2, EAST)
    Command::Move.new.execute(simulator.controller)      # (2, 2, EAST)
    Command::Left.new.execute(simulator.controller)      # (2, 2, NORTH)
  end

  def report_robot_position(simulator)
    report_command = Command::Report.new
    report_command.execute(simulator.controller)
  end
end
