# frozen_string_literal: true

module RobotSimulator
  # Represents a rectangular board with defined boundaries
  class Board
    attr_reader :width, :height

    def initialize(width, height)
      @width = width
      @height = height
    end

    def valid?(position)
      position.x >= 0 && position.x < @width &&
        position.y >= 0 && position.y < @height
    end
  end
end
