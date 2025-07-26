# frozen_string_literal: true

require 'test_helper'
require 'stringio'

class CLITest < Minitest::Test
  include RobotSimulator

  def test_cli_can_be_created_with_parser_dependency
    # Arrange
    parser = Command::StringParser.new

    # Act
    cli = CLI.new(parser)

    # Assert
    refute_nil cli
  end

  def test_cli_can_read_input_line_and_return_parsed_command_object
    # Arrange
    parser = Command::StringParser.new
    cli = CLI.new(parser)
    input = StringIO.new("PLACE 1,2,NORTH\n")
    original_stdin = $stdin

    # Act
    $stdin = input
    command = cli.read_command

    # Assert
    assert_instance_of Command::Place, command
  ensure
    $stdin = original_stdin
  end

  def test_cli_trims_whitespace_from_input_lines_before_parsing
    # Arrange
    mock_parser = Minitest::Mock.new
    cli = CLI.new(mock_parser)
    expected_command = Command::Place.new(Position.new(1, 2), Direction::NORTH)
    mock_parser.expect(:parse, expected_command, ['PLACE 1,2,NORTH'])

    # Act
    with_input("  PLACE 1,2,NORTH  \n") { cli.read_command }

    # Assert
    mock_parser.verify
  end

  def test_cli_returns_nil_when_input_is_nil
    # Arrange
    parser = Command::StringParser.new
    cli = CLI.new(parser)

    # Act
    result = with_input('') { cli.read_command }

    # Assert
    assert_nil result
  end

  def test_cli_outputs_only_successful_report_command_results_to_stdout
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
    assert_equal "1,2,NORTH\n", output.string
  ensure
    $stdout = original_stdout
  end

  def test_cli_does_not_output_error_results
    # Arrange
    parser = Command::StringParser.new
    cli = CLI.new(parser)
    error_result = Command::Result.error(NoRobotPlacedError)
    original_stdout = $stdout
    output = StringIO.new

    # Act
    $stdout = output
    cli.handle_result(error_result)

    # Assert
    assert_equal '', output.string
  ensure
    $stdout = original_stdout
  end

  private

  def with_input(input_string)
    original_stdin = $stdin
    $stdin = StringIO.new(input_string)
    yield
  ensure
    $stdin = original_stdin
  end
end
