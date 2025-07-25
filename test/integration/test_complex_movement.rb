# frozen_string_literal: true

require 'test_helper'

class ComplexMovementTest < Minitest::Test
  include RobotSimulator

  def test_robot_can_navigate_to_far_corner_final_position
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(0, 0), Direction::NORTH)

    # Act - Navigate to opposite corner (4,4)
    4.times { simulator.move_robot }
    simulator.turn_right
    4.times { simulator.move_robot }

    # Assert
    assert_equal 4, simulator.controller.robot.position.x
  end

  def test_robot_navigation_ends_with_correct_direction
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(0, 0), Direction::NORTH)

    # Act
    4.times { simulator.move_robot }
    simulator.turn_right
    4.times { simulator.move_robot }

    # Assert
    assert_equal Direction::EAST, simulator.controller.robot.direction
  end

  def test_full_rotation_returns_to_original_direction
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(2, 2), Direction::NORTH)

    # Act
    4.times { simulator.turn_right }

    # Assert
    assert_equal Direction::NORTH, simulator.controller.robot.direction
  end

  def test_rotation_preserves_robot_position
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(2, 2), Direction::NORTH)
    original_position = simulator.controller.robot.position

    # Act
    simulator.turn_right

    # Assert
    assert_equal original_position, simulator.controller.robot.position
  end

  def test_complex_movement_sequence_final_x_position
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(2, 2), Direction::NORTH)

    # Act
    simulator.move_robot
    simulator.turn_left
    simulator.move_robot

    # Assert
    assert_equal 1, simulator.controller.robot.position.x
  end

  def test_complex_movement_sequence_final_direction
    # Arrange
    simulator = Simulator.new(5, 5)
    simulator.place_robot(Position.new(2, 2), Direction::NORTH)

    # Act
    simulator.move_robot
    simulator.turn_left
    simulator.move_robot
    simulator.turn_left

    # Assert
    assert_equal Direction::SOUTH, simulator.controller.robot.direction
  end
end
