# frozen_string_literal: true

require 'test_helper'

class PathfindingIntegrationTest < Minitest::Test
  include RobotSimulator

  def setup
    @simulator = Simulator.new
  end

  def test_complete_pathfinding_workflow_with_simple_path
    # Arrange
    commands = [
      'PLACE 0,0,NORTH',
      'FIND 2,0'
    ]

    # Act
    results = execute_commands(commands)

    # Assert
    assert_equal 2, results.length
    assert_predicate results[0], :success?
    assert_predicate results[1], :success?

    path = results[1].value
    expected_path = [Position.new(0, 0), Position.new(1, 0), Position.new(2, 0)]
    assert_equal expected_path, path
  end

  def test_complete_pathfinding_workflow_with_obstacles
    # Arrange
    commands = [
      'PLACE 0,0,NORTH',
      'PUT_OBSTACLE 1,0',
      'FIND 2,0'
    ]

    # Act
    results = execute_commands(commands)

    # Assert
    assert_equal 3, results.length
    assert_predicate results[0], :success?
    assert_predicate results[1], :success?
    assert_predicate results[2], :success?

    path = results[2].value
    assert_includes path, Position.new(0, 0)
    assert_includes path, Position.new(2, 0)
    refute_includes path, Position.new(1, 0)
  end

  def test_pathfinding_when_no_path_exists
    # Arrange
    commands = [
      'PLACE 0,0,NORTH',
      'PUT_OBSTACLE 0,1',
      'PUT_OBSTACLE 1,0',
      'FIND 1,1'
    ]

    # Act
    results = execute_commands(commands)

    # Assert
    assert_equal 4, results.length
    assert_predicate results[3], :success?
    assert_equal [], results[3].value
  end

  def test_pathfinding_error_when_robot_not_placed
    # Arrange
    commands = ['FIND 2,2']

    # Act
    results = execute_commands(commands)

    # Assert
    assert_equal 1, results.length
    assert_predicate results[0], :error?
    assert_instance_of NoRobotPlacedError, results[0].error
  end

  def test_pathfinding_when_robot_already_at_goal
    # Arrange
    commands = [
      'PLACE 3,3,EAST',
      'FIND 3,3'
    ]

    # Act
    results = execute_commands(commands)

    # Assert
    assert_equal 2, results.length
    assert_predicate results[1], :success?
    assert_equal [Position.new(3, 3)], results[1].value
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
