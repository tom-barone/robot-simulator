# frozen_string_literal: true

require_relative 'robot_simulator/errors'
require_relative 'robot_simulator/position'
require_relative 'robot_simulator/direction'
require_relative 'robot_simulator/board'
require_relative 'robot_simulator/robot'
require_relative 'robot_simulator/robot_controller'
require_relative 'robot_simulator/simulator'
require_relative 'commands/command'
require_relative 'commands/move_command'
require_relative 'commands/left_command'
require_relative 'commands/right_command'

# Robot simulator for controlling a robot on a 5x5 table
module RobotSimulator; end
