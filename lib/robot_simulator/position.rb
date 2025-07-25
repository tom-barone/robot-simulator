# frozen_string_literal: true

module RobotSimulator
  # Represents a coordinate position on the robot board.
  class Position
    attr_reader :x, :y

    def initialize(x_coord, y_coord)
      @x = x_coord
      @y = y_coord
    end

    def ==(other)
      return false unless other.is_a?(Position)

      @x == other.x && @y == other.y
    end

    def move(direction)
      warn_if_excessive_coordinates
      case direction
      when Direction::NORTH then Position.new(@x, @y + 1)
      when Direction::SOUTH then Position.new(@x, @y - 1)
      when Direction::EAST then Position.new(@x + 1, @y)
      when Direction::WEST then Position.new(@x - 1, @y)
      else
        raise ArgumentError, "Unhandled direction: #{direction}"
      end
    end

    private

    # Ruby will handle practically any integer size, but we may want to revisit
    # our thinking if we ever come across some crazy large numbers.
    def warn_if_excessive_coordinates
      return unless @x.abs > 100_000 || @y.abs > 100_000

      warn "Warning: Excessively large coordinates (#{@x}, #{@y})"
    end
  end
end
