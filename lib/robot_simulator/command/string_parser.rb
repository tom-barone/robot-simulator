# frozen_string_literal: true

module RobotSimulator
  module Command
    # Parses strings into command objects
    class StringParser
      def parse(input)
        parts = input.strip.split
        command_name = parts[0]

        create_command(command_name, parts[1])
      end

      private

      def create_command(command_name, args)
        case command_name
        when 'PLACE' then parse_place_command(args)
        when 'MOVE' then Command::Move.new
        when 'LEFT' then Command::Left.new
        when 'RIGHT' then Command::Right.new
        when 'REPORT' then Command::Report.new
        when 'EXIT' then Command::Exit.new
        else
          raise ArgumentError, "Invalid command '#{command_name}'"
        end
      end

      def parse_place_command(args)
        if args.nil? || args.empty?
          raise ArgumentError,
                'Invalid command: PLACE command requires arguments'
        end

        parts = args.split(',')
        validate_place_format(parts)

        x, y, direction_str = extract_place_components(parts)
        position = Position.new(x, y)
        direction = parse_direction(direction_str)
        Command::Place.new(position, direction)
      end

      def validate_place_format(parts)
        return if parts.length == 3

        raise ArgumentError,
              'Invalid command: PLACE command requires the format X,Y,DIRECTION'
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
          raise ArgumentError, "Invalid direction '#{direction_str}'"
        end
      end
    end
  end
end
