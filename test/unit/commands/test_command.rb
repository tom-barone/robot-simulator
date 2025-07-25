# frozen_string_literal: true

require 'test_helper'

class CommandTest < Minitest::Test
  include RobotSimulator
  include RobotSimulator::Commands

  def test_command_can_be_created_as_success
    # Arrange
    # Act
    command = Command.success

    # Assert
    assert_predicate command, :success?
  end

  def test_command_can_be_created_as_error_with_error_class
    # Arrange
    # Act
    command = Command.error(RobotWouldFallError)

    # Assert
    assert_predicate command, :error?
  end

  def test_command_success_is_not_error
    # Arrange
    command = Command.success

    # Act
    # Assert
    refute_predicate command, :error?
  end

  def test_command_error_is_not_success
    # Arrange
    command = Command.error(NoRobotPlacedError)

    # Act
    # Assert
    refute_predicate command, :success?
  end

  def test_command_error_returns_error_instance
    # Arrange
    command = Command.error(NoRobotPlacedError)

    # Act
    error = command.error

    # Assert
    assert_instance_of NoRobotPlacedError, error
  end

  def test_command_error_message_returns_error_message
    # Arrange
    command = Command.error(NoRobotPlacedError)

    # Act
    message = command.error_message

    # Assert
    assert_equal 'RobotSimulator::NoRobotPlacedError', message
  end
end
