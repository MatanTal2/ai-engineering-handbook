# Cheat sheet: how to, when to

One page. Pin it.

## The loop

```
idea -> /grill-with-docs -> /to-spec -> /to-tickets -> /implement -> /code-review -> ship
          (skip spec+tickets if the whole change fits one context window)
```

## When to reach for what

| Situation | Command | Why |
| --- | --- | --- |
| New idea, fuzzy | `/grill-with-docs` (repo) / `/grill-me` (no repo) | Misalignment is the #1 failure. Get interrogated first. |
| Question talk cannot settle | `/prototype` | Build the throwaway version, look at it, answer in one line. |
| Need an external fact | `/research` | Background agent, cited file, no stalled thread. |
| Decision lives in someone else's head | `/to-questionnaire` | Take it offline, bring answers back. |
| Plan settled, work spans sessions | `/to-spec` then `/to-tickets` | Survives context loss, splits across agents. |
| Plan settled, small | `/implement` | Skip the paperwork. |
| A ticket to build | `/implement #42` | One ticket per session, clear context between. |
| One behaviour, test-first | `/tdd` | Red-green-refactor, one slice at a time. |
| Diff to check | `/code-review <ref>` | Standards axis and spec axis, in parallel. |
| Something broken | `/diagnosing-bugs` | Red loop, minimise, hypothesise, fix, regression-test. |
| Merge conflict in the tree | `/resolving-merge-conflicts` | Resolve by intent, never `--abort`. |
| Other people's bugs and PRs | `/triage` | State machine to agent-ready briefs. |
| Effort bigger than one session, route foggy | `/wayfinder` | Map of decision tickets, resolved one at a time. |
| Codebase feels muddy | `/improve-codebase-architecture` | Survey for deepening opportunities. Every few days. |
| Terms mean different things to different people | `/domain-modeling` | Canonical term into `CONTEXT.md`, alternatives under Avoid. |
| Human-only steps (dashboards, secrets) | `/wizard` | Executable walkthrough instead of a rotting README. |
| Agent lost you | `/wait-what` | It re-pitches in plain English. |
| Handing work to another session, repo or person | `/handoff` | Same harness and directory? Use `/compact` instead. |
| No idea what applies | `/ask-matt` | Router. |

## Rules of engagement

1. **Never start coding from a one-line prompt.** Grill first. Every time.
2. **Plan mode off while grilling.** It rushes the agent to a plan.
3. **Fresh conversation per phase.** Grill in one, implement in another, driven by the written artifact.
4. **One ticket per session.** Clear context between tickets.
5. **Answer "I don't know" out loud.** That answer is what a prototype, research task or questionnaire is for.
6. **Vertical slices only.** Thin cuts through every layer, not layer-by-layer.
7. **`CONTEXT.md` is the shared language.** If the agent is verbose, the glossary is missing, not the model.
8. **Do not run `/init`.** See [04-auto-invocation.md](04-auto-invocation.md).
9. **Read the diff.** Every line the agent wrote is yours at review time.
10. **The codebase is the agent's context.** A garbage codebase produces garbage output, no matter the prompt.

## Smells that mean you picked the wrong skill

| Smell | Actually needed |
| --- | --- |
| Grilling session keeps ballooning on one question | `/prototype` |
| Grilling ends, `CONTEXT.md` untouched | `/domain-modeling` by name |
| Agent hunts for a spec file that does not exist | Say "the plan is in this thread" when invoking `/implement` |
| `/triage` on tickets we wrote ourselves | Nothing. They are already agent-ready. |
| TDD producing tests that restate the implementation | There was no independent source of truth. Skip the loop for that change. |
| `/code-review` guessing the base | Give it the fixed point: commit, branch, tag, or merge-base. |
