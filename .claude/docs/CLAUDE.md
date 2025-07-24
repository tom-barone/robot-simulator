The following documentation formats and names are given below.

When writing documentation:

- Avoid bold / italics and use simple markdown formatting.

## requirements.md

```markdown
# Requirements Document

Include a very brief description of the system and its purpose.

# Functional Requirements

- Simple list of bullet points describing the functional requirements of the system.
- Each requirement should be clear and concise.

# Non Functional Requirements

- Simple list of bullet points describing the non-functional requirements of the system.
- Each requirement should be clear and concise.

# Out of scope

- Simple list of bullet points describing what is out of scope for the system.
```

## design.md

```markdown
# Design Document

Include a very brief description of the high level system architecture and design.

# Entities

- Simple list of entities that are part of the system.

Do not include any relations or attributes at this point, just the entities themselves.

# Class Diagrams

Include a list of simple class diagrams that represent the entities and their relationships. Use Mermaid syntax for the diagrams. Only include class attributes and public methods.
```

## plan.md

We are doing TDD so break down each step to smallest possible change that can be made in the spirit of Red -> Green -> Refactor.

Keep each step of the plan small, focused and concise.

Do not use excessive headings or formatting, follow the format given below:

```markdown
# Implementation Plan

Brief overview of the implementation plan.

## Test Driven Development

1. Description of the first piece of work to implement.
   - Red: Instructions to write the first set of failing tests.
   - Green: Instructions to implement the code to make the tests pass.
   - Refactor: Instructions to refactor the code.
2. Description of the second piece of work to implement.
   - Red: Instructions to write the second set of failing tests.
   - Green: Instructions to implement the code to make the tests pass.
   - Refactor: Instructions to refactor the code.

...
```
