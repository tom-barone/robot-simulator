# Robot Simulator

Note: I've been experimenting with Claude Code and have taken the liberty of using this challenge to showcase how I've been using it. Apologies if this is against the rules!

## Run with Docker

```bash
docker build --tag robot-simulator .
docker run --rm -it robot-simulator
```

## Features

- Source code in `lib/`.
- RBS type signatures in `rbs/`.
- Tests in `test/`.
  - 100% coverage (doesn't really need to be that high in practice).
- [CI Github Action](https://github.com/tom-barone/robot-simulator/actions) that runs on each push to `main`.
  - Runs the RuboCop formatter, fails the build if any formatting differences are found.
    - Again, failing the build on formatting differences can be a bit extreme in practice.
  - Runs the RuboCop linter.
  - Runs the Steep/RBS type checker.
  - Runs the test suite with Minitest.
  - Generates a code coverage report with SimpleCov (downloadable from the CI artifacts).
  - Generates documentation with rdoc. (downloadable from the CI artifacts).
  - Deploys the rdoc docs [here](https://robot-simulator.tombarone.net/).
    - Hidden behind [`oauth2-proxy`](https://oauth2-proxy.github.io/oauth2-proxy/) for authentication, with only select GitHub users allowed access.

See the `Rakefile` for a full list of available tasks.

## Architecture

The structure is pretty standard OOP. The only interesting design choice is the Command Pattern to encapsulate each robot instruction as an object, and use of a Controller as an interface for the commands to operate on.

We have immutability where it makes sense, for example when calling `Robot.move()` we'll return a new instance of `Robot` with the updated position rather than modifying the existing object. Nothing particularly wrong with mutability but all the cool kids are doing functional / immutable programming these days.

I renamed `Table` to `Board` because `Table` is an overloaded term and easily confused with data tables etc.

## Docs Deployment

This is definitely overkill.

We want the docs to be private, so we use `oauth2-proxy` to authenticate users with GitHub first. We can select which GitHub users by username to allow access to the site. I'm hosting this on a dev mini PC I have running out of my house that is handy for prototyping and testing stuff like this.

The proxy and website are setup using [Dokku](https://dokku.com/):

```bash
ssh -t tbone@au-adelaide.tombarone.net dokku apps:create robot-simulator.tombarone.net
git remote add dokku dokku@au-adelaide.tombarone.net:robot-simulator.tombarone.net
dokku domains:set robot-simulator.tombarone.net
cat .env | xargs dokku config:set
dokku config:set BUILDPACK_URL=https://github.com/heroku/heroku-buildpack-ruby.git
dokku config:set HOSTNAME=0.0.0.0
dokku config:set OAUTH2_PROXY_REDIRECT_URL=https://robot-simulator.tombarone.net/oauth2/callback
dokku letsencrypt:enable
git push dokku main
```

## Claude Code - My own experience

From what I've seen, no one has perfectly mastered these coding agents yet. I find it pretty exciting with everyone trying different things to see what works best. By no means is my setup the best, it's a constant work in progress.

These agents behave well when given a constrained environment to work in:

- Non-negotiable Test Driven Development (TDD).
- Hardcore linting with all Rubocop cops turned on.
- Type checking with Steep / RBS.
- Making agents run tests after every change they make.
- Breaking up each task into small steps first.

I was inspired a lot by this guy's [CLAUDE.md](https://github.com/citypaul/.dotfiles/blob/main/claude/.claude/CLAUDE.md).

While using Claude Code, we end up reading much more code than usual. I find Ruby to be especially well suited to this compared to other languages, since it's easy to visually parse and read quickly.

We maintain a set of 3 constantly evolving documents:

1. Requirements - `.claude/docs/requirements.md`
2. Design - `.claude/docs/design.md`
3. Plan - `.claude/docs/plan.md`

Each change flows through these documents in order. Supposing we have a complete system, when it comes time to implement a new feature or change, we:

1. Review and update the requirements document with the new change.
2. Review and update the design document to align with the new requirements.
3. Write a new plan to implement the change.
4. Implement the change using TDD.

I try not to be too demanding about how these docs are written, since they're not really for human consumption. So long as these docs are 80% accurate to what is needed, thats good enough to get started. It's easy to fall into the trap of trying to tune that last 20% which takes ages and ends up being unnecessary. The finer details will flesh themselves out as we implement the code step by step.
