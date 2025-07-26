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
    mock_cli = Minitest::Mock.new
    pos = RobotSimulator::Position.new(1, 2)
    cmd = RobotSimulator::Command::Place.new(pos, RobotSimulator::Direction::NORTH)

    simulator.instance_variable_set(:@cli, mock_cli)
    mock_cli.expect(:read_command, cmd)
    mock_cli.expect(:handle_result, nil, &:success?)
    mock_cli.expect(:read_command, nil)

    # Act & Assert
    simulator.run
    mock_cli.verify
  end

  def test_simulator_silently_ignores_command_failures_and_parsing_errors
    # Arrange
    simulator = RobotSimulator::Simulator.new
    mock_cli = Minitest::Mock.new

    simulator.instance_variable_set(:@cli, mock_cli)
    mock_cli.expect(:read_command, nil) do
      raise ArgumentError, 'Invalid command'
    end
    mock_cli.expect(:read_command, nil)

    # Act & Assert
    simulator.run
    mock_cli.verify
  end
end
