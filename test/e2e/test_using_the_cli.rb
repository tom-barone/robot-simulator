# frozen_string_literal: true

require 'pty'
require 'test_helper'

class UsingTheCLITest < Minitest::Test
  def test_driving_and_exiting_with_commands
    spawn_simulator do |output, input, _pid|
      input.puts 'PLACE 0,0,NORTH'
      input.puts 'REPORT'
      input.puts 'EXIT'
      input.flush
      output_string = output.read

      assert_match(/Welcome to the Robot Simulator!/, output_string)
      assert_match(/Output: 0,0,NORTH/, output_string)
    end
  end

  def test_exiting_with_ctrl_c
    spawn_simulator do |output, input, pid|
      input.puts 'PLACE 0,0,NORTH'
      input.puts 'REPORT'
      input.flush
      sleep 0.5 # Allow time for the simulator to process the input
      Process.kill('INT', pid) # Simulate Ctrl+C
      output_string = output.read

      assert_match(/Welcome to the Robot Simulator!/, output_string)
      assert_match(/Output: 0,0,NORTH/, output_string)
    end
  end

  def spawn_simulator
    PTY.spawn('ruby', 'lib/robot_simulator.rb') do |output, input, pid|
      yield output, input, pid
    rescue Errno::EIO
      # Ignore EIO errors that can occur when the PTY is closed
    end
  end
end
