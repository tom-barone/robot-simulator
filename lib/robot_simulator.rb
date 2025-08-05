# frozen_string_literal: true

require_relative 'robot_simulator/board'
require_relative 'robot_simulator/direction'
require_relative 'robot_simulator/errors'
require_relative 'robot_simulator/position'
require_relative 'robot_simulator/robot'
require_relative 'robot_simulator/controller'
require_relative 'robot_simulator/simulator'
require_relative 'robot_simulator/cli'

require_relative 'robot_simulator/command/result'
require_relative 'robot_simulator/command/exit'
require_relative 'robot_simulator/command/find'
require_relative 'robot_simulator/command/find_moves'
require_relative 'robot_simulator/command/left'
require_relative 'robot_simulator/command/move'
require_relative 'robot_simulator/command/place'
require_relative 'robot_simulator/command/put_obstacle'
require_relative 'robot_simulator/command/report'
require_relative 'robot_simulator/command/right'
require_relative 'robot_simulator/command/string_parser'

# Simulation of a robot moving around a board
module RobotSimulator; end

# Run the simulator if this file is executed directly
RobotSimulator::Simulator.new.run if __FILE__ == $PROGRAM_NAME
