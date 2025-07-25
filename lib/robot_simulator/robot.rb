# frozen_string_literal: true

module RobotSimulator
  # Represents a robot that can be placed and moved on a board
  class Robot
    attr_reader :position, :direction

    def initialize(position, direction)
      @position = position
      @direction = direction
    end
  end
end
