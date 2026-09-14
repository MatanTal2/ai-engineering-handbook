# Making the agent use skills automatically

Goal: engineers should not have to remember the catalog. The agent should reach for the right discipline on its own, and the harness should make the wrong move impossible.

Four layers, weakest to strongest.

## Layer 1: invocation class (what lets it fire at all)

A skill is one of two things, set in its `SKILL.md` frontmatter:

```yaml
---
name: tdd
description: Test-driven development. Use when the user wants to build features or fix bugs test-first, mentions "red-green-refactor", or wants integration tests.
---
```

Model-invoked: no `disable-model-invocation` key. The agent can reach for it. The description is **model-facing** and keeps rich trigger phrasing ("Use when the user wants..., mentions..., asks for...").

```yaml
---
name: to-spec
description: Turn the current conversation into a spec and publish it to the project issue tracker.
disable-model-invocation: true
---
```

User-invoked: only a human typing the name can fire it, and no other skill can call it. The description is **human-facing**: a one-line summary for someone browsing slash commands, with trigger lists stripped.

**The test for which one:** could the agent usefully reach for this autonomously? Orchestration (it decides the shape of the whole session) stays user-invoked. Discipline applied inside a task goes model-invoked. Reuse is a reason to extract a skill, not a reason to make it model-invoked.

Codex equivalent lives in `agents/openai.yaml` beside the `SKILL.md`: `policy.allow_implicit_invocation: false`. A skill is user-invoked in both harnesses or neither.

## Layer 2: the description is the trigger (what makes it fire reliably)

A skill's description is a **context pointer**: a line always in the agent's context that names out-of-context material and encodes the condition for reaching it. The pointer's wording, not its target, decides when the agent reaches the material and how reliably. A must-have skill behind a weakly worded description is a variance bug.

Rules for writing one:

- **Front-load the leading word.** The first word does the triggering work.
- **One trigger per branch.** Synonyms renaming a single branch are one branch written twice.
- **Cut identity the body already carries.**
- **Name the concrete phrases people actually type.** `Use when the user says "diagnose" / "debug this", or reports something broken, throwing, failing, or slow.`
- **Use words that live in our codebase and our prompts.** Shared vocabulary between prompt, docs and code makes the agent link them and reach the skill more often.

Every word of an always-loaded pointer costs on every turn, so prune it harder than the body.

## Layer 3: skills calling skills

Inside a skill, a dependency is an explicit instruction to call the tool by name:

> Call the Skill tool with "grilling".

Not a `../other-skill/FILE.md` cross-reference, and not a bare `/grilling` mention left for the model to interpret. Naming the tool gets a materially higher hit rate. One skill per call: two skills is two calls.

This only works for **model-invoked** targets. When a step depends on a user-invoked skill, write it as an instruction for the human: "tell the user to run `/setup-matt-pocock-skills`".

## Layer 4: the harness (deterministic, no instruction budget spent)

### Ship one bundle to everyone

```bash
claude plugins install mattpocock-skills
```

The plugin is a managed, read-only set that updates when upstream ships. Everyone on the team has the same skills at the same version without copying files around. Put the install line in onboarding, and our own skills in a second internal plugin.

### Keep `CLAUDE.md` almost empty

Do **not** run `/init`. Its output burns tokens, distracts the agent, and goes stale: command listings duplicate `package.json`, architecture descriptions duplicate the imports, file references rot on the next refactor.

Every line of `CLAUDE.md` is loaded on **every** request of **every** session, whether or not it is relevant, and a frontier model follows on the order of 150 to 400 instructions consistently. Spend that budget on things the agent cannot discover by looking.

Keep: a one-sentence project description, the package manager if it is not npm, non-standard build commands, unwritten conventions, and the reason behind a surprising choice. Push everything else into `docs/TESTING.md`, `docs/TYPESCRIPT.md` and friends, reached by a one-line pointer. Trust the exploration phase for the rest: the agent reads files just-in-time and gets the current state instead of a stale summary.

In a monorepo, `AGENTS.md` at root and package level merge automatically. Root carries purpose and navigation, packages carry their own stack.

### Hooks: make the right move the only move

Static instructions reduce the probability of a mistake. Hooks make it impossible, and cost zero instruction budget.

| Hook | Use it for |
| --- | --- |
| `PreToolUse` | Block the wrong CLI (`npm` when we are pnpm), block destructive git (`push`, `reset --hard`, `clean`, `branch -D`). Exit 2 blocks the call and feeds the message back to the agent, which then adapts. |
| `UserPromptSubmit` | Inject the skill reminder. Stdout is added to context before the agent answers, so this is where "a change with no plan? run /grill-with-docs first" belongs, rather than in `CLAUDE.md`. |
| `SessionStart` | Load per-session state the agent should not have to discover: current branch's ticket, tracker config. |
| `PostToolUse` | Run the formatter or typechecker after an edit, so the feedback loop closes without the agent deciding to close it. |
| `Stop` | Refuse to end a session with a dirty tree or failing tests. |

Working config in [`templates/settings.json`](../templates/settings.json). `/git-guardrails-claude-code` generates the git set for you.

## What good looks like

- Someone says "this endpoint is slow" and `/diagnosing-bugs` fires without being named.
- Someone says "build the invite flow" and the agent asks to grill first, rather than writing code.
- `npm install` in a pnpm repo is blocked before it runs, not corrected after.
- A new hire ships a correct change on day one without reading the catalog.
