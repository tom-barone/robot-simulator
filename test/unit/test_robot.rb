# frozen_string_literal: true

require 'test_helper'

class RobotTest < Minitest::Test
  include RobotSimulator

  def test_robot_can_be_created_with_position_and_direction
    # Arrange
    position = Position.new(1, 2)
    direction = Direction::NORTH

    # Act
    robot = Robot.new(position, direction)

    # Assert
    assert_equal position, robot.position
    assert_equal direction, robot.direction
  end

  def test_robot_can_move_forward_in_facing_direction
    # Arrange
    position = Position.new(1, 2)
    direction = Direction::NORTH
    robot = Robot.new(position, direction)

    # Act
    new_robot = robot.move

    # Assert
    assert_equal 1, new_robot.position.x
    assert_equal 3, new_robot.position.y
  end

  def test_robot_move_returns_new_robot_instance
    # Arrange
    position = Position.new(1, 2)
    direction = Direction::NORTH
    original_robot = Robot.new(position, direction)

    # Act
    new_robot = original_robot.move

    # Assert
    refute_equal original_robot, new_robot
  end

  def test_robot_move_does_not_mutate_original_robot
    # Arrange
    position = Position.new(1, 2)
    direction = Direction::NORTH
    original_robot = Robot.new(position, direction)

    # Act
    original_robot.move

    # Assert
    assert_equal 1, original_robot.position.x
    assert_equal 2, original_robot.position.y
  end

  def test_robot_move_returns_robot_with_updated_position
    # Arrange
    position = Position.new(1, 2)
    direction = Direction::NORTH
    original_robot = Robot.new(position, direction)

    # Act
    new_robot = original_robot.move

    # Assert
    assert_equal 1, new_robot.position.x
    assert_equal 3, new_robot.position.y
  end

  def test_robot_turn_left_returns_new_robot_instance
    # Arrange
    position = Position.new(1, 2)
    direction = Direction::NORTH
    original_robot = Robot.new(position, direction)

    # Act
    new_robot = original_robot.turn_left

    # Assert
    refute_equal original_robot, new_robot
  end

  def test_robot_turn_left_does_not_mutate_original_robot
    # Arrange
    position = Position.new(1, 2)
    direction = Direction::NORTH
    original_robot = Robot.new(position, direction)

    # Act
    original_robot.turn_left

    # Assert
    assert_equal Direction::NORTH, original_robot.direction
  end

  def test_robot_turn_left_returns_robot_with_updated_direction
    # Arrange
    position = Position.new(1, 2)
    direction = Direction::NORTH
    original_robot = Robot.new(position, direction)

    # Act
    new_robot = original_robot.turn_left

    # Assert
    assert_equal Direction::WEST, new_robot.direction
  end

  def test_robot_turn_right_returns_new_robot_instance
    # Arrange
    position = Position.new(1, 2)
    direction = Direction::NORTH
    original_robot = Robot.new(position, direction)

    # Act
    new_robot = original_robot.turn_right

    # Assert
    refute_equal original_robot, new_robot
  end

  def test_robot_turn_right_does_not_mutate_original_robot
    # Arrange
    position = Position.new(1, 2)
    direction = Direction::NORTH
    original_robot = Robot.new(position, direction)

    # Act
    original_robot.turn_right

    # Assert
    assert_equal Direction::NORTH, original_robot.direction
  end

  def test_robot_turn_right_returns_robot_with_updated_direction
    # Arrange
    position = Position.new(1, 2)
    direction = Direction::NORTH
    original_robot = Robot.new(position, direction)

    # Act
    new_robot = original_robot.turn_right

    # Assert
    assert_equal Direction::EAST, new_robot.direction
  end
end
