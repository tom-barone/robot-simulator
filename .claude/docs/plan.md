# TDD Implementation Plan

This plan implements the robot simulator using Test-Driven Development, broken into small Red-Green-Refactor cycles. Each step builds incrementally on the previous ones.

## Phase 1: Value Objects

### Step 1: Position Creation

- **Red**: Test Position can be created with x,y coordinates
- **Green**: Implement Position class with constructor and attr_readers
- **Refactor**: Assess if any improvements needed

### Step 4: Position Movement - All Directions

- **Red**: Test Position can move north (y+1)
- **Green**: Implement move method for NORTH direction
- **Refactor**: Assess if any improvements needed
- **Red**: Test Position can move south (y-1)
- **Green**: Extend move method for SOUTH
- **Refactor**: Assess if any improvements needed
- **Red**: Test Position can move east (x+1)
- **Green**: Extend move method for EAST
- **Refactor**: Assess if any improvements needed
- **Red**: Test Position can move west (x-1)
- **Green**: Extend move method for WEST
- **Refactor**: Assess if any improvements needed

## Phase 2: Direction Value Object

## Phase 3: Board

### Step 10: Board Creation

- **Red**: Test Board can be created with width and height
- **Green**: Implement Board class with constructor
- **Refactor**: Assess if any improvements needed

### Step 11: Board Position Validation

- **Red**: Test position (0,0) is valid on 5x5 board
- **Green**: Implement valid? method returning true for (0,0)
- **Refactor**: Assess if any improvements needed
- **Red**: Test position (4,4) is valid on 5x5 board
- **Green**: Extend valid? method for all valid positions
- **Refactor**: Assess if any improvements needed
- **Red**: Test position (-1,0) is invalid
- **Green**: Extend valid? method to check lower bounds
- **Refactor**: Assess if any improvements needed
- **Red**: Test position (5,0) is invalid
- **Green**: Extend valid? method to check upper bounds
- **Refactor**: Assess if any improvements needed

## Phase 4: Robot

### Step 12: Robot Creation

- **Red**: Test Robot can be created with position and direction
- **Green**: Implement Robot class with constructor accepting position and direction
- **Refactor**: Assess if any improvements needed

### Step 14: Robot Movement

- **Red**: Test Robot can move forward in its facing direction
- **Green**: Implement move method using position.move(direction)
- **Refactor**: Assess if any improvements needed

### Step 15: Robot Rotation

- **Red**: Test Robot can turn left
- **Green**: Implement turn_left method using direction.turn_left
- **Refactor**: Assess if any improvements needed
- **Red**: Test Robot can turn right
- **Green**: Implement turn_right method using direction.turn_right
- **Refactor**: Assess if any improvements needed

### Step 16: Robot Reporting

- **Red**: Test Robot can report position as "X,Y,DIRECTION"
- **Green**: Implement report method returning formatted string
- **Refactor**: Assess if any improvements needed

## Phase 5: Commands

### Step 17: Command Base

- **Red**: Test Command responds to execute method
- **Green**: Implement abstract Command class with execute method
- **Refactor**: Assess if any improvements needed

### Step 18: PlaceCommand

- **Red**: Test PlaceCommand can be created with position and direction
- **Green**: Implement PlaceCommand class inheriting from Command
- **Refactor**: Assess if any improvements needed
- **Red**: Test PlaceCommand executes robot placement
- **Green**: Implement execute method calling controller
- **Refactor**: Assess if any improvements needed

### Step 19: MoveCommand

- **Red**: Test MoveCommand executes robot movement
- **Green**: Implement MoveCommand class and execute method
- **Refactor**: Assess if any improvements needed

### Step 20: LeftCommand

- **Red**: Test LeftCommand executes robot left turn
- **Green**: Implement LeftCommand class and execute method
- **Refactor**: Assess if any improvements needed

### Step 21: RightCommand

- **Red**: Test RightCommand executes robot right turn
- **Green**: Implement RightCommand class and execute method
- **Refactor**: Assess if any improvements needed

### Step 22: ReportCommand

- **Red**: Test ReportCommand executes robot reporting
- **Green**: Implement ReportCommand class and execute method
- **Refactor**: Assess if any improvements needed

## Phase 6: Command Parsing

### Step 23: CommandParser Basic

