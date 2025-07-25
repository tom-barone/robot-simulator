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

  def test_position_0_0_is_valid_on_5x5_board
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    position = RobotSimulator::Position.new(0, 0)

    # Act
    result = board.valid?(position)

    # Assert
    assert result
  end

  def test_position_4_4_is_valid_on_5x5_board
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    position = RobotSimulator::Position.new(4, 4)

    # Act
    result = board.valid?(position)

    # Assert
    assert result
  end

  def test_position_negative_1_0_is_invalid
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    position = RobotSimulator::Position.new(-1, 0)

    # Act
    result = board.valid?(position)

    # Assert
    refute result
  end

  def test_position_5_0_is_invalid
    # Arrange
    board = RobotSimulator::Board.new(5, 5)
    position = RobotSimulator::Position.new(5, 0)

    # Act
    result = board.valid?(position)

    # Assert
    refute result
  end
end
