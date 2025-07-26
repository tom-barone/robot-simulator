# frozen_string_literal: true

module RobotSimulator
  module Command
    # Represents the result of command execution.
    # Let's us gracefully handle errors if the command fails.
    class Result
      attr_reader :error, :value

      def initialize(error: nil, value: nil)
        @error = error
        @value = value
      end

      def self.success(value = nil)
        new(value: value)
      end

      def self.error(error_class)
        new(error: error_class.new)
      end

      def success?
        @error.nil?
      end

      def error?
        !@error.nil?
      end

      def error_message
        @error&.message
      end
    end
  end
end
