# frozen_string_literal: true

require 'test_helper'

class PositionTest < Minitest::Test
  include RobotSimulator

  def test_position_can_be_created_with_x_and_y_coordinates
    # Arrange
    x = 1
    y = 2

    # Act
    position = Position.new(x, y)

    # Assert
    assert_equal position.x, x
    assert_equal position.y, y
  end

  def test_move_north_increases_y_coordinate
    # Arrange
    position = Position.new(1, 1)

    # Act
    new_position = position.move(Direction::NORTH)

    # Assert
    assert_equal 1, new_position.x
    assert_equal 2, new_position.y
  end

  def test_move_south_decreases_y_coordinate
    # Arrange
    position = Position.new(1, 1)

    # Act
    new_position = position.move(Direction::SOUTH)

    # Assert
    assert_equal 1, new_position.x
    assert_equal 0, new_position.y
  end

  def test_move_east_increases_x_coordinate
    # Arrange
    position = Position.new(1, 1)

    # Act
    new_position = position.move(Direction::EAST)

    # Assert
    assert_equal 2, new_position.x
    assert_equal 1, new_position.y
  end

  def test_move_west_decreases_x_coordinate
    # Arrange
    position = Position.new(1, 1)

    # Act
    new_position = position.move(Direction::WEST)

    # Assert
    assert_equal 0, new_position.x
    assert_equal 1, new_position.y
  end

  def test_move_returns_new_position_object
    # Arrange
    original_position = Position.new(1, 1)

    # Act
    new_position = original_position.move(Direction::NORTH)

    # Assert
    refute_same original_position, new_position
  end

  def test_move_does_not_mutate_original_position
    # Arrange
    original_position = Position.new(1, 1)

    # Act
    original_position.move(Direction::NORTH)

    # Assert
    assert_equal 1, original_position.x
    assert_equal 1, original_position.y
  end

  def test_move_north_from_edge_coordinates
    # Arrange
    position = Position.new(0, 4)

    # Act
    new_position = position.move(Direction::NORTH)

    # Assert
    assert_equal 0, new_position.x
    assert_equal 5, new_position.y
  end

  def test_move_south_from_edge_coordinates
    # Arrange
    position = Position.new(4, 0)

    # Act
    new_position = position.move(Direction::SOUTH)

    # Assert
    assert_equal 4, new_position.x
    assert_equal(-1, new_position.y)
  end

  def test_move_east_from_edge_coordinates
    # Arrange
    position = Position.new(4, 0)

    # Act
    new_position = position.move(Direction::EAST)

    # Assert
    assert_equal 5, new_position.x
    assert_equal 0, new_position.y
  end

  def test_move_west_from_edge_coordinates
    # Arrange
    position = Position.new(0, 4)

    # Act
    new_position = position.move(Direction::WEST)

    # Assert
    assert_equal(-1, new_position.x)
    assert_equal 4, new_position.y
  end

  def test_equality_of_positions_with_same_coordinates
    # Arrange
    position1 = Position.new(1, 2)
    position2 = Position.new(1, 2)

    # Act & Assert
    assert_equal position1, position2
  end

  def test_inequality_of_positions_with_different_coordinates
    # Arrange
    position1 = Position.new(1, 2)
    position2 = Position.new(2, 1)

    # Act & Assert
    refute_equal position1, position2
  end

  def test_move_warns_for_excessive_coordinates
    # Arrange
    position = Position.new(100_001, 0)

    # Act & Assert
    assert_output(nil, /Warning: Excessively large coordinates/) do
      position.move(Direction::NORTH)
    end
  end

  def test_move_raises_error_for_invalid_direction
    # Arrange
    position = Position.new(1, 1)

    # Act & Assert
    assert_raises(ArgumentError) do
      position.move(:invalid_direction)
    end
  end
end
