# frozen_string_literal: true

require 'test_helper'

class ObstacleIntegrationTest < Minitest::Test
  include RobotSimulator

  def test_complete_obstacle_workflow
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    parser = Command::StringParser.new

    # Act & Assert - Place obstacle before robot
    put_obstacle_command = parser.parse('PUT_OBSTACLE 0,1')
    result = put_obstacle_command.execute(controller)

    assert_predicate result, :success?

    # Place robot at valid position
    place_command = parser.parse('PLACE 0,0,NORTH')
    result = place_command.execute(controller)

    assert_predicate result, :success?

    # Try to move robot into obstacle - should fail
    move_command = parser.parse('MOVE')
    result = move_command.execute(controller)

    assert_predicate result, :error?
    assert_instance_of ObstacleInTheWayError, result.error
  end

  def test_obstacle_blocks_robot_placement
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    parser = Command::StringParser.new

    # Act & Assert - Place obstacle
    put_obstacle_command = parser.parse('PUT_OBSTACLE 2,3')
    result = put_obstacle_command.execute(controller)

    assert_predicate result, :success?

    # Try to place robot on obstacle - should fail
    place_command = parser.parse('PLACE 2,3,NORTH')
    result = place_command.execute(controller)

    assert_predicate result, :error?
    assert_instance_of ObstacleInTheWayError, result.error
  end

  def test_multiple_obstacles_block_movement_in_all_directions
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    parser = Command::StringParser.new

    # Place robot in center
    place_command = parser.parse('PLACE 2,2,NORTH')
    result = place_command.execute(controller)

    assert_predicate result, :success?

    # Place obstacles in all four directions
    %w[2,3 2,1 3,2 1,2].each do |position|
      put_obstacle_command = parser.parse("PUT_OBSTACLE #{position}")
      result = put_obstacle_command.execute(controller)

      assert_predicate result, :success?
    end

    # Try to move in each direction - all should fail
    %w[NORTH SOUTH EAST WEST].each do |direction|
      # Turn robot to face direction
      case direction
      when 'NORTH'
        # Already facing north
      when 'SOUTH'
        parser.parse('RIGHT').execute(controller)
        parser.parse('RIGHT').execute(controller)
      when 'EAST'
        parser.parse('RIGHT').execute(controller)
      when 'WEST'
        parser.parse('LEFT').execute(controller)
      end

      # Try to move - should fail
      move_command = parser.parse('MOVE')
      result = move_command.execute(controller)

      # Assert
      assert_predicate result, :error?
      assert_instance_of ObstacleInTheWayError, result.error
    end
  end
end
