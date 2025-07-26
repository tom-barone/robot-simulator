# frozen_string_literal: true

require 'test_helper'

class SimulatorProgramLoopTest < Minitest::Test
  include RobotSimulator

  def test_simulator_displays_intro_on_startup
    # Arrange
    simulator = Simulator.new

    # Act & Assert
    assert_output(/Welcome to the Robot Simulator!/) do
      simulator.cli.show_intro
    end
  end

  def test_simulator_handles_invalid_command_and_shows_error
    # Arrange
    simulator = Simulator.new

    # Act & Assert
    assert_output("Error: Invalid command 'INVALID'\n") do
      simulate_single_command(simulator, "INVALID\n")
    end
  end

  def test_simulator_handles_unplaced_robot_error_and_shows_message
    # Arrange
    simulator = Simulator.new

    # Act & Assert
    assert_output("Error: No robot has been placed on the board\n") do
      simulate_single_command(simulator, "MOVE\n")
    end
  end

  def test_simulator_handles_robot_would_fall_error_and_shows_message
    # Arrange
    simulator = Simulator.new
    place_robot(simulator, 0, 0, Direction::SOUTH)

    # Act & Assert
    assert_output("Error: Robot would fall off the board\n") do
      simulate_single_command(simulator, "MOVE\n")
    end
  end

  def test_simulator_processes_command_sequence_correctly
    # Arrange
    simulator = Simulator.new
    execute_command_sequence(simulator)

    # Assert
    assert_equal 2, simulator.controller.robot.position.x
  end

  def test_command_sequence_ends_with_correct_y_position
    # Arrange
    simulator = Simulator.new
    execute_command_sequence(simulator)

    # Assert
    assert_equal 2, simulator.controller.robot.position.y
  end

  def test_command_sequence_ends_with_correct_direction
    # Arrange
    simulator = Simulator.new
    execute_command_sequence(simulator)

    # Assert
    assert_equal Direction::EAST, simulator.controller.robot.direction
  end

  def test_command_sequence_report_outputs_correct_position
    # Arrange
    simulator = Simulator.new

    # Act & Assert
    output = capture_io do
      execute_command_sequence_with_report(simulator)
    end

    assert_match(/Output: 2,2,EAST/, output[0])
  end

  def test_simulator_processes_stdin_input_correctly
    # Arrange
    simulator = Simulator.new
    mock_stdin = StringIO.new("PLACE 0,0,NORTH\nREPORT\n")

    # Act & Assert
    output = capture_io do
      process_two_commands_from_stdin(simulator, mock_stdin)
    end

    assert_match(/Output: 0,0,NORTH/, output[0])
  end

  private

  def place_robot(simulator, x_pos, y_pos, direction)
    place_command = Command::Place.new(Position.new(x_pos, y_pos), direction)
    place_command.execute(simulator.controller)
  end

  def execute_command_sequence(simulator)
    commands = ['PLACE 1,1,NORTH', 'MOVE', 'RIGHT', 'MOVE']
    commands.each { |cmd| simulate_single_command(simulator, "#{cmd}\n") }
  end

  def execute_command_sequence_with_report(simulator)
    commands = ['PLACE 1,1,NORTH', 'MOVE', 'RIGHT', 'MOVE', 'REPORT']
    commands.each { |cmd| simulate_single_command(simulator, "#{cmd}\n") }
  end

  def process_two_commands_from_stdin(simulator, mock_stdin)
    $stdin.stub(:gets, -> { mock_stdin.gets }) do
      execute_cli_command(simulator)
      execute_cli_command(simulator)
    end
  end

  def execute_cli_command(simulator)
    simulator.cli.read_command do |command|
      result = command.execute(simulator.controller)
      simulator.cli.handle_result(result)
    end
  end

  def simulate_single_command(simulator, input)
    mock_stdin = StringIO.new(input)

    $stdin.stub(:gets, -> { mock_stdin.gets }) do
      simulator.cli.read_command do |command|
        result = command.execute(simulator.controller)
        simulator.cli.handle_result(result)
        return result
      end
    end
  end
end
