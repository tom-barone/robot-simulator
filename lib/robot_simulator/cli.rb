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
      - FIND_MOVES X,Y (e.g., FIND_MOVES 3,4)
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
        if value.empty?
          'No path found'
        elsif value.first.is_a?(Position)
          # Handle path arrays from FIND command
          value.map { |pos| "#{pos.x},#{pos.y}" }.join(' -> ')
        else
          # Handle command arrays from FIND_MOVES command
          value.map { |cmd| command_to_string(cmd) }.join(' -> ')
        end
      else
        value.to_s
      end
    end

    def command_to_string(command)
      case command
      when Command::Move then 'MOVE'
      when Command::Left then 'LEFT'
      when Command::Right then 'RIGHT'
      else
        command.class.name.split('::').last.upcase
      end
    end
  end
end
