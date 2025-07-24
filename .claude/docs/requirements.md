# Robot Challenge Requirements

## Functional Requirements

### Core Functionality

**FR-1: Robot Placement**

- The system must allow placing a robot on a 5x5 table with PLACE X,Y,F command.
- X and Y coordinates must be integers from 0-4 (inclusive).
- F (facing direction) must be exactly NORTH, SOUTH, EAST, or WEST.
- Origin (0,0) is at the SOUTH WEST corner of the table.
- Invalid placements outside table bounds must be ignored and robot remains in previous state.
- Robot starts in an unplaced state when application begins.

**FR-2: Robot Movement**

- MOVE command moves the robot one unit forward in current facing direction.
- NORTH increases Y coordinate by 1, SOUTH decreases Y coordinate by 1.
- EAST increases X coordinate by 1, WEST decreases X coordinate by 1.
- Movement that would cause the robot to fall off the table must be ignored.
- Robot position updates only for valid moves that keep robot within bounds.

**FR-3: Robot Rotation**

- LEFT command rotates robot 90 degrees counter-clockwise without changing position.
- RIGHT command rotates robot 90 degrees clockwise without changing position.
- Rotation is always valid when robot is placed, regardless of robot position.
- Rotation commands are ignored if robot is not placed.

**FR-4: Robot Reporting**

- REPORT command outputs current position and facing direction as "X,Y,DIRECTION".
- Output format must be exact: integers for coordinates, cardinal direction name.
- REPORT commands are ignored if robot is not placed.
- Multiple REPORT commands allowed during execution.

**FR-5: Command Processing**

- First valid command that affects robot state must be PLACE.
- All commands before first valid PLACE must be discarded silently.
- Commands for unplaced robot (MOVE, LEFT, RIGHT, REPORT) must be ignored silently.
- System processes commands sequentially from input until termination.
- Each command is processed completely before next command is read.

**FR-6: Command Input**

- System reads commands from standard input (stdin).
- Commands are case-sensitive and must match exact format.
- Commands must be on separate lines.
- Leading and trailing whitespace on command lines must be ignored.
- Invalid command formats must be ignored silently.

### Input/Output Requirements

**FR-7: Command Format**

- PLACE X,Y,F (where X,Y are integers 0-4, F is NORTH/SOUTH/EAST/WEST, no spaces around commas)
- MOVE (no parameters, command name only)
- LEFT (no parameters, command name only)
- RIGHT (no parameters, command name only)
- REPORT (no parameters, command name only)
- Commands must be entered exactly as specified above.

**FR-8: Output Format**

- REPORT output: "X,Y,DIRECTION" with no spaces (e.g., "0,1,NORTH")
- No output for commands other than REPORT.
- No error messages or acknowledgments for any commands.
- Output must be written to standard output (stdout).

## Non-Functional Requirements

### Performance

**NFR-1: Response Time**

- Commands must be processed and executed immediately.
- REPORT output must appear immediately after command processing.
- System must handle commands interactively without noticeable delay.

### Reliability

**NFR-2: Error Handling**

- Invalid commands must not crash the application.
- Invalid coordinates, directions, or command formats must be silently ignored.
- System must remain responsive and functional after any invalid input.
- Application must continue processing subsequent commands after encountering invalid ones.

**NFR-3: State Consistency**

- Robot state must remain consistent across all operations.
- No command should leave robot in an undefined or invalid state.
- System state must be predictable and deterministic for identical command sequences.

### Usability

**NFR-4: Application Lifecycle**

- Application must continue running after REPORT command execution.
- Application must accept and process commands continuously until terminated.
- Application termination method is implementation-dependent (EOF, Ctrl-C, exit command, etc.).
- Application must start in a clean state each time it is executed.

### Maintainability

**NFR-5: Code Quality**

- Code must follow established Ruby conventions and style guides.
- Classes and methods must have single responsibilities.
- Code must be testable with unit tests covering all behaviors.

**NFR-6: Documentation**

