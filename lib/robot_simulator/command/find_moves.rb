# frozen_string_literal: true

module RobotSimulator
  module Command
    # Command to find sequence of moves from robot's current position to goal
    class FindMoves
      attr_reader :goal_position

      def initialize(goal_position)
        @goal_position = goal_position
      end

      def execute(controller)
        robot = controller.robot
        return Result.error(NoRobotPlacedError) unless robot

        # If robot is already at goal, return empty command list
        if robot.position == @goal_position
          return Result.success([])
        end

        # Get path from pathfinding and convert to commands
        path = find_path(robot.position, @goal_position, controller.board)
        return Result.success([]) if path.empty?

        commands = path_to_commands(path, robot.direction)
        Result.success(commands)
      end

      private

      def find_path(start, goal, board)
        # Delegate to Find command pathfinding logic
        find_command = Find.new(goal)
        # Create temporary controller to reuse pathfinding
        # direction doesn't matter for pathfinding
        temp_robot = Robot.new(start, Direction::NORTH)
        temp_controller = Controller.new(temp_robot, board)
        result = find_command.execute(temp_controller)

        if result.success? && result.value.is_a?(Array)
          result.value
        else
          []
        end
      end

      def path_to_commands(path, current_direction)
        commands = [] # : Array[command_t]
        direction = current_direction

        # Skip first position (current robot position) and process each step
        (1...path.length).each do |i|
          from_pos = path[i - 1]
          to_pos = path[i]

          # Calculate required direction for this step
          required_direction = calculate_direction(from_pos, to_pos)

          # Add turn commands to face the required direction
          turn_commands = generate_turn_commands(direction, required_direction)
          commands.concat(turn_commands)
          direction = required_direction

          # Add move command
          commands << Command::Move.new
        end

        commands
      end

      def calculate_direction(from_pos, to_pos)
        dx = to_pos.x - from_pos.x
        dy = to_pos.y - from_pos.y

        case [dx, dy]
        when [0, 1] then Direction::NORTH
        when [1, 0] then Direction::EAST
        when [0, -1] then Direction::SOUTH
        when [-1, 0] then Direction::WEST
        else
          raise ArgumentError, "Invalid move: positions not adjacent"
        end
      end

      def generate_turn_commands(current_direction, target_direction)
        return [] if current_direction == target_direction

        # Calculate minimum turns using clockwise array
        clockwise = Direction::CLOCKWISE
        current_index = clockwise.index(current_direction)
        target_index = clockwise.index(target_direction)

        return [] unless current_index && target_index

        # Calculate turns needed in both directions
        right_turns = (target_index - current_index) % 4
        left_turns = (current_index - target_index) % 4

        # Choose the shorter path
        if right_turns <= left_turns
          Array.new(right_turns) { Command::Right.new }
        else
          Array.new(left_turns) { Command::Left.new }
        end
      end
    end
  end
end
