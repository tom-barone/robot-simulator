# frozen_string_literal: true

module RobotSimulator
  module Commands
    # Represents a command and its execution result, either success or error
    class Command
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
