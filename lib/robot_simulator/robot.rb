# frozen_string_literal: true

module RobotSimulator
  # Represents a robot that can be placed and moved on a board
  class Robot
    attr_reader :position, :direction

    def initialize(position, direction)
      @position = position
      @direction = direction
    end

    def move
      new_position = @position.move(@direction)
      Robot.new(new_position, @direction)
    end

    def turn_left
      new_direction = Direction.turn_left(@direction)
      Robot.new(@position, new_direction)
    end

    def turn_right
      new_direction = Direction.turn_right(@direction)
      Robot.new(@position, new_direction)
    end
  end
end
