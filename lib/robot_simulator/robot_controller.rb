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
      Commands::MoveCommand.new(self).execute
    end

    def turn_robot_left
      Commands::LeftCommand.new(self).execute
    end

    def turn_robot_right
      Commands::RightCommand.new(self).execute
    end
  end
end
