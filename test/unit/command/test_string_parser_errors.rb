# frozen_string_literal: true

require 'test_helper'

class TestStringParserErrors < Minitest::Test
  include RobotSimulator

  def setup
    @board = Board.new(5, 5)
    @controller = Controller.new(nil, @board)
    @parser = Command::StringParser.new
  end

  def test_parser_raises_error_for_invalid_command
    # Arrange - setup done in setup method

    # Act & Assert
    assert_raises(ArgumentError) do
      @parser.parse('INVALID')
    end
  end

  def test_parser_raises_error_for_empty_input
    # Arrange - setup done in setup method

    # Act & Assert
    assert_raises(ArgumentError) do
      @parser.parse('')
    end
  end

  def test_parser_raises_error_for_whitespace_only_input
    # Arrange - setup done in setup method

    # Act & Assert
    assert_raises(ArgumentError) do
      @parser.parse('   ')
    end
  end

  def test_parser_raises_error_for_place_command_without_arguments
    # Arrange - setup done in setup method

    # Act & Assert
    assert_raises(ArgumentError) do
      @parser.parse('PLACE')
    end
  end

  def test_parser_raises_error_for_place_command_with_incomplete_arguments
    # Arrange - setup done in setup method

    # Act & Assert
    assert_raises(ArgumentError) do
      @parser.parse('PLACE 0,0')
    end
  end

  def test_parser_raises_error_for_place_command_with_too_many_arguments
    # Arrange - setup done in setup method

    # Act & Assert
    assert_raises(ArgumentError) do
      @parser.parse('PLACE 0,0,NORTH,EXTRA')
    end
  end

  def test_parser_raises_error_for_place_command_with_invalid_direction
    # Arrange - setup done in setup method

    # Act & Assert
    assert_raises(ArgumentError) do
      @parser.parse('PLACE 0,0,INVALID')
    end
  end

  def test_invalid_command_error_message_is_descriptive
    # Arrange - setup done in setup method

    # Act & Assert
    error = assert_raises(ArgumentError) do
      @parser.parse('INVALID')
    end
    assert_match(/Invalid command/, error.message)
  end

  def test_place_missing_args_error_message_is_descriptive
    # Arrange - setup done in setup method

    # Act & Assert
    error = assert_raises(ArgumentError) do
      @parser.parse('PLACE')
    end
    assert_match(/requires arguments/, error.message)
  end

  def test_place_incomplete_args_error_message_is_descriptive
    # Arrange - setup done in setup method

    # Act & Assert
    error = assert_raises(ArgumentError) do
      @parser.parse('PLACE 0,0')
    end
    assert_match(/format X,Y,DIRECTION/, error.message)
  end

  def test_place_invalid_direction_error_message_is_descriptive
    # Arrange - setup done in setup method

    # Act & Assert
    error = assert_raises(ArgumentError) do
      @parser.parse('PLACE 0,0,INVALID')
    end
    assert_match(/Invalid direction/, error.message)
  end

  def test_place_non_integer_x_coordinates_returns_error
    # Arrange - setup done in setup method

    # Act & Assert
    assert_raises(ArgumentError) do
      @parser.parse('PLACE 0,x,NORTH')
    end
  end

  def test_place_non_integer_y_coordinates_returns_error
    # Arrange - setup done in setup method

    # Act & Assert
    assert_raises(ArgumentError) do
      @parser.parse('PLACE asdf,0,NORTH')
    end
  end

  def test_parser_raises_error_for_put_obstacle_command_without_arguments
    # Arrange - setup done in setup method

    # Act & Assert
    assert_raises(ArgumentError) do
      @parser.parse('PUT_OBSTACLE')
    end
  end

  def test_parser_raises_error_for_put_obstacle_command_with_invalid_format
    # Arrange - setup done in setup method

    # Act & Assert
    assert_raises(ArgumentError) do
      @parser.parse('PUT_OBSTACLE 0')
    end
  end

  def test_parser_raises_error_for_put_obstacle_with_non_integer_coordinates
    # Arrange - setup done in setup method

    # Act & Assert
    assert_raises(ArgumentError) do
      @parser.parse('PUT_OBSTACLE x,y')
    end
  end
end
