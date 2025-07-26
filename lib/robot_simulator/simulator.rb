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
      @cli.show_intro
      setup_signal_handling
      run_command_loop
    end

    private

    def setup_signal_handling
      Signal.trap('INT') do
        shutdown
      end
    end

    def run_command_loop
      loop do
        @cli.read_command do |command|
          shutdown if command.is_a?(Command::Exit)
          result = command.execute(@controller)

          @cli.handle_result(result)
        end
      end
    end

    # Unceremoniously exit the simulator
    def shutdown
      puts "\n"
      exit(0)
    end
  end
end
