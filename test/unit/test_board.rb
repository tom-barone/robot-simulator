# frozen_string_literal: true

require 'test_helper'

class BoardTest < Minitest::Test
  include RobotSimulator

  def test_board_can_be_created_with_width_and_height
    # Arrange
    width = 5
    height = 5

    # Act
    board = Board.new(width, height)

    # Assert
    assert_equal board.width, width
    assert_equal board.height, height
  end

  def test_position_0_0_is_valid_on_5x5_board
    # Arrange
    board = Board.new(5, 5)
    position = Position.new(0, 0)

    # Act
    result = board.valid?(position)

    # Assert
    assert result
  end

  def test_position_4_4_is_valid_on_5x5_board
    # Arrange
    board = Board.new(5, 5)
    position = Position.new(4, 4)

    # Act
    result = board.valid?(position)

    # Assert
    assert result
  end

  def test_position_negative_1_0_is_invalid
    # Arrange
    board = Board.new(5, 5)
    position = Position.new(-1, 0)

    # Act
    result = board.valid?(position)

    # Assert
    refute result
  end

  def test_position_5_0_is_invalid
    # Arrange
    board = Board.new(5, 5)
    position = Position.new(5, 0)

    # Act
    result = board.valid?(position)

    # Assert
    refute result
  end

  def test_obstacle_returns_false_when_no_obstacles_exist
    # Arrange
    board = Board.new(5, 5)
    position = Position.new(2, 3)

    # Act
    result = board.obstacle?(position)

    # Assert
    refute result
  end

  def test_add_obstacle_returns_new_board_instance
    # Arrange
    board = Board.new(5, 5)
    position = Position.new(2, 3)

    # Act
    new_board = board.add_obstacle(position)

    # Assert
    refute_same board, new_board
  end

  def test_obstacle_returns_true_after_adding_obstacle
    # Arrange
    board = Board.new(5, 5)
    position = Position.new(2, 3)
    board_with_obstacle = board.add_obstacle(position)

    # Act
    result = board_with_obstacle.obstacle?(position)

    # Assert
    assert result
  end

  def test_add_obstacle_does_not_mutate_original_board
    # Arrange
    board = Board.new(5, 5)
    position = Position.new(2, 3)

    # Act
    board.add_obstacle(position)

    # Assert
    refute board.obstacle?(position)
  end
end
