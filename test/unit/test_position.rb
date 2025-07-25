# frozen_string_literal: true

require 'test_helper'

class PositionTest < Minitest::Test
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
end
