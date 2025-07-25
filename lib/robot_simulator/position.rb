# frozen_string_literal: true

module RobotSimulator
  # Represents a coordinate position on the robot board.
  class Position
    attr_reader :x, :y

    def initialize(x_coord, y_coord)
      @x = x_coord
      @y = y_coord
    end

    def move(direction)
      case direction
      when Direction::NORTH
        Position.new(@x, @y + 1)
      when Direction::SOUTH
        Position.new(@x, @y - 1)
      when Direction::EAST
        Position.new(@x + 1, @y)
      when Direction::WEST
        Position.new(@x - 1, @y)
      end
    end
  end
end
