# Robot Challenge Requirements

## Functional Requirements

### Core Functionality

**FR-1: Robot Placement**

- The system must allow placing a robot on a 5x5 table with PLACE X,Y,F command.
- X and Y coordinates must be integers from 0-4.
- F (facing direction) must be NORTH, SOUTH, EAST, or WEST.
- Origin (0,0) is at the SOUTH WEST corner.
- Invalid placements outside table bounds must be ignored.

**FR-2: Robot Movement**

- MOVE command moves the robot one unit forward in current facing direction.
- Movement that would cause the robot to fall off the table must be ignored.
- Robot position updates only for valid moves.

**FR-3: Robot Rotation**

- LEFT command rotates robot 90 degrees counter-clockwise without changing position.
- RIGHT command rotates robot 90 degrees clockwise without changing position.
- Rotation is always valid regardless of robot position.

**FR-4: Robot Reporting**

- REPORT command outputs current position and facing direction as "X,Y,DIRECTION".
- Output format must be exact: integers for coordinates, cardinal direction name.
- Multiple REPORT commands allowed per session.

**FR-5: Command Processing**

- First valid command must be PLACE.
- All commands before first valid PLACE must be discarded.
- Commands for unplaced robot (MOVE, LEFT, RIGHT, REPORT) must be ignored.
- System accepts commands until termination.

**FR-6: Command Input**

- System reads commands from input stream.
- Commands are case-sensitive.
- Invalid command formats must be ignored.

### Input/Output Requirements

**FR-7: Command Format**

- PLACE X,Y,F (where X,Y are coordinates 0-4, F is NORTH/SOUTH/EAST/WEST)
- MOVE (no parameters)
- LEFT (no parameters)
- RIGHT (no parameters)
- REPORT (no parameters)

**FR-8: Output Format**

- REPORT output: "X,Y,DIRECTION" (e.g., "0,1,NORTH")
- No output for other commands.
- No error messages for invalid commands.

## Non-Functional Requirements

### Performance

**NFR-1: Response Time**

- Commands must be processed and executed within 100ms.
- REPORT output must appear immediately after command processing.

### Reliability

**NFR-2: Error Handling**

- Invalid commands must not crash the application.
- Invalid coordinates or directions must be silently ignored.
- System must remain responsive after invalid input.

**NFR-3: State Consistency**

- Robot state must remain consistent across all operations.
- No command should leave robot in invalid state.

### Usability

**NFR-4: Application Lifecycle**

- Application must not exit after REPORT command.
- Application termination method is implementation-dependent (Ctrl-C, exit command, etc.).
- Application must handle multiple command sessions.

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

## Test Cases

### Basic Functionality

1. PLACE 0,0,NORTH → MOVE → REPORT → Output: "0,1,NORTH"
2. PLACE 0,0,NORTH → LEFT → REPORT → Output: "0,0,WEST"
3. PLACE 1,2,EAST → MOVE → MOVE → LEFT → MOVE → REPORT → Output: "3,3,NORTH"

### Edge Cases

1. Commands before PLACE should be ignored.
2. PLACE outside bounds should be ignored.
3. MOVE at table edge should be ignored.
4. Multiple PLACE commands should work.
5. Multiple REPORT commands should work.

