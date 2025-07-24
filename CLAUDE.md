# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

- `bundle install` - Install dependencies
- `bundle exec rake format` - Auto-format code
- `bundle exec rake lint` - Run code linting
- `bundle exec rake types` - Run type checking
- `bundle exec rake test` - Run all tests
- `bundle exec rake docs` - Generate documentation
- `bundle exec rake docker` - Build and test Docker image
- `bundle exec rake precommit` - Run all pre-commit checks

For more commands and details, refer to the `Rakefile` in the root of the repository.

Every single time you finish with a change, you will run `bundle exec rake precommit` to make sure all checks pass.

## Writing Code

You will always read and understand the documentation before proceeding with any code changes:

- @.claude/docs/requirements.md - Detailed functional and non-functional requirements.
- @.claude/docs/design.md - System design and class diagrams.
- @.claude/docs/plan.md - TDD implementation plan broken into small steps

After making code changes, be sure to update the rbs types in @sig

Where possible, prefer the use of Dependency Injection (DI) for long term maintabability and testability of the code:

- Use DI for services, repositories, and other dependencies that may change over time or need to be mocked in tests.
- Avoid hardcoding dependencies directly in classes.
- Use constructor injection or setter injection to provide dependencies to classes.

## Fixing linting and type issues

You must not use comments like `# rubocop:disable ...` or `# steep:disable ...` to ignore linting errors. Instead you will address the issues directly in the code.

## RuboCop Guidelines

You must never change the `.rubocop.yml` file, instead fix the linting errors by adjusting the code itself to follow the guidelines.

## Testing Guidelines

When writing tests, follow this format. Every test must have at most one assertion.

```ruby
require 'test_helper'

class UserTest < Minitest::Test
  def test_user_can_be_created_with_user_id_and_name
    # Arrange
    user_id = 'U123'
    name = 'John Doe'

    # Act
    user = ATM::User.new(user_id, name)

    # Assert
    refute_nil user
  end
end
```

If there is excessive repetition in the tests, consider refactoring the code to reduce duplication. Use helper methods or setup blocks to prepare common test data or state.
