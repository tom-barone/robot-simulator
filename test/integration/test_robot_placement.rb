# frozen_string_literal: true

require 'test_helper'

class RobotPlacementTest < Minitest::Test
  include RobotSimulator

  def test_new_place_command_replaces_existing_robot
    # Arrange
    simulator = Simulator.new(5, 5)
    first_place_command = Command::Place.new(Position.new(1, 1), Direction::NORTH)
    first_place_command.execute(simulator.controller)

    # Act
    second_place_command = Command::Place.new(Position.new(3, 3), Direction::SOUTH)
    second_place_command.execute(simulator.controller)

    # Assert
    assert_equal 3, simulator.controller.robot.position.x
  end

  def test_robot_direction_updated_with_new_place_command
    # Arrange
    simulator = Simulator.new(5, 5)
    first_place_command = Command::Place.new(Position.new(1, 1), Direction::NORTH)
    first_place_command.execute(simulator.controller)

    # Act
    second_place_command = Command::Place.new(Position.new(3, 3), Direction::SOUTH)
    second_place_command.execute(simulator.controller)

    # Assert
    assert_equal Direction::SOUTH, simulator.controller.robot.direction
  end
end
