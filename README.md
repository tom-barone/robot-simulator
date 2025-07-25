# Robot Simulator

Spoiler alert: I've been experimenting with Claude Code and this little challenge happens to be a great way of showcasing how I've been using it. Apologies if this is against the rules!

## Run with Docker

```bash
docker build --tag robot-simulator .
docker run --rm -it robot-simulator
```

## Architecture

The structure is pretty standard OOP. The only interesting design choice is the Command Pattern to encapsulate each robot instruction as an object, and use of a RobotController to act as the receiver for the commands.

I've gone for immutability where possible, for example when calling `Robot.move()` we'll return a new instance of `Robot` with the updated position, rather than modifying the existing object. Nothing particularly wrong with mutability but all the cool kids are doing functional / immutable programming these days.

I renamed `Table` to `Board` because `Table` can be easily confused with data tables etc.

## Claude Code - My own experience

From what I've seen, no one has perfectly mastered these coding agents yet. I find it pretty exciting with everyone trying different things to see what works best. By no means is my setup the best, it's a constant work in progress.

These agents behave well when given a constrained environment to work in:

- Non-negotiable Test Driven Development (TDD).
- Hardcore linting with all Rubocop cops turned on.
- Type checking with Steep / RBS.
- Making agents run tests after every change they make.
- Breaking up each task into small steps first.

I was inspired a lot by this guy's [CLAUDE.md](https://github.com/citypaul/.dotfiles/blob/main/claude/.claude/CLAUDE.md).

A result of these new tools is we reading much more code than usual. I find Ruby to be especially well suited to this compared to other languages, since it's easy to visually parse and read quickly.

We maintain a set of 3 constantly evolving documents:

1. Requirements - `.claude/docs/requirements.md`
2. Design - `.claude/docs/design.md`
3. Plan - `.claude/docs/plan.md`

Each change flows through these documents in order. Supposing we have a complete system, when it comes time to implement a new feature or change, we:

1. Review and update the requirements document with the new change.
2. Review and update the design document to align with the new requirements.
3. Write a new plan to implement the change.
4. Implement the change using TDD.

I try not to be too demanding about how these docs are written, since they're not really for human consumption.

Another thing I've found is that so long as the design / plan docs are 80% accurate to what we want, thats good enough to get started. I've fallen into the trap of trying to tune that last 20% which takes ages and ends up being unnecessary. The finer details will flesh themselves out as we implement the code step by step.
