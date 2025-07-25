# frozen_string_literal: true

module RobotSimulator
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
        @controller.instance_variable_set(:@robot, new_robot)
        Command.success
      else
        Command.error(RobotWouldFallError)
      end
    end
  end
end
