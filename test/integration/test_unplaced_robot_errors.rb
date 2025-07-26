# frozen_string_literal: true

require 'test_helper'

class UnplacedRobotErrorsTest < Minitest::Test
  include RobotSimulator

  def test_unplaced_robot_move_command_returns_error
    # Arrange
    simulator = Simulator.new(5, 5)

    # Act
    move_command = Command::Move.new
    result = move_command.execute(simulator.controller)

    # Assert
    assert_predicate result, :error?
  end

  def test_unplaced_robot_turn_left_command_returns_error
    # Arrange
    simulator = Simulator.new(5, 5)

    # Act
    left_command = Command::Left.new
    result = left_command.execute(simulator.controller)

    # Assert
    assert_predicate result, :error?
  end

  def test_unplaced_robot_turn_right_command_returns_error
    # Arrange
    simulator = Simulator.new(5, 5)

    # Act
    right_command = Command::Right.new
    result = right_command.execute(simulator.controller)

    # Assert
    assert_predicate result, :error?
  end
end
