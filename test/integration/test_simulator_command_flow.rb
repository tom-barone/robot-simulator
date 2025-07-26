# frozen_string_literal: true

require 'test_helper'

class SimulatorCommandFlowTest < Minitest::Test
  include RobotSimulator

  def test_simulator_processes_place_command_through_full_flow
    # Arrange
    simulator = Simulator.new
    input_commands = "PLACE 1,2,NORTH\n"

    # Act
    simulate_single_command(simulator, input_commands)

    # Assert
    refute_nil simulator.controller.robot
  end

  def test_place_command_sets_correct_x_position
    # Arrange
    simulator = Simulator.new
    input_commands = "PLACE 1,2,NORTH\n"

    # Act
    simulate_single_command(simulator, input_commands)

    # Assert
    assert_equal 1, simulator.controller.robot.position.x
  end

  def test_place_command_sets_correct_y_position
    # Arrange
    simulator = Simulator.new
    input_commands = "PLACE 1,2,NORTH\n"

    # Act
    simulate_single_command(simulator, input_commands)

    # Assert
    assert_equal 2, simulator.controller.robot.position.y
  end

  def test_place_command_sets_correct_direction
    # Arrange
    simulator = Simulator.new
    input_commands = "PLACE 1,2,NORTH\n"

    # Act
    simulate_single_command(simulator, input_commands)

    # Assert
    assert_equal Direction::NORTH, simulator.controller.robot.direction
  end

  def test_simulator_processes_move_command_through_full_flow
    # Arrange
    simulator = Simulator.new
    place_robot(simulator, 0, 0, Direction::NORTH)

    # Act
    simulate_single_command(simulator, "MOVE\n")

    # Assert
    assert_equal 0, simulator.controller.robot.position.x
  end

  def test_move_command_updates_y_position_correctly
    # Arrange
    simulator = Simulator.new
    place_robot(simulator, 0, 0, Direction::NORTH)

    # Act
    simulate_single_command(simulator, "MOVE\n")

    # Assert
    assert_equal 1, simulator.controller.robot.position.y
  end

  def test_simulator_processes_rotation_commands_through_full_flow
    # Arrange
    simulator = Simulator.new
    place_robot(simulator, 2, 2, Direction::NORTH)

    # Act
    simulate_single_command(simulator, "RIGHT\n")

    # Assert
    assert_equal Direction::EAST, simulator.controller.robot.direction
  end

  def test_simulator_exit_command_handling
    # Arrange
    simulator = Simulator.new

    # Act
    command = simulate_command_parsing(simulator, "EXIT\n")

    # Assert
    assert_instance_of Command::Exit, command
  end

  private

  def place_robot(simulator, x_pos, y_pos, direction)
    place_command = Command::Place.new(Position.new(x_pos, y_pos), direction)
    place_command.execute(simulator.controller)
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

  def simulate_command_parsing(simulator, input)
    mock_stdin = StringIO.new(input)

    $stdin.stub(:gets, -> { mock_stdin.gets }) do
      simulator.cli.read_command do |command|
        return command
      end
    end
  end
end
