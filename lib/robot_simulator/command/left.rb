# frozen_string_literal: true

module RobotSimulator
  module Command
    # Command to turn robot left with robot existence check
    class Left
      def initialize(controller)
        @controller = controller
      end

      def execute
        robot = @controller.robot
        return Result.error(NoRobotPlacedError) unless robot

        new_robot = robot.turn_left
        @controller.update_robot(new_robot)
        Result.success
      end
    end
  end
end
