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
      robot = @robot
      return unless robot

      new_robot = robot.move
      if @board.valid?(new_robot.position)
        @robot = new_robot
      else
        warn 'Movement would cause robot to fall off table'
      end
    end

    def turn_robot_left
      robot = @robot
      return unless robot

      @robot = robot.turn_left
    end

    def turn_robot_right
      robot = @robot
      return unless robot

      @robot = robot.turn_right
    end
  end
end
