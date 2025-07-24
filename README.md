# Robot Simulator

Spoiler alert: I've been experimenting with Claude Code and this little challenge happens to be a great way of showcasing how I've been using it. Apologies if this is against the rules!

From what I can tell no one has perfectly mastered these coding agents, which is pretty exciting with everyone trying different things to see what works best. By no means is my setup the best, it's still a work in progress.

## Getting Started

## Claude Code - My own experience

These agents seem to work best when given a very constrained environment to work in:

- Non-negotiable Test Driven Development (TDD).
- Hardcore linting with all Rubocop cops turned on.
- Type checking with Steep / RBS.
- Making agents run tests after every change they make.
- Breaking up each task into small steps first.

I was inspired a lot by this guy's [CLAUDE.md](https://github.com/citypaul/.dotfiles/blob/main/claude/.claude/CLAUDE.md).

Naturally when using these agents, one tends to read and review way more code than usual. Ruby is especially fantastic for this with it being one of the better languages to visually parse and read quickly.

We maintain a set of 3 constantly evolving documents:

1. Requirements - `.claude/docs/requirements.md`
2. Design - `.claude/docs/design.md`
3. Plan - `.claude/docs/plan.md`

Each change flows through these documents in order. Supposing we have a complete system, when it comes time to implement a new feature or change, we:

1. Review and update the requirements document with the new change.
2. Review and update the design document to align with the new requirements.
3. Write a new plan to implement the change.
4. Implement the change using TDD.

