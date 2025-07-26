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
        if controller.board.valid?(@position)
          robot = Robot.new(@position, @direction)
          controller.update_robot(robot)
          Result.success
        else
          Result.error(RobotWouldFallError)
        end
      end
    end
  end
end
