# frozen_string_literal: true

require 'test_helper'

class CommandFindTest < Minitest::Test
  include RobotSimulator

  def test_find_can_be_initialized_with_goal_position
    # Arrange
    goal_position = Position.new(3, 4)

    # Act
    command = Command::Find.new(goal_position)

    # Assert
    assert_equal goal_position, command.goal_position
  end

  def test_execute_returns_error_when_robot_not_placed
    # Arrange
    board = Board.new(5, 5)
    goal_position = Position.new(2, 3)
    controller = Controller.new(nil, board)
    command = Command::Find.new(goal_position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :error?
  end

  def test_execute_returns_start_position_when_robot_already_at_goal
    # Arrange
    board = Board.new(5, 5)
    robot_position = Position.new(2, 3)
    robot = Robot.new(robot_position, Direction::NORTH)
    controller = Controller.new(robot, board)
    command = Command::Find.new(robot_position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    assert_equal [robot_position], result.value
  end

  def test_execute_finds_simple_path_without_obstacles
    # Arrange
    board = Board.new(5, 5)
    start_position = Position.new(0, 0)
    goal_position = Position.new(2, 0)
    robot = Robot.new(start_position, Direction::NORTH)
    controller = Controller.new(robot, board)
    command = Command::Find.new(goal_position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    expected_path = [Position.new(0, 0), Position.new(1, 0), Position.new(2, 0)]
    assert_equal expected_path, result.value
  end

  def test_execute_finds_path_around_obstacles
    # Arrange
    board = Board.new(5, 5)
    board_with_obstacle = board.add_obstacle(Position.new(1, 0))
    start_position = Position.new(0, 0)
    goal_position = Position.new(2, 0)
    robot = Robot.new(start_position, Direction::NORTH)
    controller = Controller.new(robot, board_with_obstacle)
    command = Command::Find.new(goal_position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    path = result.value
    assert_includes path, Position.new(0, 0)
    assert_includes path, Position.new(2, 0)
    refute_includes path, Position.new(1, 0)
  end

  def test_execute_returns_empty_array_when_no_path_available
    # Arrange
    board = Board.new(5, 5)
    board_with_obstacles = board.add_obstacle(Position.new(0, 1))
                                .add_obstacle(Position.new(1, 0))
    start_position = Position.new(0, 0)
    goal_position = Position.new(1, 1)
    robot = Robot.new(start_position, Direction::NORTH)
    controller = Controller.new(robot, board_with_obstacles)
    command = Command::Find.new(goal_position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    assert_equal [], result.value
  end
end
