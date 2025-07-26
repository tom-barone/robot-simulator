# TDD Implementation Plan - CLI Infrastructure

This plan completes the robot simulator by implementing the missing CLI infrastructure using Test-Driven Development. The domain logic (Robot, Position, Direction, Board, Commands, etc.) is already implemented and tested.

**Current State**: All domain objects, commands, and business logic are complete. Missing only the CLI interface layer to meet requirements.

## Architecture Overview

**CLI Class**: Pure I/O interface with methods for getting user input and displaying output
**Simulator Class**: Main controller that owns the event loop and coordinates between CLI and business logic

This separation provides better testability and follows single responsibility principle.

## Phase 1: CLI as I/O Interface

### Step 1: CLI Initialization

- **Red**: Test CLI can be created with parser dependency
- **Green**: Create CLI class with constructor accepting Command::StringParser
- **Refactor**: Assess if any improvements needed

### Step 2: CLI Input Method

- **Red**: Test CLI can read input line and return parsed Command object
- **Green**: Implement get_command method that reads from stdin and uses parser
- **Refactor**: Assess if any improvements needed

### Step 3: CLI Input Sanitization

- **Red**: Test CLI trims whitespace from input lines before parsing
- **Green**: Implement input.strip in get_command before parsing
- **Refactor**: Assess if any improvements needed

### Step 4: CLI Output Method

- **Red**: Test CLI outputs only successful REPORT command results to stdout
- **Green**: Implement display_result method that outputs only REPORT success values
- **Refactor**: Assess if any improvements needed

## Phase 2: Simulator as Main Controller

### Step 5: Simulator Dependency Wiring

- **Red**: Test Simulator creates 5x5 board, controller, parser, and CLI correctly
- **Green**: Implement dependency creation in Simulator constructor
- **Refactor**: Assess if any improvements needed

### Step 6: Simulator Event Loop

- **Red**: Test Simulator runs continuous loop calling CLI for input
- **Green**: Implement run method with loop calling cli.get_command
- **Refactor**: Assess if any improvements needed

### Step 7: Simulator Command Execution

- **Red**: Test Simulator executes commands via controller and handles results
- **Green**: Implement command execution and result processing in event loop
- **Refactor**: Assess if any improvements needed

### Step 8: Simulator Error Handling

- **Red**: Test Simulator silently ignores command failures and parsing errors
- **Green**: Implement silent error handling (no output for errors per requirements)
- **Refactor**: Assess if any improvements needed

## Phase 3: Integration and Executable

### Step 9: End-to-End Integration Test

- **Red**: Test complete command sequence matches requirements example
- **Green**: Create integration test simulating stdin input and capturing stdout
- **Refactor**: Assess if any improvements needed

### Step 10: Error Boundary Integration

- **Red**: Test invalid commands and boundary violations produce no output
- **Green**: Verify silent error handling works end-to-end
- **Refactor**: Assess if any improvements needed

### Step 11: REPORT Output Format Verification

- **Red**: Test REPORT commands output exact format "X,Y,DIRECTION"
- **Green**: Verify output format matches requirements exactly
- **Refactor**: Assess if any improvements needed

### Step 12: Main Executable Creation

- **Red**: Test bin/robot script requires library and runs Simulator
- **Green**: Create executable script with shebang, require, and Simulator.new.run
- **Refactor**: Assess if any improvements needed

## Implementation Notes

### Architecture Benefits
- **CLI as Pure I/O Interface:** get_command() and display_result() methods only
- **Simulator as Main Controller:** Owns event loop and coordinates application flow
- **Better Separation of Concerns:** I/O logic separate from flow control logic
- **Improved Testability:** Can mock CLI interface for Simulator testing

### Implementation Details
- All domain logic is already tested and working
- Focus tests on CLI I/O behavior and Simulator coordination
- Use StringIO for testing stdin/stdout in CLI tests
- Leverage existing Command::StringParser for input parsing in CLI
- Maintain existing Result-based error handling pattern in Simulator
- Each step follows strict TDD: write failing test first, implement minimal code to pass, then assess refactoring opportunities

### Key Requirements to Verify
- Only REPORT commands produce output (handled in CLI.display_result)
- No error messages or acknowledgments (handled in Simulator error handling)
- Silent handling of invalid commands (Simulator ignores Result.error cases)
- Continuous processing until Ctrl-C (Simulator event loop with default signal handling)
- Exact output format "X,Y,DIRECTION" (CLI formats REPORT results)
- Whitespace trimming on input lines (CLI.get_command strips input)

### Class Responsibilities
- **CLI:** Input parsing (get_command), output formatting (display_result)
- **Simulator:** Event loop, command execution coordination, error handling
- **Controller:** Business logic execution (already implemented)
- **Commands:** Domain operations (already implemented)

