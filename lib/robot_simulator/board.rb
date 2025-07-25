# frozen_string_literal: true

module RobotSimulator
  # Represents a rectangular board with defined boundaries
  class Board
    attr_reader :width, :height

    def initialize(width, height)
      @width = width
      @height = height
    end
  end
end
