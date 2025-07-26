# frozen_string_literal: true

require 'test_helper'

class ComplexMovementTest < Minitest::Test
  include RobotSimulator

  def test_robot_can_navigate_to_far_corner_final_position
    # Arrange
    simulator = Simulator.new(5, 5)
    place_robot_at_origin(simulator)

    # Act - Navigate to opposite corner (4,4)
    navigate_to_far_corner(simulator)

    # Assert
    assert_equal 4, simulator.controller.robot.position.x
  end

  def test_robot_navigation_ends_with_correct_direction
    # Arrange
    simulator = Simulator.new(5, 5)
    place_robot_at_origin(simulator)

    # Act
    navigate_to_far_corner(simulator)

    # Assert
    assert_equal Direction::EAST, simulator.controller.robot.direction
  end

  def test_full_rotation_returns_to_original_direction
    # Arrange
    simulator = Simulator.new(5, 5)
    place_command = Command::Place.new(Position.new(2, 2), Direction::NORTH)
    place_command.execute(simulator.controller)

    # Act
    4.times { Command::Right.new.execute(simulator.controller) }

    # Assert
    assert_equal Direction::NORTH, simulator.controller.robot.direction
  end

  def test_rotation_preserves_robot_position
    # Arrange
    simulator = Simulator.new(5, 5)
    place_command = Command::Place.new(Position.new(2, 2), Direction::NORTH)
    place_command.execute(simulator.controller)
    original_position = simulator.controller.robot.position

    # Act
    Command::Right.new.execute(simulator.controller)

    # Assert
    assert_equal original_position, simulator.controller.robot.position
  end

  def test_complex_movement_sequence_final_x_position
    # Arrange
    simulator = Simulator.new(5, 5)
    place_robot_at_center(simulator)

    # Act
    execute_north_then_west_movement(simulator)

    # Assert
    assert_equal 1, simulator.controller.robot.position.x
  end

  def test_complex_movement_sequence_final_direction
    # Arrange
    simulator = Simulator.new(5, 5)
    place_robot_at_center(simulator)

    # Act
    execute_north_then_west_movement(simulator)
    Command::Left.new.execute(simulator.controller)

    # Assert
    assert_equal Direction::SOUTH, simulator.controller.robot.direction
  end

  private

  def place_robot_at_origin(simulator)
    place_command = Command::Place.new(Position.new(0, 0), Direction::NORTH)
    place_command.execute(simulator.controller)
  end

  def place_robot_at_center(simulator)
    place_command = Command::Place.new(Position.new(2, 2), Direction::NORTH)
    place_command.execute(simulator.controller)
  end

  def navigate_to_far_corner(simulator)
    4.times { Command::Move.new.execute(simulator.controller) }
    Command::Right.new.execute(simulator.controller)
    4.times { Command::Move.new.execute(simulator.controller) }
  end

  def execute_north_then_west_movement(simulator)
    Command::Move.new.execute(simulator.controller)
    Command::Left.new.execute(simulator.controller)
    Command::Move.new.execute(simulator.controller)
  end
end
