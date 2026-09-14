# Rollout

A plan for getting a whole engineering group onto this, without a mandate nobody follows.

## Phase 1: one repo, two engineers (week 1)

Pick an active repo with real work in it, not a sandbox.

- Install the plugin, run `/setup-matt-pocock-skills`.
- Add `CLAUDE.md` and `.claude/settings.json` from [`templates/`](../templates/).
- Rule for the week: **no change starts without a grilling session.** Nothing else changes yet.
- Collect: how often the agent's first plan was wrong before the grill, and after.

The grilling skills carry the most value per minute of adoption cost. Lead with them.

## Phase 2: the spine (weeks 2 to 3)

Same repo, add the rest of the main flow: `/to-spec`, `/to-tickets`, `/implement`, `/code-review`.

- Every non-trivial change goes through tickets, one ticket per agent session.
- Turn `/tdd` on for anything with defined inputs and outputs.
- End of each week: `/improve-codebase-architecture`, and file what it finds.

## Phase 3: the harness (week 3)

- Guardrail hooks in every repo (wrong CLI blocked, destructive git blocked).
- `UserPromptSubmit` reminder wired up so the flow suggests itself.
- `CLAUDE.md` audit across repos: anything `/init` generated gets deleted.

## Phase 4: our own skills (week 4 onward)

Anything the team explains to the agent more than twice becomes a skill. Candidates almost every group has:

- our deploy and rollback procedure,
- our PR and commit conventions,
- our incident triage steps,
- our service scaffolding,
- our data migration checklist.

Write them against [05-writing-skills.md](05-writing-skills.md), keep them in one internal repo, ship them as a second plugin so everyone gets updates.

## Gates we hold

| Gate | Rule |
| --- | --- |
| Before code | A grilling session happened, or the change is trivially small. |
| Before merge | `/code-review` ran against a named base, and a human read the diff. |
| Before a big build | `/improve-codebase-architecture` pointed at the spec: "how do we make this change easy?" |
| Before an ADR is skipped | The decision is genuinely reversible. |

## Signals it is working

- Sessions get shorter and the first attempt is more often right.
- `CONTEXT.md` grows, and the team starts using its words in conversation with each other, not only with the agent.
- Agent messages get shorter, because the shared language replaced the paraphrasing.
- Fewer "the agent went off and did something weird" stories in standup.
- New hires productive on an unfamiliar service in days, because the domain docs exist.

## Signals it is not

- `CONTEXT.md` untouched after a week of grilling sessions. The domain modeling is being skipped: name it explicitly.
- `CLAUDE.md` growing past a screen. Instruction budget is being spent on things the agent could have read from the repo.
- Everyone uses `/grill-me` and nobody uses the rest. The spine is not paying off yet; check whether tickets are actually vertical slices.
- Tests that restate the implementation. TDD is being applied to changes with no independent source of truth.

## Anti-patterns

- **Mandating the whole flow on day one.** It is seven habits, not one. Sequence them.
- **Running `/init` "to get started".** It is the opposite of getting started.
- **Treating the skills as read-only scripture.** They are small and composable on purpose. Fork what does not fit us, and record why in an ADR.
- **Owning the process with a framework.** Approaches that own the whole process take away control and make bugs in the process hard to resolve. Small, adaptable skills are the bet.
