# frozen_string_literal: true

require_relative 'robot_simulator/board'
require_relative 'robot_simulator/direction'
require_relative 'robot_simulator/errors'
require_relative 'robot_simulator/position'
require_relative 'robot_simulator/robot'
require_relative 'robot_simulator/controller'
require_relative 'robot_simulator/simulator'

require_relative 'robot_simulator/commands/command'
require_relative 'robot_simulator/commands/left_command'
require_relative 'robot_simulator/commands/move_command'
require_relative 'robot_simulator/commands/place_command'
require_relative 'robot_simulator/commands/right_command'

# Simulation of a robot moving around a board
module RobotSimulator; end
