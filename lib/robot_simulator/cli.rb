# frozen_string_literal: true

module RobotSimulator
  # Reads commands from standard input and displays results to standard output.
  class CLI
    def initialize(parser)
      @parser = parser
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
