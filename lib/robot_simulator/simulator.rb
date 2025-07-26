# frozen_string_literal: true

module RobotSimulator
  # Main simulator class that manages robot and board state
  class Simulator
    attr_reader :controller

    def initialize(width, height)
      board = Board.new(width, height)
      @controller = Controller.new(nil, board)
    end

    def place_robot(position, direction)
      command = Command::Place.new(position, direction)
      command.execute(@controller)
    end

    def move_robot
      command = Command::Move.new
      command.execute(@controller)
    end

    def turn_left
      command = Command::Left.new
      command.execute(@controller)
    end

    def turn_right
      command = Command::Right.new
      command.execute(@controller)
    end

    def report_robot
      command = Command::Report.new
      command.execute(@controller)
    end
  end
end
