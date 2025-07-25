# frozen_string_literal: true

module RobotSimulator
  module Command
    # Represents the result of command execution.
    # Let's us gracefully handle errors if the command fails.
    class Result
      attr_reader :error

      def initialize(success, error = nil)
        @success = success
        @error = error
      end

      def self.success
        new(true, nil)
      end

      def self.error(error_class)
        new(false, error_class.new)
      end

      def success?
        @success
      end

      def error?
        !@success
      end

      def error_message
        @error&.message
      end
    end
  end
end
