# frozen_string_literal: true

require 'test_helper'

class RobotSimulatorTest < Minitest::Test
  def test_robot_simulator_can_be_created_with_board_dimensions
    # Arrange
    width = 5
    height = 5

    # Act
    simulator = RobotSimulator::Simulator.new(width, height)

    # Assert
    refute_nil simulator
  end

  def test_robot_simulator_has_board_accessible
    # Arrange
    simulator = RobotSimulator::Simulator.new(5, 5)

    # Act
    board = simulator.board

    # Assert
    assert_instance_of RobotSimulator::Board, board
  end

  def test_robot_simulator_starts_with_no_robot_placed
    # Arrange
    simulator = RobotSimulator::Simulator.new(5, 5)

    # Act
    robot = simulator.robot

    # Assert
    assert_nil robot
  end
end
