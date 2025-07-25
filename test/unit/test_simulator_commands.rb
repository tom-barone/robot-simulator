# frozen_string_literal: true

require 'test_helper'

class SimulatorCommandsTest < Minitest::Test
  def test_simulator_can_move_robot_when_robot_is_placed
    # Arrange
    simulator = RobotSimulator::Simulator.new(5, 5)
    simulator.place_robot(RobotSimulator::Position.new(1, 1), RobotSimulator::Direction::NORTH)

    # Act
    result = simulator.move_robot

    # Assert
    assert_predicate result, :success?
  end

  def test_simulator_returns_error_when_moving_unplaced_robot
    # Arrange
    simulator = RobotSimulator::Simulator.new(5, 5)

    # Act
    result = simulator.move_robot

    # Assert
    assert_predicate result, :error?
  end

  def test_simulator_can_turn_robot_left
    # Arrange
    simulator = RobotSimulator::Simulator.new(5, 5)
    simulator.place_robot(RobotSimulator::Position.new(1, 1), RobotSimulator::Direction::NORTH)

    # Act
    result = simulator.turn_left

    # Assert
    assert_predicate result, :success?
  end

  def test_simulator_can_turn_robot_right
    # Arrange
    simulator = RobotSimulator::Simulator.new(5, 5)
    simulator.place_robot(RobotSimulator::Position.new(1, 1), RobotSimulator::Direction::NORTH)

    # Act
    result = simulator.turn_right

    # Assert
    assert_predicate result, :success?
  end
end
