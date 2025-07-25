# frozen_string_literal: true

module RobotSimulator
  module Commands
    # Command to move robot forward with boundary validation
    class MoveCommand < Command
      def initialize(controller)
        @controller = controller
        super(false, nil)
      end

      def execute
        robot = @controller.robot
        return Command.error(NoRobotPlacedError) unless robot

        new_robot = robot.move
        if @controller.board.valid?(new_robot.position)
          @controller.update_robot(new_robot)
          Command.success
        else
          Command.error(RobotWouldFallError)
        end
      end
    end
  end
end
