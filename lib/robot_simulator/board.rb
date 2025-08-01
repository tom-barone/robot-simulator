# frozen_string_literal: true

module RobotSimulator
  # Represents a rectangular board with defined boundaries
  class Board
    attr_reader :width, :height, :obstacles

    def initialize(width, height, obstacles = Set.new)
      @width = width
      @height = height
      @obstacles = obstacles
    end

    def valid?(position)
      position.x >= 0 && position.x < @width &&
        position.y >= 0 && position.y < @height
    end

    def obstacle?(position)
      @obstacles.include?(position)
    end

    def add_obstacle(position)
      new_obstacles = @obstacles.dup
      new_obstacles.add(position)

      Board.new(@width, @height, new_obstacles)
    end
  end
end
