# frozen_string_literal: true

module RobotSimulator
  # Main simulator class that manages robot and board state
  class Simulator
    attr_reader :controller, :parser, :cli

    def initialize(width = 5, height = 5)
      board = Board.new(width, height)
      @controller = Controller.new(nil, board)
      @parser = Command::StringParser.new
      @cli = CLI.new(@parser)
    end

    def run
      loop do
        command = @cli.read_command
        break if command.nil?

        result = command.execute(@controller)
        @cli.handle_result(result)
      rescue StandardError
        # Silent error handling - continue processing without output
        next
      end
    end

    # Legacy methods - will be removed after new architecture is complete
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
