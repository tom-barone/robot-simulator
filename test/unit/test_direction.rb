# frozen_string_literal: true

require 'test_helper'

class DirectionTest < Minitest::Test
  include RobotSimulator

  def test_turn_right_from_north_goes_to_east
    # Arrange
    direction = Direction::NORTH

    # Act
    result = Direction.turn_right(direction)

    # Assert
    assert_equal Direction::EAST, result
  end

  def test_turn_right_from_east_goes_to_south
    # Arrange
    direction = Direction::EAST

    # Act
    result = Direction.turn_right(direction)

    # Assert
    assert_equal Direction::SOUTH, result
  end

  def test_turn_right_from_south_goes_to_west
    # Arrange
    direction = Direction::SOUTH

    # Act
    result = Direction.turn_right(direction)

    # Assert
    assert_equal Direction::WEST, result
  end

  def test_turn_right_from_west_goes_to_north
    # Arrange
    direction = Direction::WEST

    # Act
    result = Direction.turn_right(direction)

    # Assert
    assert_equal Direction::NORTH, result
  end

  def test_turn_left_from_north_goes_to_west
    # Arrange
    direction = Direction::NORTH

    # Act
    result = Direction.turn_left(direction)

    # Assert
    assert_equal Direction::WEST, result
  end

  def test_turn_left_from_west_goes_to_south
    # Arrange
    direction = Direction::WEST

    # Act
    result = Direction.turn_left(direction)

    # Assert
    assert_equal Direction::SOUTH, result
  end

  def test_turn_left_from_south_goes_to_east
    # Arrange
    direction = Direction::SOUTH

    # Act
    result = Direction.turn_left(direction)

    # Assert
    assert_equal Direction::EAST, result
  end

  def test_turn_left_from_east_goes_to_north
    # Arrange
    direction = Direction::EAST

    # Act
    result = Direction.turn_left(direction)

    # Assert
    assert_equal Direction::NORTH, result
  end

  def test_turn_right_with_invalid_direction_raises_error
    # Arrange
    invalid_direction = :invalid

    # Act & Assert
    assert_raises(ArgumentError) do
      Direction.turn_right(invalid_direction)
    end
  end

  def test_turn_left_with_invalid_direction_raises_error
    # Arrange
    invalid_direction = :invalid

    # Act & Assert
    assert_raises(ArgumentError) do
      Direction.turn_left(invalid_direction)
    end
  end

  def test_turn_right_error_message_includes_invalid_direction
    # Arrange
    invalid_direction = :bad_direction

    # Act & Assert
    error = assert_raises(ArgumentError) do
      Direction.turn_right(invalid_direction)
    end
    assert_includes error.message, 'Invalid direction: bad_direction'
  end

  def test_turn_left_error_message_includes_invalid_direction
    # Arrange
    invalid_direction = :bad_direction

    # Act & Assert
    error = assert_raises(ArgumentError) do
      Direction.turn_left(invalid_direction)
    end
    assert_includes error.message, 'Invalid direction: bad_direction'
  end
end
