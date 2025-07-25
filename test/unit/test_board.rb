# frozen_string_literal: true

require 'test_helper'

class BoardTest < Minitest::Test
  def test_board_can_be_created_with_width_and_height
    # Arrange
    width = 5
    height = 5

    # Act
    board = RobotSimulator::Board.new(width, height)

    # Assert
    assert_equal board.width, width
    assert_equal board.height, height
  end
end
