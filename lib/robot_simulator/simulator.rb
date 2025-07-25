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
      @controller.update_robot(Robot.new(position, direction))
    end

    def move_robot
      command = Commands::MoveCommand.new(@controller)
      command.execute
    end

    def turn_left
      command = Commands::LeftCommand.new(@controller)
      command.execute
    end

    def turn_right
      command = Commands::RightCommand.new(@controller)
      command.execute
    end
  end
end
