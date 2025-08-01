# frozen_string_literal: true

require 'test_helper'

class MoveCommandTest < Minitest::Test
  include RobotSimulator

  def test_move_command_executes_successfully_when_move_is_valid
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = Controller.new(robot, board)
    command = Command::Move.new

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    assert_equal Position.new(1, 2), controller.robot.position
  end

  def test_move_command_fails_when_robot_would_fall_off_table
    # Arrange
    board = Board.new(5, 5)
    robot = Robot.new(Position.new(1, 4), Direction::NORTH)
    controller = Controller.new(robot, board)
    command = Command::Move.new

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :error?
    assert_instance_of RobotWouldFallError, result.error
  end

  def test_move_command_fails_when_no_robot_placed
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    command = Command::Move.new

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :error?
    assert_instance_of NoRobotPlacedError, result.error
  end

  def test_move_command_fails_when_obstacle_blocks_path
    # Arrange
    board = Board.new(5, 5)
    obstacle_position = Position.new(1, 2)
    board_with_obstacle = board.add_obstacle(obstacle_position)
    robot = Robot.new(Position.new(1, 1), Direction::NORTH)
    controller = Controller.new(robot, board_with_obstacle)
    command = Command::Move.new

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :error?
    assert_instance_of ObstacleInTheWayError, result.error
  end

  def test_move_command_fails_when_obstacle_blocks_path_in_all_directions
    # Arrange
    board = Board.new(5, 5)
    robot_position = Position.new(2, 2)
    robot = Robot.new(robot_position, Direction::NORTH)

    # Test NORTH direction
    board_with_north_obstacle = board.add_obstacle(Position.new(2, 3))
    controller = Controller.new(robot, board_with_north_obstacle)
    command = Command::Move.new
    result = command.execute(controller)

    assert_predicate result, :error?
    assert_instance_of ObstacleInTheWayError, result.error

    # Test SOUTH direction
    robot = Robot.new(robot_position, Direction::SOUTH)
    board_with_south_obstacle = board.add_obstacle(Position.new(2, 1))
    controller = Controller.new(robot, board_with_south_obstacle)
    result = command.execute(controller)

    assert_predicate result, :error?
    assert_instance_of ObstacleInTheWayError, result.error

    # Test EAST direction
    robot = Robot.new(robot_position, Direction::EAST)
    board_with_east_obstacle = board.add_obstacle(Position.new(3, 2))
    controller = Controller.new(robot, board_with_east_obstacle)
    result = command.execute(controller)

    assert_predicate result, :error?
    assert_instance_of ObstacleInTheWayError, result.error

    # Test WEST direction
    robot = Robot.new(robot_position, Direction::WEST)
    board_with_west_obstacle = board.add_obstacle(Position.new(1, 2))
    controller = Controller.new(robot, board_with_west_obstacle)
    result = command.execute(controller)

    # Assert
    assert_predicate result, :error?
    assert_instance_of ObstacleInTheWayError, result.error
  end
end
