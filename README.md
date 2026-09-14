# AI Engineering Handbook

How our team works with coding agents (Claude Code, Codex) so we get correct answers, good dialogue, and code we can ship.

Source of the practices: [AI Hero / Matt Pocock's skills](https://www.aihero.dev/skills) ([repo](https://github.com/mattpocock/skills)), adapted for our org.

## The one idea

An agent is only as good as the process you give it. Left to guess, it writes plausible code that quietly rots the codebase. A **skill** encodes one good habit (interrogate a plan, write a spec, review a diff, debug a failure) so the agent runs it the same way every time, for every engineer.

## Read in this order

| Doc | For |
| --- | --- |
| [handbook/00-quickstart.md](handbook/00-quickstart.md) | Install once, set up each repo. 10 minutes. |
| [handbook/03-cheatsheet.md](handbook/03-cheatsheet.md) | The short "how to / when to". Pin this. |
| [handbook/01-flows.md](handbook/01-flows.md) | The idea to ship spine and its on-ramps. |
| [handbook/02-skills-catalog.md](handbook/02-skills-catalog.md) | Every skill: what it does, when to reach for it. |
| [handbook/04-auto-invocation.md](handbook/04-auto-invocation.md) | Making the agent reach for skills without being told. |
| [handbook/05-writing-skills.md](handbook/05-writing-skills.md) | Rules for writing our own skills and AGENTS.md. |
| [handbook/06-rollout.md](handbook/06-rollout.md) | Team adoption: phases, gates, what "working" looks like. |
| [templates/](templates/) | Drop-in `CLAUDE.md` and `.claude/settings.json`. |

## The four failure modes we are fixing

1. **The agent didn't do what I want.** Misalignment. Fix: a grilling session before any code.
2. **The agent is way too verbose.** No shared language. Fix: a `CONTEXT.md` glossary the agent writes with you.
3. **The code doesn't work.** No feedback loop. Fix: red-green-refactor TDD, and a disciplined diagnosis loop.
4. **We built a ball of mud.** Agents accelerate entropy. Fix: design the codebase deliberately, survey it weekly.
