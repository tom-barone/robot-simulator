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
      command = Command::Place.new(@controller, position, direction)
      command.execute
    end

    def move_robot
      command = Command::Move.new(@controller)
      command.execute
    end

    def turn_left
      command = Command::Left.new(@controller)
      command.execute
    end

    def turn_right
      command = Command::Right.new(@controller)
      command.execute
    end
  end
end
