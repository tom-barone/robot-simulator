# frozen_string_literal: true

require 'test_helper'

class ResultTest < Minitest::Test
  include RobotSimulator
  include RobotSimulator::Command

  def test_result_can_be_created_as_success
    # Arrange
    # Act
    result = Result.success

    # Assert
    assert_predicate result, :success?
  end

  def test_result_can_be_created_as_error_with_error_class
    # Arrange
    # Act
    result = Result.error(RobotWouldFallError)

    # Assert
    assert_predicate result, :error?
  end

  def test_result_success_is_not_error
    # Arrange
    result = Result.success

    # Act
    # Assert
    refute_predicate result, :error?
  end

  def test_result_error_is_not_success
    # Arrange
    result = Result.error(NoRobotPlacedError)

    # Act
    # Assert
    refute_predicate result, :success?
  end

  def test_result_error_returns_error_instance
    # Arrange
    result = Result.error(NoRobotPlacedError)

    # Act
    error = result.error

    # Assert
    assert_instance_of NoRobotPlacedError, error
  end

  def test_result_error_message_returns_error_message
    # Arrange
    result = Result.error(NoRobotPlacedError)

    # Act
    message = result.error_message

    # Assert
    assert_equal 'RobotSimulator::NoRobotPlacedError', message
  end
end
