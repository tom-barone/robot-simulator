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

  # Raised when a robot movement or placement is blocked by an obstacle
  class ObstacleInTheWayError < Error
    def message
      'Obstacle in the way'
    end
  end

  # Raised when an obstacle placement is blocked by a robot
  class RobotInTheWayError < Error
    def message
      'Robot in the way'
    end
  end

  # Raised when an obstacle would be placed outside the board boundaries
  class ObstacleWouldFallError < Error
    def message
      'Obstacle would fall off the board'
    end
  end
end