- Public APIs must be documented.
- Test cases must demonstrate all required functionality.

## Constraints

### Technical Constraints

**TC-1: Table Dimensions**

- Table is fixed at 5x5 units (coordinates 0-4 for both X and Y).
- No obstacles on table surface.

**TC-2: Robot Limitations**

- Only one robot exists in the system.
- Robot occupies single unit of space.
- Robot cannot exist outside table boundaries.

**TC-3: Direction System**

- Four cardinal directions only: NORTH, SOUTH, EAST, WEST.
- NORTH increases Y coordinate, SOUTH decreases Y coordinate.
- EAST increases X coordinate, WEST decreases X coordinate.

### Business Rules

**BR-1: Safety**

- Robot must never fall off table.
- Commands causing robot to fall must be ignored, not cause errors.

**BR-2: Command Sequence**

- PLACE command required before any movement or reporting.
- Subsequent PLACE commands allowed and override previous placement.

## Out-of-Scope Requirements

**OS-1: Multiple Robots**
- System does not support multiple robots on the same table.

**OS-2: Table Modifications**
- Table dimensions cannot be changed from 5x5.
- No obstacles, barriers, or special zones on the table.

**OS-3: Robot Attributes**
- Robot has no size, weight, or physical properties beyond position and direction.
- No collision detection or robot-to-robot interactions.

**OS-4: Persistence**
- No saving or loading of robot state between application runs.
- No command history or undo functionality.

**OS-5: Advanced Commands**
- No commands beyond PLACE, MOVE, LEFT, RIGHT, and REPORT.
- No conditional or batch command processing.

**OS-6: User Interface**
- No graphical user interface or visual representation of the table.
- No command validation feedback or help system.

## Test Cases

### Basic Functionality

**TC-1: Basic Movement**
- Input: PLACE 0,0,NORTH → MOVE → REPORT
- Expected: "0,1,NORTH"

**TC-2: Basic Rotation**
- Input: PLACE 0,0,NORTH → LEFT → REPORT
- Expected: "0,0,WEST"

**TC-3: Combined Movement and Rotation**
- Input: PLACE 1,2,EAST → MOVE → MOVE → LEFT → MOVE → REPORT
- Expected: "3,3,NORTH"

### Edge Cases

**TC-4: Commands Before PLACE Ignored**
- Input: MOVE → LEFT → RIGHT → REPORT → PLACE 1,1,NORTH → REPORT
- Expected: "1,1,NORTH" (only output after PLACE)

**TC-5: Invalid PLACE Ignored**
- Input: PLACE 5,5,NORTH → PLACE 1,1,SOUTH → REPORT
- Expected: "1,1,SOUTH"

**TC-6: Movement at Table Boundaries**
- Input: PLACE 0,0,SOUTH → MOVE → REPORT
- Expected: "0,0,SOUTH" (MOVE ignored, position unchanged)

**TC-7: Movement at All Boundaries**
- Input: PLACE 4,4,NORTH → MOVE → REPORT → PLACE 4,4,EAST → MOVE → REPORT
- Expected: "4,4,NORTH" then "4,4,EAST"

**TC-8: Multiple PLACE Commands**
- Input: PLACE 0,0,NORTH → PLACE 2,2,SOUTH → REPORT
- Expected: "2,2,SOUTH"

**TC-9: Multiple REPORT Commands**
- Input: PLACE 1,1,WEST → REPORT → REPORT
- Expected: "1,1,WEST" then "1,1,WEST"

**TC-10: Full Rotation Cycle**
- Input: PLACE 2,2,NORTH → RIGHT → RIGHT → RIGHT → RIGHT → REPORT
- Expected: "2,2,NORTH"

**TC-11: Invalid Commands Ignored**
- Input: PLACE 1,1,NORTH → INVALID → MOVE → REPORT
- Expected: "1,2,NORTH"

**TC-12: All Coordinate Boundary Combinations**
- Test placing robot at (0,0), (0,4), (4,0), (4,4) and verify all positions are valid.

