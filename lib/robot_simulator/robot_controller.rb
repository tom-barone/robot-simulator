# frozen_string_literal: true

module RobotSimulator
  # Manages robot state and executes commands with boundary validation
  class RobotController
    attr_reader :robot, :board

    def initialize(robot, board)
      @robot = robot
      @board = board
    end

    def execute_command(command)
      command.execute
    end
  end
end
