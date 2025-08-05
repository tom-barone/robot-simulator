# frozen_string_literal: true

module RobotSimulator
  # Reads commands from standard input and displays results to standard output.
  class CLI
    INTRO = <<~INTRO
      Welcome to the Robot Simulator!
      Type your commands below. Available commands:
      - PLACE X,Y,F (e.g., PLACE 0,0,NORTH)
      - PUT_OBSTACLE X,Y (e.g., PUT_OBSTACLE 2,3)
      - FIND X,Y (e.g., FIND 3,4)
      - MOVE
      - LEFT
      - RIGHT
      - REPORT
      - EXIT
      You may also use Ctrl-C to quit.

    INTRO

    def initialize(parser)
      @parser = parser
    end

    def show_intro
      puts INTRO
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
        output = format_output(result.value)
        puts "Output: #{output}"
      end
    end

    private

    def format_output(value)
      case value
      when Array
        # Handle path arrays from FIND command
        if value.empty?
          'No path found'
        else
          value.map { |pos| "#{pos.x},#{pos.y}" }.join(' -> ')
        end
      else
        value.to_s
      end
    end
  end
end
