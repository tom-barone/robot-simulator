# frozen_string_literal: true

require 'test_helper'

class RobotTest < Minitest::Test
  def test_robot_can_be_created_with_position_and_direction
    # Arrange
    position = RobotSimulator::Position.new(1, 2)
    direction = RobotSimulator::Direction::NORTH

    # Act
    robot = RobotSimulator::Robot.new(position, direction)

    # Assert
    assert_equal position, robot.position
    assert_equal direction, robot.direction
  end
end
