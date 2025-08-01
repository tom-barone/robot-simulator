# frozen_string_literal: true

require 'set'

module RobotSimulator
  module Command
    # Command to find path from robot's current position to goal position
    class Find
      attr_reader :goal_position

      def initialize(goal_position)
        @goal_position = goal_position
      end

      def execute(controller)
        robot = controller.robot
        return Result.error(NoRobotPlacedError) unless robot

        start_position = robot.position

        # If start equals goal, return path with just the starting point
        if start_position == @goal_position
          return Result.success([start_position])
        end

        # BFS pathfinding algorithm
        path = find_path(start_position, @goal_position, controller.board)
        Result.success(path)
      end

      private

      def find_path(start, goal, board)
        # Queue stores: [current_position, path_of_positions]
        queue = [[start, [start]]]
        visited = Set.new([start])

        # Directions: up, right, down, left
        directions = [
          [0, 1],   # up (NORTH)
          [1, 0],   # right (EAST)
          [0, -1],  # down (SOUTH)
          [-1, 0]   # left (WEST)
        ]

        until queue.empty?
          queue_item = queue.shift
          next unless queue_item && queue_item.is_a?(Array) &&
                      queue_item.length == 2

          current_pos = queue_item[0]
          path = queue_item[1]

          next unless current_pos.is_a?(Position) && path.is_a?(Array)

          directions.each do |direction|
            dx, dy = direction
            next_x = current_pos.x + dx.to_i
            next_y = current_pos.y + dy.to_i
            next_pos = Position.new(next_x, next_y)

            # Check if we reached the goal
            return path + [next_pos] if next_pos == goal

            # Check if valid and unvisited
            if valid_move?(next_pos, board) && !visited.include?(next_pos)
              visited.add(next_pos)
              new_path = path + [next_pos]
              queue.push([next_pos, new_path])
            end
          end
        end

        # No path found
        []
      end

      def valid_move?(position, board)
        board.valid?(position) && !board.obstacle?(position)
      end
    end
  end
end
