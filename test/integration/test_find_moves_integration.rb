# frozen_string_literal: true

require 'test_helper'

class FindMovesIntegrationTest < Minitest::Test
  include RobotSimulator

  def setup
    @simulator = Simulator.new
  end

  def test_complete_find_moves_workflow_with_simple_path
    # Arrange
    commands = [
      'PLACE 0,0,EAST',
      'FIND_MOVES 2,0'
    ]

    # Act
    results = execute_commands(commands)

    # Assert
    assert_equal 2, results.length
    assert_predicate results[0], :success?
    assert_predicate results[1], :success?

    commands_list = results[1].value
    assert_equal 2, commands_list.length
    assert_instance_of Command::Move, commands_list[0]
    assert_instance_of Command::Move, commands_list[1]
  end

  def test_complete_find_moves_workflow_with_turns
    # Arrange
    commands = [
      'PLACE 0,0,NORTH',
      'FIND_MOVES 1,0'
    ]

    # Act
    results = execute_commands(commands)

    # Assert
    assert_equal 2, results.length
    assert_predicate results[1], :success?

    commands_list = results[1].value
    assert_operator commands_list.length, :>=, 2

    # Should have at least one turn command and one move command
    turn_commands = commands_list.select { |cmd|
      cmd.is_a?(Command::Left) || cmd.is_a?(Command::Right)
    }
    move_commands = commands_list.select { |cmd| cmd.is_a?(Command::Move) }

    assert_operator turn_commands.length, :>=, 1
    assert_operator move_commands.length, :>=, 1
  end

  def test_find_moves_with_obstacles_requiring_detour
    # Arrange
    commands = [
      'PLACE 0,0,EAST',
      'PUT_OBSTACLE 1,0',
      'FIND_MOVES 2,0'
    ]

    # Act
    results = execute_commands(commands)

    # Assert
    assert_equal 3, results.length
    assert_predicate results[2], :success?

    commands_list = results[2].value
    # Should need more than 2 moves due to detour
    assert_operator commands_list.length, :>, 2
  end

  def test_find_moves_when_no_path_exists
    # Arrange
    commands = [
      'PLACE 0,0,NORTH',
      'PUT_OBSTACLE 0,1',
      'PUT_OBSTACLE 1,0',
      'FIND_MOVES 1,1'
    ]

    # Act
    results = execute_commands(commands)

    # Assert
    assert_equal 4, results.length
    assert_predicate results[3], :success?
    assert_equal [], results[3].value
  end

  def test_find_moves_error_when_robot_not_placed
    # Arrange
    commands = ['FIND_MOVES 2,2']

    # Act
    results = execute_commands(commands)

    # Assert
    assert_equal 1, results.length
    assert_predicate results[0], :error?
    assert_instance_of NoRobotPlacedError, results[0].error
  end

  def test_find_moves_when_robot_already_at_goal
    # Arrange
    commands = [
      'PLACE 3,3,WEST',
      'FIND_MOVES 3,3'
    ]

    # Act
    results = execute_commands(commands)

    # Assert
    assert_equal 2, results.length
    assert_predicate results[1], :success?
    assert_equal [], results[1].value
  end

  private

  def execute_commands(commands)
    results = []
    commands.each do |command_string|
      command = @simulator.parser.parse(command_string)
      result = command.execute(@simulator.controller)
      results << result
    end
    results
  end
end
