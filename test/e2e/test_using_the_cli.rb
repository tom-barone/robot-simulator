# frozen_string_literal: true

require 'test_helper'

class UsingTheCLITest < Minitest::Test
  def test_driving_from_the_command_line_and_exiting
    # Arrange
    input = "PLACE 0,0,NORTH\nREPORT\nEXIT\n"

    # Act
    actual_output = capture_simulator_output(input)

    # Assert
    assert_match(/Welcome to the Robot Simulator!/, actual_output)
    assert_match(/Output: 0,0,NORTH/, actual_output)
  end

  private

  def capture_simulator_output(input)
    output_capture = StringIO.new

    with_redirected_io(input, output_capture) do
      run_simulator_with_exit_handling
    end

    output_capture.string
  end

  def with_redirected_io(input, output_capture)
    original_stdin = $stdin
    original_stdout = $stdout

    $stdin = StringIO.new(input)
    $stdout = output_capture

    yield
  ensure
    $stdin = original_stdin
    $stdout = original_stdout
  end

  def run_simulator_with_exit_handling
    simulator = RobotSimulator::Simulator.new(5, 5)

    begin
      simulator.run
    rescue SystemExit
      # Expected when EXIT command is processed
    end
  end
end
