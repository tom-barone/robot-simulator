# frozen_string_literal: true

module RobotSimulator
  module Command
    # Command to place robot at specified position and direction
    class Place
      attr_reader :position, :direction

      def initialize(position, direction)
        @position = position
        @direction = direction
      end

      def execute(controller)
        unless controller.board.valid?(@position)
          return Result.error(RobotWouldFallError.new)
        end

        if controller.board.obstacle?(@position)
          return Result.error(ObstacleInTheWayError.new)
        end

        robot = Robot.new(@position, @direction)
        controller.update_robot(robot)
        Result.success
      end
    end
  end
end
