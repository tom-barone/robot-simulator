# frozen_string_literal: true

require 'test_helper'

class PlaceCommandTest < Minitest::Test
  include RobotSimulator

  def test_place_command_can_be_created_with_controller_position_and_direction
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    position = Position.new(1, 1)
    direction = Direction::NORTH

    # Act
    command = Command::Place.new(controller, position, direction)

    # Assert
    refute_nil command
  end

  def test_place_command_executes_successfully_when_position_is_valid
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    position = Position.new(1, 1)
    direction = Direction::NORTH
    command = Command::Place.new(controller, position, direction)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :success?
    assert_equal position, controller.robot.position
  end

  def test_place_command_fails_when_position_is_invalid
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    position = Position.new(5, 5)
    direction = Direction::NORTH
    command = Command::Place.new(controller, position, direction)

    # Act
    result = command.execute

    # Assert
    assert_predicate result, :error?
    assert_instance_of RobotWouldFallError, result.error
  end
end
