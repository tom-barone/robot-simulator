# frozen_string_literal: true

module RobotSimulator
  # Pure I/O handler for command-line interface
  class CLI
    def initialize
      # No dependencies needed for I/O operations
    end

    def run(&block)
      $stdin.each_line do |line|
        output = block.call(line.strip)
        puts output if output
      end
    end
  end
end
