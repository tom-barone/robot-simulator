# frozen_string_literal: true

module RobotSimulator
  # Manages robot state and executes commands with boundary validation
  class RobotController
    attr_reader :robot, :board

    def initialize(robot, board)
      @robot = robot
      @board = board
    end

    def move_robot
      MoveCommand.new(self).execute
    end

    def turn_robot_left
      LeftCommand.new(self).execute
    end

    def turn_robot_right
      RightCommand.new(self).execute
    end
  end
end
