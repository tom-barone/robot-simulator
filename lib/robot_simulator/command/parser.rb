# frozen_string_literal: true

module RobotSimulator
  module Command
    # Parses strings into command objects
    class StringParser
      def parse(input, controller)
        parts = input.strip.split
        command_name = parts[0]

        case command_name
        when 'PLACE' then parse_place_command(parts[1], controller)
        when 'MOVE' then Command::Move.new(controller)
        when 'LEFT' then Command::Left.new(controller)
        when 'RIGHT' then Command::Right.new(controller)
        when 'REPORT' then Command::Report.new(controller)
        end
      end

      private

      def parse_place_command(args, controller)
        parts = args.split(',')
        x = parts[0].to_i
        y = parts[1].to_i
        direction_str = parts[2] || ''
        position = Position.new(x, y)
        direction = parse_direction(direction_str)
        Command::Place.new(controller, position, direction)
      end

      def parse_direction(direction_str)
        case direction_str
        when 'NORTH' then Direction::NORTH
        when 'SOUTH' then Direction::SOUTH
        when 'EAST' then Direction::EAST
        when 'WEST' then Direction::WEST
        else
          raise ArgumentError, "Invalid direction: #{direction_str}"
        end
      end
    end
  end
end
