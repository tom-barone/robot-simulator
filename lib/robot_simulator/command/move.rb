# frozen_string_literal: true

module RobotSimulator
  module Command
    # Command to move robot forward with boundary validation
    class Move
      def initialize(controller)
        @controller = controller
      end

      def execute
        robot = @controller.robot
        return Result.error(NoRobotPlacedError) unless robot

        new_robot = robot.move
        if @controller.board.valid?(new_robot.position)
          @controller.update_robot(new_robot)
          Result.success
        else
          Result.error(RobotWouldFallError)
        end
      end
    end
  end
end
