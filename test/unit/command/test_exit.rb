# frozen_string_literal: true

require 'test_helper'

class ExitCommandTest < Minitest::Test
  include RobotSimulator

  def test_exit_command_execute_returns_success_result_with_exit_signal
    # Arrange
    board = Board.new(5, 5)
    controller = Controller.new(nil, board)
    command = Command::Exit.new

    # Act
    result = command.execute(controller)

    # Assert
    assert_predicate result, :success?
    assert_nil result.value
  end
end
