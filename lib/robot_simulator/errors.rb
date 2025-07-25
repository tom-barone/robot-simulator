# frozen_string_literal: true

module RobotSimulator
  class Error < StandardError; end

  class NoRobotPlacedError < Error; end
  class RobotWouldFallError < Error; end
end
