# frozen_string_literal: true

require 'test_helper'

class CommandFindMovesTest < Minitest::Test
  include RobotSimulator

  def test_find_moves_can_be_initialized_with_goal_position
    # Arrange
    goal_position = Position.new(3, 4)

    # Act
    command = Command::FindMoves.new(goal_position)

    # Assert
    assert_equal goal_position, command.goal_position
  end

  def test_execute_returns_error_when_robot_not_placed
    # Arrange
    board = Board.new(5, 5)
    goal_position = Position.new(2, 3)
    controller = Controller.new(nil, board)
    command = Command::FindMoves.new(goal_position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :error?
    assert_instance_of NoRobotPlacedError, result.error
  end

  def test_execute_returns_empty_array_when_robot_already_at_goal
    # Arrange
    board = Board.new(5, 5)
    robot_position = Position.new(2, 3)
    robot = Robot.new(robot_position, Direction::NORTH)
    controller = Controller.new(robot, board)
    command = Command::FindMoves.new(robot_position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    assert_equal [], result.value
  end

  def test_execute_generates_move_commands_for_simple_path
    # Arrange
    board = Board.new(5, 5)
    start_position = Position.new(0, 0)
    goal_position = Position.new(1, 0)
    robot = Robot.new(start_position, Direction::EAST)
    controller = Controller.new(robot, board)
    command = Command::FindMoves.new(goal_position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    commands = result.value
    assert_equal 1, commands.length
    assert_instance_of Command::Move, commands[0]
  end

  def test_execute_generates_turn_and_move_commands_when_facing_wrong_direction
    # Arrange
    board = Board.new(5, 5)
    start_position = Position.new(0, 0)
    goal_position = Position.new(0, 1)
    robot = Robot.new(start_position, Direction::EAST)
    controller = Controller.new(robot, board)
    command = Command::FindMoves.new(goal_position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    commands = result.value
    assert_equal 2, commands.length
    assert_instance_of Command::Left, commands[0]
    assert_instance_of Command::Move, commands[1]
  end

  def test_execute_generates_multiple_commands_for_complex_path
    # Arrange
    board = Board.new(5, 5)
    start_position = Position.new(0, 0)
    goal_position = Position.new(1, 1)
    robot = Robot.new(start_position, Direction::NORTH)
    controller = Controller.new(robot, board)
    command = Command::FindMoves.new(goal_position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    commands = result.value

    # Should move north first, then turn and move east
    # Could be [MOVE, RIGHT, MOVE] or alternative path
    assert_operator commands.length, :>=, 3
    assert commands.all? { |cmd|
      cmd.is_a?(Command::Move) || cmd.is_a?(Command::Left) || cmd.is_a?(Command::Right)
    }
  end

  def test_execute_returns_empty_array_when_no_path_exists
    # Arrange
    board = Board.new(5, 5)
    board_with_obstacles = board.add_obstacle(Position.new(0, 1))
                                .add_obstacle(Position.new(1, 0))
    start_position = Position.new(0, 0)
    goal_position = Position.new(1, 1)
    robot = Robot.new(start_position, Direction::NORTH)
    controller = Controller.new(robot, board_with_obstacles)
    command = Command::FindMoves.new(goal_position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    assert_equal [], result.value
  end

  def test_execute_optimizes_turns_using_shortest_rotation
    # Arrange
    board = Board.new(5, 5)
    start_position = Position.new(1, 0)
    goal_position = Position.new(0, 0)
    robot = Robot.new(start_position, Direction::NORTH)
    controller = Controller.new(robot, board)
    command = Command::FindMoves.new(goal_position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    commands = result.value

    # Should turn LEFT once (NORTH -> WEST) rather than RIGHT three times
    turn_commands = commands.select { |cmd|
      cmd.is_a?(Command::Left) || cmd.is_a?(Command::Right)
    }
    assert_equal 1, turn_commands.length
    assert_instance_of Command::Left, turn_commands[0]
  end

  def test_execute_generates_right_turn_when_optimal
    # Arrange
    board = Board.new(5, 5)
    start_position = Position.new(0, 1)
    goal_position = Position.new(0, 0)
    robot = Robot.new(start_position, Direction::EAST)
    controller = Controller.new(robot, board)
    command = Command::FindMoves.new(goal_position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    commands = result.value

    # Should turn to face south to go from (0,1) to (0,0)
    turn_commands = commands.select { |cmd|
      cmd.is_a?(Command::Left) || cmd.is_a?(Command::Right)
    }
    assert_equal 1, turn_commands.length
  end

  def test_execute_generates_multiple_right_turns_when_needed
    # Arrange
    board = Board.new(5, 5)
    start_position = Position.new(1, 0)
    goal_position = Position.new(1, 1)
    robot = Robot.new(start_position, Direction::SOUTH)
    controller = Controller.new(robot, board)
    command = Command::FindMoves.new(goal_position)

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    commands = result.value

    # Should turn from SOUTH to NORTH (2 right turns vs 2 left turns)
    turn_commands = commands.select { |cmd|
      cmd.is_a?(Command::Left) || cmd.is_a?(Command::Right)
    }
    assert_equal 2, turn_commands.length
    assert turn_commands.all? { |cmd| cmd.is_a?(Command::Right) }
  end
end
