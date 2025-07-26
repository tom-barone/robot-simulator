# frozen_string_literal: true

require 'test_helper'
require 'stringio'

class CLITest < Minitest::Test
  include RobotSimulator

  def test_cli_can_be_created_with_no_parameters
    # Arrange
    # No setup needed

    # Act
    cli = CLI.new

    # Assert
    refute_nil cli
  end

  def test_cli_has_run_method_that_accepts_block
    # Arrange
    cli = CLI.new

    # Act & Assert
    assert_respond_to cli, :run
  end

  def test_cli_strips_whitespace_from_input_lines
    # Arrange
    cli = CLI.new
    input = StringIO.new("  test input  \n")
    received_input = nil
    original_stdin = $stdin

    # Act
    $stdin = input
    cli.run { |line| received_input = line }

    # Assert
    assert_equal 'test input', received_input
  ensure
    $stdin = original_stdin
  end
end
