# frozen_string_literal: true

module RobotSimulator
  module Command
    # Command to signal application termination
    # Does nothing when executed
    class Exit
      def execute(_controller)
        Result.success(nil)
      end
    end
  end
end
