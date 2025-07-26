# frozen_string_literal: true

require 'test_helper'

class RobotMovementTest < Minitest::Test
  include RobotSimulator

  def test_robot_can_be_placed_and_moved_north
    # Arrange
    simulator = Simulator.new(5, 5)
    place_command = Command::Place.new(Position.new(0, 0), Direction::NORTH)
    place_command.execute(simulator.controller)

    # Act
    move_command = Command::Move.new
    result = move_command.execute(simulator.controller)

    # Assert
    assert_predicate result, :success?
  end

  def test_robot_position_updates_correctly_after_move
    # Arrange
    simulator = Simulator.new(5, 5)
    place_command = Command::Place.new(Position.new(1, 1), Direction::NORTH)
    place_command.execute(simulator.controller)

    # Act
    move_command = Command::Move.new
    move_command.execute(simulator.controller)

    # Assert
    assert_equal 2, simulator.controller.robot.position.y
  end

  def test_robot_direction_unchanged_after_move
    # Arrange
    simulator = Simulator.new(5, 5)
    place_command = Command::Place.new(Position.new(1, 1), Direction::EAST)
    place_command.execute(simulator.controller)

    # Act
    move_command = Command::Move.new
    move_command.execute(simulator.controller)

    # Assert
    assert_equal Direction::EAST, simulator.controller.robot.direction
  end

  def test_invalid_move_at_board_boundary_returns_error
    # Arrange
    simulator = Simulator.new(5, 5)
    place_command = Command::Place.new(Position.new(4, 4), Direction::NORTH)
    place_command.execute(simulator.controller)

    # Act
    move_command = Command::Move.new
    result = move_command.execute(simulator.controller)

    # Assert
    assert_predicate result, :error?
  end

  def test_robot_position_unchanged_after_invalid_move
    # Arrange
    simulator = Simulator.new(5, 5)
    place_command = Command::Place.new(Position.new(4, 4), Direction::NORTH)
    place_command.execute(simulator.controller)

    # Act
    move_command = Command::Move.new
    move_command.execute(simulator.controller)

    # Assert
    assert_equal 4, simulator.controller.robot.position.y
  end

  def test_valid_move_after_invalid_move_succeeds
    # Arrange
    simulator = Simulator.new(5, 5)
    place_robot_at_boundary_position(simulator)
    attempt_invalid_move(simulator)

    # Act
    result = turn_and_move_robot(simulator)

    # Assert
    assert_predicate result, :success?
    assert_equal Position.new(3, 4), simulator.controller.robot.position
  end

  private

  def place_robot_at_boundary_position(simulator)
    place_command = Command::Place.new(Position.new(4, 4), Direction::NORTH)
    place_command.execute(simulator.controller)
  end

  def attempt_invalid_move(simulator)
    invalid_move_command = Command::Move.new
    invalid_move_command.execute(simulator.controller)
  end

  def turn_and_move_robot(simulator)
    left_command = Command::Left.new
    left_command.execute(simulator.controller)
    move_command = Command::Move.new
    move_command.execute(simulator.controller)
  end
end
