# frozen_string_literal: true

module RobotSimulator
  # Main simulator class that manages robot and board state
  class Simulator
    attr_reader :board, :robot

    def initialize(width, height)
      @board = Board.new(width, height)
      @robot = nil
      @controller = Controller.new(@robot, @board)
    end

    def place_robot(position, direction)
      @robot = Robot.new(position, direction)
      @controller = Controller.new(@robot, @board)
    end

    def move_robot
      command = Commands::MoveCommand.new(@controller)
      result = @controller.execute(command)
      @robot = @controller.robot if result.success?
      result
    end

    def turn_left
      command = Commands::LeftCommand.new(@controller)
      result = @controller.execute(command)
      @robot = @controller.robot if result.success?
      result
    end

    def turn_right
      command = Commands::RightCommand.new(@controller)
      result = @controller.execute(command)
      @robot = @controller.robot if result.success?
      result
    end
  end
end
