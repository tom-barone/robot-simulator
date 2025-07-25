# frozen_string_literal: true

module RobotSimulator
  # The directions a robot can face and methods to manipulate
  # those directions.
  module Direction
    NORTH = :north
    SOUTH = :south
    EAST = :east
    WEST = :west

    CLOCKWISE = [NORTH, EAST, SOUTH, WEST].freeze

    def self.turn_right(direction)
      current_index = CLOCKWISE.index(direction)
      unless current_index
        raise ArgumentError,
              "Invalid direction: #{direction}"
      end

      CLOCKWISE[(current_index + 1) % 4]
    end

    def self.turn_left(direction)
      current_index = CLOCKWISE.index(direction)
      unless current_index
        raise ArgumentError,
              "Invalid direction: #{direction}"
      end

      CLOCKWISE[(current_index - 1) % 4]
    end
  end
end
