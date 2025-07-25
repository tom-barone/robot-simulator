# frozen_string_literal: true

module RobotSimulator
  module Commands
    # Command to turn robot right with robot existence check
    class RightCommand < Command
      def initialize(controller)
        @controller = controller
        super(false, nil)
      end

      def execute
        robot = @controller.robot
        return Command.error(NoRobotPlacedError) unless robot

        new_robot = robot.turn_right
        @controller.instance_variable_set(:@robot, new_robot)
        Command.success
      end
    end
  end
end
