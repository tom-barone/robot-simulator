# frozen_string_literal: true

module RobotSimulator
  # Reads commands from standard input and displays results to standard output.
  class CLI
    def initialize(parser)
      @parser = parser
      print_introduction
    end

    def print_introduction
      puts <<~INTRO
        Welcome to the Robot Simulator!
        Type your commands below. Available commands:
        - PLACE X,Y,F (e.g., PLACE 0,0,NORTH)
        - MOVE
        - LEFT
        - RIGHT
        - REPORT

        Use Ctrl-C to quit.

      INTRO
    end

    def read_command
      input = $stdin.gets
      return if input.nil?

      @parser.parse(input.strip)
    end

    def handle_result(result)
      puts result.value if result.success?
    end
  end
end
