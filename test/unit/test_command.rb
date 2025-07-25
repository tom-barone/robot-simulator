# frozen_string_literal: true

require 'test_helper'

class CommandTest < Minitest::Test
  def test_command_can_be_created_as_success
    # Arrange
    # Act
    command = RobotSimulator::Command.success

    # Assert
    assert_predicate command, :success?
  end

  def test_command_can_be_created_as_error_with_error_class
    # Arrange
    # Act
    command = RobotSimulator::Command.error(RobotSimulator::RobotWouldFallError)

    # Assert
    assert_predicate command, :error?
  end

  def test_command_success_is_not_error
    # Arrange
    command = RobotSimulator::Command.success

    # Act
    # Assert
    refute_predicate command, :error?
  end

  def test_command_error_is_not_success
    # Arrange
    command = RobotSimulator::Command.error(RobotSimulator::NoRobotPlacedError)

    # Act
    # Assert
    refute_predicate command, :success?
  end

  def test_command_error_returns_error_instance
    # Arrange
    command = RobotSimulator::Command.error(RobotSimulator::NoRobotPlacedError)

    # Act
    error = command.error

    # Assert
    assert_instance_of RobotSimulator::NoRobotPlacedError, error
  end

  def test_command_error_message_returns_error_message
    # Arrange
    command = RobotSimulator::Command.error(RobotSimulator::NoRobotPlacedError)

    # Act
    message = command.error_message

    # Assert
    assert_equal 'RobotSimulator::NoRobotPlacedError', message
  end
end
