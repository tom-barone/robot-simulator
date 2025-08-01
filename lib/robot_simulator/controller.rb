# frozen_string_literal: true

module RobotSimulator
  # Manages robot & board state.
  # This will be passed to our commands to execute actions
  class Controller
    attr_reader :robot, :board

    def initialize(robot, board)
      @robot = robot
      @board = board
    end

    def update_robot(new_robot)
      @robot = new_robot
    end

    def update_board(new_board)
      @board = new_board
    end
  end
end
