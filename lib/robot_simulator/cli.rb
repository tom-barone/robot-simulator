# frozen_string_literal: true

module RobotSimulator
  # Reads commands from standard input and displays results to standard output.
  class CLI
    INTRO = <<~INTRO
      Welcome to the Robot Simulator!
      Type your commands below. Available commands:
      - PLACE X,Y,F (e.g., PLACE 0,0,NORTH)
      - MOVE
      - LEFT
      - RIGHT
      - REPORT
      - EXIT
      You may also use Ctrl-C to quit.
    INTRO

    def initialize(parser)
      @parser = parser
      # puts INTRO
    end

    def read_command
      input = $stdin.gets || ''
      begin
        command = @parser.parse(input.strip)
        yield command if block_given?
      rescue StandardError => e
        handle_result(Command::Result.error(e))
      end
    end

    def handle_result(result)
      if result.error?
        puts "Error: #{result.error_message}"
      elsif result.value
        puts "Output: #{result.value}"
      end
    end
  end
end
