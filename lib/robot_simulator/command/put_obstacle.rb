# frozen_string_literal: true

module RobotSimulator
  module Command
    # Command to place an obstacle on the board
    class PutObstacle
      attr_reader :position

      def initialize(position)
        @position = position
      end

      def execute(controller)
        validation_error = validate_obstacle_placement(controller)
        return validation_error if validation_error

        new_board = controller.board.add_obstacle(@position)
        controller.update_board(new_board)
        Result.success(nil)
      end

      private

      def validate_obstacle_placement(controller)
        unless controller.board.valid?(@position)
          return Result.error(ObstacleWouldFallError.new)
        end
        if controller.board.obstacle?(@position)
          return Result.error(ObstacleInTheWayError.new)
        end
        if robot_at_position?(controller)
          return Result.error(RobotInTheWayError.new)
        end

        nil
      end

      def robot_at_position?(controller)
        controller.robot && controller.robot.position == @position
      end
    end
  end
end
