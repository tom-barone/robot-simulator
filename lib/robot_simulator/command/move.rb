# frozen_string_literal: true

module RobotSimulator
  module Command
    # Command to move robot forward with boundary validation
    class Move
      def execute(controller)
        robot = controller.robot
        return Result.error(NoRobotPlacedError.new) unless robot

        new_robot = robot.move
        validation_error = validate_move(controller.board, new_robot.position)
        return validation_error if validation_error

        controller.update_robot(new_robot)
        Result.success
      end

      private

      def validate_move(board, position)
        unless board.valid?(position)
          return Result.error(RobotWouldFallError.new)
        end
        if board.obstacle?(position)
          return Result.error(ObstacleInTheWayError.new)
        end

        nil
      end
    end
  end
end
