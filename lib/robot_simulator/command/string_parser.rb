# frozen_string_literal: true

module RobotSimulator
  module Command
    # Parses strings into command objects
    class StringParser
      def parse(input, controller)
        parts = input.strip.split
        command_name = parts[0]

        create_command(command_name, parts[1], controller)
      end

      private

      def create_command(command_name, args, controller)
        case command_name
        when 'PLACE' then parse_place_command(args, controller)
        when 'MOVE' then Command::Move.new(controller)
        when 'LEFT' then Command::Left.new(controller)
        when 'RIGHT' then Command::Right.new(controller)
        when 'REPORT' then Command::Report.new(controller)
        else
          raise ArgumentError, "Invalid command: #{command_name}"
        end
      end

      def parse_place_command(args, controller)
        if args.nil? || args.empty?
          raise ArgumentError,
                'PLACE command requires arguments'
        end

        parts = args.split(',')
        validate_place_format(parts)

        x, y, direction_str = extract_place_components(parts)
        position = Position.new(x, y)
        direction = parse_direction(direction_str)
        Command::Place.new(controller, position, direction)
      end

      def validate_place_format(parts)
        return if parts.length == 3

        raise ArgumentError, 'PLACE command requires X,Y,DIRECTION format'
      end

      def extract_place_components(parts)
        x = Integer(parts[0], 10)
        y = Integer(parts[1], 10)
        direction_str = parts[2] || ''
        [x, y, direction_str]
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
