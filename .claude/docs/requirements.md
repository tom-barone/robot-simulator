# Robot Challenge Requirements

## Functional Requirements

### Robot Placement

- The system must allow placing a robot on a 5x5 table with PLACE X,Y,F command.
- X and Y coordinates must be integers from 0-4 (inclusive).
- F (facing direction) must be exactly NORTH, SOUTH, EAST, or WEST (case-sensitive).
- Origin (0,0) is at the SOUTH WEST corner of the table.
- Invalid placements outside table bounds must display an error message and do nothing.
- Robot is not placed when the application begins.
- A new valid PLACE command overrides any previous placement.

### Robot Movement

- MOVE command moves the robot one unit forward in current facing direction.
- NORTH increases Y coordinate by 1, SOUTH decreases Y coordinate by 1.
- EAST increases X coordinate by 1, WEST decreases X coordinate by 1.
- Robot position updates only for valid moves that keep robot within bounds.
- Movement that would cause the robot to fall off the table must display an error message and do nothing.
- MOVE commands issued before a robot is placed must display an error message and do nothing.

### Robot Rotation

- LEFT command rotates robot 90 degrees counter-clockwise without changing position.
- RIGHT command rotates robot 90 degrees clockwise without changing position.
- Rotation sequence follows: NORTH → WEST → SOUTH → EAST → NORTH (LEFT) and NORTH → EAST → SOUTH → WEST → NORTH (RIGHT).
- Rotation commands issued before a robot is placed must display an error message and do nothing.

### Reporting

- REPORT command outputs current position and facing direction.
- REPORT commands issued before a robot is placed must display an error message and do nothing.
- Multiple REPORT commands are allowed during execution.

### Command Processing

- First valid command that affects robot state must be PLACE.
- All commands (MOVE, LEFT, RIGHT, REPORT) before the first valid PLACE are rejected with error messages.
- System processes commands sequentially from input until termination.
- Each command is processed completely before next command is read.

### Command Line Interface

- The system is a CLI tool that reads commands from standard input (stdin).
- A welcome message with available commands is displayed on startup.
- Commands are case-sensitive and must match exact format.
- Commands must be on separate lines.
- Leading and trailing whitespace on command lines is trimmed before processing.
- Invalid command formats display an error message and do nothing.

### Available Commands

- PLACE X,Y,F (where X,Y are integers 0-4, F is NORTH/SOUTH/EAST/WEST)
- MOVE (no parameters)
- LEFT (no parameters)
- RIGHT (no parameters)
- REPORT (no parameters)
- EXIT (no parameters)

### Application Lifecycle

- The system must accept and process commands continuously until terminated.
- The system can be terminated with the EXIT command or Ctrl-C.
- Application must start in a clean state each time it is executed.
- On termination, a newline is printed before exiting.

### Output Format

- Successful REPORT output: "Output: X,Y,DIRECTION" (e.g., "Output: 0,1,NORTH")
- Error messages: "Error: [error description]" (e.g., "Error: No robot has been placed on the board")
- All output is written to standard output (stdout).
- No output is produced for successful PLACE, MOVE, LEFT, or RIGHT commands.

## Non-Functional Requirements

### Performance

- Commands must be processed and executed immediately upon entry.
- Output must appear immediately after command processing.
- System must respond to commands without noticeable delay (within milliseconds).

### Reliability and Error Handling

- Invalid commands must not crash the application.
- System must remain responsive and functional after any invalid input.
- Application must continue processing subsequent commands after encountering invalid ones.
- All errors must be handled gracefully with clear error messages.

### State Management

- Robot state must remain consistent across all operations.
- No command should leave robot in an undefined or invalid state.
- System state must be predictable and deterministic for identical command sequences.

### Code Quality

- Implementation should follow functional programming principles with immutable data structures where possible.
- Commands must be encapsulated as objects following the Command pattern.
- Error handling must use Result objects instead of exceptions for control flow.
- Public APIs must be documented.
- Test coverage must demonstrate all required functionality.
- Code must be organized with clear separation of concerns.

### Architecture

- The system must support configurable board dimensions through constructor parameters.
- The architecture must allow easy addition of new commands.
- Domain objects (Robot, Position) must be immutable.

## Out of Scope

- Multiple robots on the same board.
- Robots of different sizes or shapes.
- Robot attributes beyond position and direction.
- Robot movement beyond basic forward movement in the 4 cardinal directions.
- Board sizes other than 5x5 as default (though the system architecture supports different sizes).
- Obstacles, barriers, or other special zones on the board.
- Saving or loading robot state between runs.
- Advanced commands beyond basic movement, rotation, and reporting.
- User interface beyond command-line input/output.
- Graphical user interface or visual representation of the robot or board.
- Command history or undo functionality.
- Batch processing of commands from files.
- Multithreading or asynchronous command processing.
- Network connectivity or remote control.
- Command aliases or shortcuts.
- Macro recording or playback.
- Robot speed or timing controls.
