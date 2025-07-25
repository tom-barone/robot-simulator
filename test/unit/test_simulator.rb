# frozen_string_literal: true

require 'test_helper'

class SimulatorTest < Minitest::Test
  def test_robot_simulator_can_be_created
    # Arrange
    width = 5
    height = 5

    # Act & Assert
    refute_nil RobotSimulator::Simulator.new(width, height)
  end

  def test_simulator_initializes_with_no_robot_placed
    # Arrange
    simulator = RobotSimulator::Simulator.new(5, 5)

    # Act & Assert
    refute simulator.controller.robot
  end
end
