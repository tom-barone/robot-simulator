# frozen_string_literal: true

module RobotSimulator
  class Error < StandardError; end

  # Raised when performing an action that requires a robot to be placed
  # on the board
  class NoRobotPlacedError < Error
    def message
      'No robot has been placed on the board'
    end
  end

  # Raised when a robot attempts to move outside the boundaries of the board
  class RobotWouldFallError < Error
    def message
      'Robot would fall off the board'
    end
  end
end
