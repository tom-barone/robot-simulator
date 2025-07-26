# frozen_string_literal: true

require 'test_helper'
require 'stringio'

class CLITest < Minitest::Test
  include RobotSimulator

  def test_cli_can_read_input_line_and_yield_parsed_command_object
    # Arrange
    parser = Command::StringParser.new
    cli = CLI.new(parser)
    input = StringIO.new("PLACE 1,2,NORTH\n")
    original_stdin = $stdin
    yielded_command = nil

    # Act
    $stdin = input
    cli.read_command { |cmd| yielded_command = cmd }

    # Assert
    assert_instance_of Command::Place, yielded_command
  ensure
    $stdin = original_stdin
  end

  def test_cli_trims_whitespace_from_input_lines_before_parsing
    # Arrange
    mock_parser = Minitest::Mock.new
    cli = CLI.new(mock_parser)
    expected_command = create_place_command
    mock_parser.expect(:parse, expected_command, ['PLACE 1,2,NORTH'])
    yielded_command = nil

    # Act
    with_input("  PLACE 1,2,NORTH  \n") do
      cli.read_command { |cmd| yielded_command = cmd }
    end

    # Assert
    mock_parser.verify

    assert_equal expected_command, yielded_command
  end

  def test_cli_handles_nil_input_gracefully
    # Arrange
    parser = Command::StringParser.new
    cli = CLI.new(parser)
    yielded_command = :not_called

    # Act
    with_input('') { cli.read_command { |cmd| yielded_command = cmd } }

    # Assert
    assert_equal :not_called, yielded_command
  end

  def test_cli_outputs_successful_report_command_results_to_stdout
    # Arrange
    parser = Command::StringParser.new
    cli = CLI.new(parser)
    successful_result = Command::Result.success('1,2,NORTH')
    original_stdout = $stdout
    output = StringIO.new

    # Act
    $stdout = output
    cli.handle_result(successful_result)

    # Assert
    assert_equal "Output: 1,2,NORTH\n", output.string
  ensure
    $stdout = original_stdout
  end

  def test_cli_prints_intro_message
    # Arrange
    parser = Command::StringParser.new
    cli = CLI.new(parser)
    original_stdout = $stdout
    output = StringIO.new

    # Act
    $stdout = output
    cli.show_intro

    # Assert
    assert_match(/Welcome to the Robot Simulator!/, output.string)
  ensure
    $stdout = original_stdout
  end

  private

  def create_place_command
    Command::Place.new(Position.new(1, 2), Direction::NORTH)
  end

  def with_input(input_string)
    original_stdin = $stdin
    $stdin = StringIO.new(input_string)
    yield
  ensure
    $stdin = original_stdin
  end
end
