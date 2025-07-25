# frozen_string_literal: true

require 'test_helper'

class PositionTest < Minitest::Test
  def test_position_can_be_created_with_x_and_y_coordinates
    # Arrange
    x = 1
    y = 2

    # Act
    position = RobotSimulator::Position.new(x, y)

    # Assert
    assert_equal position.x, x
    assert_equal position.y, y
  end

  # def test_position_can_move_north
  #  # Arrange
  #  position = Position.new(1, 1)
  #  direction = 'NORTH'

  #  # Act
  #  new_position = position.move(direction)

  #  # Assert
  #  assert_equal 1, new_position.x
  #  assert_equal 2, new_position.y
  # end

  # def test_position_can_move_south
  #  # Arrange
  #  position = Position.new(1, 1)
  #  direction = 'SOUTH'

  #  # Act
  #  new_position = position.move(direction)

  #  # Assert
  #  assert_equal 1, new_position.x
  #  assert_equal 0, new_position.y
  # end

  # def test_position_can_move_east
  #  # Arrange
  #  position = Position.new(1, 1)
  #  direction = 'EAST'

  #  # Act
  #  new_position = position.move(direction)

  #  # Assert
  #  assert_equal 2, new_position.x
  #  assert_equal 1, new_position.y
  # end

  # def test_position_can_move_west
  #  # Arrange
  #  position = Position.new(1, 1)
  #  direction = 'WEST'

  #  # Act
  #  new_position = position.move(direction)

  #  # Assert
  #  assert_equal 0, new_position.x
  #  assert_equal 1, new_position.y
  # end
end
