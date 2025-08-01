# frozen_string_literal: true

require 'test_helper'

class ErrorsTest < Minitest::Test
  def test_obstacle_in_the_way_error_is_a_robot_simulator_error
    # Arrange
    # Act
    error = RobotSimulator::ObstacleInTheWayError.new

    # Assert
    assert_kind_of RobotSimulator::Error, error
  end

  def test_obstacle_in_the_way_error_has_correct_message
    # Arrange
    error = RobotSimulator::ObstacleInTheWayError.new

    # Act
    message = error.message

    # Assert
    assert_equal 'Obstacle in the way', message
  end

  def test_robot_in_the_way_error_is_a_robot_simulator_error
    # Arrange
    # Act
    error = RobotSimulator::RobotInTheWayError.new

    # Assert
    assert_kind_of RobotSimulator::Error, error
  end

  def test_robot_in_the_way_error_has_correct_message
    # Arrange
    error = RobotSimulator::RobotInTheWayError.new

    # Act
    message = error.message

    # Assert
    assert_equal 'Robot in the way', message
  end

  def test_obstacle_would_fall_error_is_a_robot_simulator_error
    # Arrange
    # Act
    error = RobotSimulator::ObstacleWouldFallError.new

    # Assert
    assert_kind_of RobotSimulator::Error, error
  end

  def test_obstacle_would_fall_error_has_correct_message
    # Arrange
    error = RobotSimulator::ObstacleWouldFallError.new

    # Act
    message = error.message

    # Assert
    assert_equal 'Obstacle would fall off the board', message
  end
end
