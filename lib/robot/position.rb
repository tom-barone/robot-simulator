# frozen_string_literal: true

# Represents a coordinate position on the robot board
class Position
  attr_reader :x, :y

  def initialize(x_coord, y_coord)
    @x = x_coord
    @y = y_coord
  end
end
