# Implementation Plan for PUT_OBSTACLE Feature

This document outlines the TDD implementation plan for adding obstacle functionality to the robot simulator.

## Overview

The PUT_OBSTACLE command allows placing obstacles on the board that block robot movement and placement. Obstacles can be placed before a robot is placed. The implementation follows TDD principles with small, incremental changes.

## Current Implementation State

The robot simulator is fully functional with all basic commands (PLACE, MOVE, LEFT, RIGHT, REPORT, EXIT) implemented. The system uses:
- Immutable domain objects (Robot, Position, Board)
- Command pattern with Result-based error handling
- Controller for state management
- CLI for user interaction

## Implementation Steps

### Step 1: Add New Error Classes

1. Write test for ObstacleInTheWayError class existence
2. Implement ObstacleInTheWayError in errors.rb
3. Write test for ObstacleInTheWayError message
4. Implement message method returning "Obstacle in the way"
5. Write test for RobotInTheWayError class existence
6. Implement RobotInTheWayError in errors.rb
7. Write test for RobotInTheWayError message
8. Implement message method returning "Robot in the way"

### Step 2: Update Board to Support Obstacles

1. Write test for Board#has_obstacle? with no obstacles
2. Add obstacles attribute and has_obstacle? method returning false
3. Write test for Board#add_obstacle returns new Board instance
4. Implement add_obstacle method returning new Board with updated obstacles
5. Write test for Board#has_obstacle? returns true after adding obstacle
6. Update has_obstacle? to check obstacles set
7. Write test for Board immutability when adding obstacles
8. Ensure add_obstacle creates new Board instance with copied obstacles

### Step 3: Update Controller for Board State Management

1. Write test for Controller#update_board method
2. Implement update_board method to update board reference

### Step 4: Create PutObstacle Command

1. Write test for Command::PutObstacle initialization with position
2. Create Command::PutObstacle class with position attribute
3. Write test for successful obstacle placement on empty board
4. Implement execute method to add obstacle and update board
5. Write test for obstacle placement outside board bounds
6. Update execute to return error for invalid positions
7. Write test for obstacle placement on existing obstacle
8. Update execute to check for existing obstacles
9. Write test for obstacle placement on robot position
10. Update execute to check if robot exists at position

### Step 5: Update Command Parser for PUT_OBSTACLE

1. Write test for parsing "PUT_OBSTACLE 0,0"
2. Update StringParser#create_command to handle PUT_OBSTACLE
3. Write test for parsing PUT_OBSTACLE without arguments
4. Add validation for missing arguments
5. Write test for parsing PUT_OBSTACLE with invalid format
6. Add format validation for X,Y pattern
7. Write test for parsing PUT_OBSTACLE with non-integer coordinates
8. Add integer validation for coordinates

### Step 6: Update Move Command to Check Obstacles

1. Write test for robot move blocked by obstacle
2. Update Command::Move#execute to check target position for obstacles
3. Write test for moves in all directions blocked by obstacles
4. Verify implementation works for NORTH, SOUTH, EAST, WEST

### Step 7: Update Place Command to Check Obstacles

1. Write test for robot placement blocked by obstacle
2. Update Command::Place#execute to check position for obstacles

### Step 8: Update CLI Help Text

1. Write test for CLI intro includes PUT_OBSTACLE
2. Update CLI::INTRO constant to include PUT_OBSTACLE command

### Step 9: Integration Tests

1. Write test for complete obstacle workflow (place obstacle, try to move robot into it)
2. Write test for multiple obstacles blocking robot movement
3. Write test for placing obstacles before robot is placed
4. Write test for re-placing robot after obstacles are set

## Implementation Order Rationale

1. **Error classes first**: Needed by commands to return appropriate errors
2. **Board changes second**: Core domain logic for obstacle tracking
3. **Controller update third**: Enables board state management
4. **PutObstacle command fourth**: Can now be fully implemented
5. **Parser update fifth**: Enables user input of PUT_OBSTACLE
6. **Update existing commands**: Integrate obstacle checking
7. **CLI and integration**: Final user-facing changes and verification

## Testing Strategy

- Write one test at a time following red-green-refactor
- Each test has exactly one assertion
- Use descriptive test names explaining the behavior
- Test error paths as thoroughly as success paths
- Maintain existing test coverage while adding new features

## Refactoring Checkpoints

After each green test, evaluate:
- Can obstacle validation be extracted to a shared method?
- Are error messages consistent across commands?
- Is the Board API intuitive for obstacle management?
- Can command execution patterns be unified?
