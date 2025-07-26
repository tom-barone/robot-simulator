# frozen_string_literal: true

require 'test_helper'

class RobotRotationTest < Minitest::Test
  include RobotSimulator

  def test_robot_can_turn_right_from_north_to_east
    # Arrange
    simulator = Simulator.new(5, 5)
    place_command = Command::Place.new(Position.new(2, 2), Direction::NORTH)
    place_command.execute(simulator.controller)

    # Act
    right_command = Command::Right.new
    right_command.execute(simulator.controller)

    # Assert
    assert_equal Direction::EAST, simulator.controller.robot.direction
  end

  def test_robot_can_turn_left_from_north_to_west
    # Arrange
    simulator = Simulator.new(5, 5)
    place_command = Command::Place.new(Position.new(2, 2), Direction::NORTH)
    place_command.execute(simulator.controller)

    # Act
    left_command = Command::Left.new
    left_command.execute(simulator.controller)

    # Assert
    assert_equal Direction::WEST, simulator.controller.robot.direction
  end

  def test_robot_position_unchanged_after_rotation
    # Arrange
    simulator = Simulator.new(5, 5)
    place_command = Command::Place.new(Position.new(2, 2), Direction::NORTH)
    place_command.execute(simulator.controller)
    original_position = simulator.controller.robot.position

    # Act
    right_command = Command::Right.new
    right_command.execute(simulator.controller)

    # Assert
    assert_equal original_position, simulator.controller.robot.position
  end
end
