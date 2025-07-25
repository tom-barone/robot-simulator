# frozen_string_literal: true

module RobotSimulator
  module Command
    # Command to place robot at specified position and direction
    class Place
      def initialize(controller, position, direction)
        @controller = controller
        @position = position
        @direction = direction
      end

      def execute
        if @controller.board.valid?(@position)
          robot = Robot.new(@position, @direction)
          @controller.update_robot(robot)
          Result.success
        else
          Result.error(RobotWouldFallError)
        end
      end
    end
  end
end
