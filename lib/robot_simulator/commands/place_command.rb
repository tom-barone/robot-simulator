# frozen_string_literal: true

module RobotSimulator
  module Commands
    # Command to place robot at specified position and direction
    class PlaceCommand < Command
      def initialize(controller, position, direction)
        @controller = controller
        @position = position
        @direction = direction
        super(false, nil)
      end

      def execute
        if @controller.board.valid?(@position)
          robot = Robot.new(@position, @direction)
          @controller.update_robot(robot)
          Command.success
        else
          Command.error(RobotWouldFallError)
        end
      end
    end
  end
end
