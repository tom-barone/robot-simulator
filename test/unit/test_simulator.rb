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

  def test_simulator_creates_5x5_board_correctly
    # Arrange & Act
    simulator = RobotSimulator::Simulator.new

    # Assert
    assert_equal 5, simulator.controller.board.width
    assert_equal 5, simulator.controller.board.height
  end

  def test_simulator_creates_controller_parser_and_cli_correctly
    # Arrange & Act
    simulator = RobotSimulator::Simulator.new

    # Assert
    assert_instance_of RobotSimulator::Controller, simulator.controller
    assert_instance_of RobotSimulator::Command::StringParser, simulator.parser
    assert_instance_of RobotSimulator::CLI, simulator.cli
  end

  def test_simulator_executes_commands_via_controller_and_handles_results
    # Arrange
    simulator = RobotSimulator::Simulator.new
    pos = RobotSimulator::Position.new(1, 2)

    # Act
    place_command = RobotSimulator::Command::Place.new(pos, RobotSimulator::Direction::NORTH)
    result = place_command.execute(simulator.controller)

    # Assert
    assert_predicate result, :success?
    refute_nil simulator.controller.robot
  end

  def test_simulator_handles_invalid_robot_operations_gracefully
    # Arrange
    simulator = RobotSimulator::Simulator.new

    # Act - Try to move without placing robot first
    move_command = RobotSimulator::Command::Move.new
    result = move_command.execute(simulator.controller)

    # Assert
    assert_predicate result, :error?
    assert_nil simulator.controller.robot
  end

  def test_shutdown_prints_newline_and_exits
    # Arrange
    simulator = RobotSimulator::Simulator.new
    StringIO.new

    # Act & Assert
    assert_output("\n") do
      assert_raises(SystemExit) { simulator.send(:shutdown) }
    end
  end

  def test_signal_handling_setup_traps_int_signal
    # Arrange
    simulator = RobotSimulator::Simulator.new
    trapped_signal = nil

    # Mock Signal.trap to capture what signal is being trapped
    Signal.stub(:trap, ->(signal) { trapped_signal = signal }) do
      # Act
      simulator.send(:setup_signal_handling)
    end

    # Assert
    assert_equal 'INT', trapped_signal
  end
end
