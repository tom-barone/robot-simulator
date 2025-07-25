# Robot Challenge Requirements

## Functional Requirements

- The system must allow placing a robot on a 5x5 table with PLACE X,Y,F command.
- X and Y coordinates should be integers from 0-4 (inclusive).
- F (facing direction) must be exactly NORTH, SOUTH, EAST, or WEST.
- Origin (0,0) is at the SOUTH WEST corner of the table.
- Invalid placements outside table bounds should warn the user and will be ignored.
- Robot is not placed when the application begins.
- A new PLACE command overrides any previous placement.

- MOVE command moves the robot one unit forward in current facing direction.
- NORTH increases Y coordinate by 1, SOUTH decreases Y coordinate by 1.
- EAST increases X coordinate by 1, WEST decreases X coordinate by 1.
- Robot position updates only for valid moves that keep robot within bounds.
- Movement that would cause the robot to fall off the table should warn the user and will be ignored.

- LEFT command rotates robot 90 degrees counter-clockwise without changing position.
- RIGHT command rotates robot 90 degrees clockwise without changing position.
- Rotation is always valid when robot is placed, regardless of robot position.
- If a robot is not placed, rotation commands should warn the user and will be ignored.

- REPORT command outputs current position and facing direction as "X,Y,DIRECTION".
- Output format must be exact: integers for coordinates, cardinal direction name.
- If a robot is not placed, report commands should warn the user and will be ignored.
- Multiple REPORT commands are allowed during execution.

- First valid command that affects robot state must be PLACE.
- System processes commands sequentially from input until termination.
- Each command is processed completely before next command is read.

- The system is a CLI tool and reads commands from standard input (stdin).
- Commands are case-sensitive and must match exact format.
- Commands must be on separate lines.
- Leading and trailing whitespace on command lines should be trimmed before processing.
- Invalid command formats should warn the user and will be ignored.

- PLACE X,Y,F (where X,Y are integers 0-4, F is NORTH/SOUTH/EAST/WEST)
- MOVE (no parameters, command name only)
- LEFT (no parameters, command name only)
- RIGHT (no parameters, command name only)
- REPORT (no parameters, command name only)
- Commands must be entered as specified above, with leniency for whitespace.

- The system must accept and process commands continuously until terminated.
- The system must be terminated cleanly with Ctrl-C.
- Application must start in a clean state each time it is executed.

- REPORT output: "X,Y,DIRECTION" with no spaces (e.g., "0,1,NORTH")
- No output for commands other than REPORT.
- No error messages or acknowledgments for any commands.
- Output must be written to standard output (stdout).

## Non-Functional Requirements

- Commands should be processed and executed immediately.
- No multithreading or asynchronous processing is required.
- REPORT output must appear immediately after command processing.
- System should be performant and respond to commands without delay longer than a few milliseconds.

- Invalid commands must not crash the application.
- System must remain responsive and functional after any invalid input.
- Application must continue processing subsequent commands after encountering invalid ones.

- Robot state must remain consistent across all operations.
- No command should leave robot in an undefined or invalid state.
- System state must be predictable and deterministic for identical command sequences.

- Public APIs must be documented.
- Test cases must demonstrate all required functionality.

## Out of scope

- Multiple robots on the same board.
- Robots of different sizes or shapes.
- Robot attributes beyond position and direction.
- Robot movement beyond basic forward movement in the 4 cardinal directions.
- Board size other than 5x5.
- Obstacles or barriers or other special zones on the board.
- Saving or loading robot state between runs.
- Advanced commands beyond basic movement and rotation.
- User interface beyond command-line input/output.
- Graphical user interface or visual representation of the robot or board.
- Command history / undo functionality.
- Batch processing of commands.
