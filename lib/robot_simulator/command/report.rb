# frozen_string_literal: true

module RobotSimulator
  module Command
    # Command to report robot's current position and direction
    class Report
      def execute(controller)
        robot = controller.robot
        return Result.error(NoRobotPlacedError) unless robot

        report_data = robot.report
        Result.success(report_data)
      end
    end
  end
end
