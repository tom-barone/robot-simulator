# frozen_string_literal: true

require 'test_helper'

class SimulatorIntegrationTest < Minitest::Test
  include RobotSimulator

  def test_robot_can_be_placed_and_moved_north
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(0, 0), Direction::NORTH)

    # Act
    result = simulator.move_robot

    # Assert
    assert_predicate result, :success?
  end

  def test_robot_position_updates_correctly_after_move
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(1, 1), Direction::NORTH)

    # Act
    simulator.move_robot

    # Assert
    assert_equal 2, simulator.controller.robot.position.y
  end

  def test_robot_direction_unchanged_after_move
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(1, 1), Direction::EAST)

    # Act
    simulator.move_robot

    # Assert
    assert_equal Direction::EAST, simulator.controller.robot.direction
  end

  def test_robot_can_turn_right_from_north_to_east
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(2, 2), Direction::NORTH)

    # Act
    simulator.turn_right

    # Assert
    assert_equal Direction::EAST, simulator.controller.robot.direction
  end

  def test_robot_can_turn_left_from_north_to_west
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(2, 2), Direction::NORTH)

    # Act
    simulator.turn_left

    # Assert
    assert_equal Direction::WEST, simulator.controller.robot.direction
  end

  def test_robot_position_unchanged_after_rotation
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(2, 2), Direction::NORTH)
    original_position = simulator.controller.robot.position

    # Act
    simulator.turn_right

    # Assert
    assert_equal original_position, simulator.controller.robot.position
  end

  def test_new_place_command_replaces_existing_robot
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(1, 1), Direction::NORTH)

    # Act
    simulator.place_robot(Position.new(3, 3), Direction::SOUTH)

    # Assert
    assert_equal 3, simulator.controller.robot.position.x
  end

  def test_robot_direction_updated_with_new_place_command
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(1, 1), Direction::NORTH)

    # Act
    simulator.place_robot(Position.new(3, 3), Direction::SOUTH)

    # Assert
    assert_equal Direction::SOUTH, simulator.controller.robot.direction
  end

  def test_invalid_move_at_board_boundary_returns_error
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(4, 4), Direction::NORTH)

    # Act
    result = simulator.move_robot

    # Assert
    assert_predicate result, :error?
  end

  def test_robot_position_unchanged_after_invalid_move
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(4, 4), Direction::NORTH)

    # Act
    simulator.move_robot

    # Assert
    assert_equal 4, simulator.controller.robot.position.y
  end

  def test_valid_move_after_invalid_move_succeeds
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(4, 4), Direction::NORTH)
    simulator.move_robot # Invalid move

    # Act
    simulator.turn_left
    result = simulator.move_robot

    # Assert
    assert_predicate result, :success?
    assert_equal Position.new(3, 4), simulator.controller.robot.position
  end

  def test_unplaced_robot_move_command_returns_error
    # Arrange
    simulator = Simulator.new(5, 5)

    # Act
    result = simulator.move_robot

    # Assert
    assert_predicate result, :error?
  end

  def test_unplaced_robot_turn_left_command_returns_error
    # Arrange
    simulator = Simulator.new(5, 5)

    # Act
    result = simulator.turn_left

    # Assert
    assert_predicate result, :error?
  end

  def test_unplaced_robot_turn_right_command_returns_error
    # Arrange
    simulator = Simulator.new(5, 5)

    # Act
    result = simulator.turn_right

    # Assert
    assert_predicate result, :error?
  end
end