- **Red**: Test CommandParser can be created
- **Green**: Implement CommandParser class
- **Refactor**: Assess if any improvements needed

### Step 24: Parse PLACE Command

- **Red**: Test parser creates PlaceCommand from "PLACE 0,0,NORTH"
- **Green**: Implement parse method for PLACE command
- **Refactor**: Assess if any improvements needed

### Step 25: Parse Movement Commands

- **Red**: Test parser creates MoveCommand from "MOVE"
- **Green**: Extend parse method for MOVE
- **Refactor**: Assess if any improvements needed
- **Red**: Test parser creates LeftCommand from "LEFT"
- **Green**: Extend parse method for LEFT
- **Refactor**: Assess if any improvements needed
- **Red**: Test parser creates RightCommand from "RIGHT"
- **Green**: Extend parse method for RIGHT
- **Refactor**: Assess if any improvements needed
- **Red**: Test parser creates ReportCommand from "REPORT"
- **Green**: Extend parse method for REPORT
- **Refactor**: Assess if any improvements needed

### Step 26: Parser Error Handling

- **Red**: Test parser handles invalid commands gracefully
- **Green**: Add error handling returning nil for invalid input
- **Refactor**: Assess if any improvements needed

## Phase 7: Robot Controller

### Step 27: RobotController Creation

- **Red**: Test RobotController can be created with board
- **Green**: Implement RobotController class with constructor
- **Refactor**: Assess if any improvements needed

### Step 28: Controller Robot Placement

- **Red**: Test controller can place robot at valid position
- **Green**: Implement place_robot method creating new robot if position valid
- **Refactor**: Assess if any improvements needed
- **Red**: Test controller ignores placement at invalid position
- **Green**: Add board validation to place_robot method
- **Refactor**: Assess if any improvements needed

### Step 29: Controller Robot Operations

- **Red**: Test controller can move placed robot
- **Green**: Implement move_robot method checking robot exists and move valid
- **Refactor**: Assess if any improvements needed
- **Red**: Test controller ignores move when no robot placed
- **Green**: Add robot existence check to move_robot method
- **Refactor**: Assess if any improvements needed
- **Red**: Test controller can turn placed robot left
- **Green**: Implement turn_robot_left method checking robot exists
- **Refactor**: Assess if any improvements needed
- **Red**: Test controller ignores left turn when no robot placed
- **Green**: Add robot existence check to turn_robot_left method
- **Refactor**: Assess if any improvements needed
- **Red**: Test controller can turn placed robot right
- **Green**: Implement turn_robot_right method checking robot exists
- **Refactor**: Assess if any improvements needed
- **Red**: Test controller ignores right turn when no robot placed
- **Green**: Add robot existence check to turn_robot_right method
- **Refactor**: Assess if any improvements needed
- **Red**: Test controller can report placed robot state
- **Green**: Implement report_robot method checking robot exists
- **Refactor**: Assess if any improvements needed
- **Red**: Test controller ignores report when no robot placed
- **Green**: Add robot existence check to report_robot method
- **Refactor**: Assess if any improvements needed

## Phase 8: CLI Interface

### Step 30: CLI Creation

- **Red**: Test CLI can be created with controller and parser
- **Green**: Implement CLI class with constructor
- **Refactor**: Assess if any improvements needed

### Step 31: CLI Command Processing

- **Red**: Test CLI can process single command
- **Green**: Implement process_command method
- **Refactor**: Assess if any improvements needed

### Step 32: CLI Input Loop

- **Red**: Test CLI can run command processing loop
- **Green**: Implement run method with input loop
- **Refactor**: Assess if any improvements needed

## Phase 9: Application Entry Point

### Step 33: Application Creation

- **Red**: Test Application can be created
- **Green**: Implement Application class
- **Refactor**: Assess if any improvements needed

### Step 34: Application Dependency Wiring

- **Red**: Test Application wires up all dependencies and runs CLI
- **Green**: Implement run method creating and connecting all objects
- **Refactor**: Assess if any improvements needed

## Phase 10: Integration Testing

### Step 35: End-to-End Behavior

- **Red**: Test complete command sequence from requirements
- **Green**: Verify all components work together
- **Refactor**: Final cleanup and optimization

Each step follows strict TDD: write failing test first, implement minimal code to pass, then assess refactoring opportunities before moving to next step.

