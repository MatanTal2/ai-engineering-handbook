# The flows

## The main flow: idea to ship

The route most work travels.

```
/grill-with-docs  ->  /to-spec  ->  /to-tickets  ->  /implement  ->  /code-review
   (align)            (write it)     (slice it)      (build it)      (check it)
```

1. **`/grill-with-docs`** sharpens the idea by interview, in a repo. Stateful: it keeps what it learns in `CONTEXT.md` and ADRs. No working directory? Use `/grill-me`.
2. **Branch: can every question be settled in conversation?** If a question needs a runnable answer (state, business logic, a UI you have to see), detour: `/handoff` out, `/prototype` in a throwaway directory, `/handoff` back.
3. **Branch: does the build span more than one agent session?**
   - **No** (fits one context window): skip the spec, go straight to `/implement`.
   - **Yes**: `/to-spec`, then `/to-tickets`.
4. **`/to-tickets`** cuts **vertical slices** (thin cuts through every layer, tracer bullets), not horizontal ones, and records blocking edges so tickets can be picked up in parallel.
5. **`/implement`** builds one ticket per session, driving `/tdd` at the agreed seams, closing with `/code-review` before commit. Clear context between tickets.

## On-ramps that merge onto the main flow

| On-ramp | When |
| --- | --- |
| `/triage` | Work arrived from **other people**: raw bug reports, external PRs, feature requests. Never run it over tickets we generated ourselves; those are agent-ready by construction. |
| `/wayfinder` | The effort is genuinely bigger than one session **and** the route is foggy. It charts a map of decision tickets and resolves them one at a time. Output feeds `/to-spec`. |

The `grill-with-docs` vs `wayfinder` split is session count: one session of planning, or many.

## Upkeep, outside the loop

| Skill | Cadence |
| --- | --- |
| `/improve-codebase-architecture` | Every few days, and **before a big build**, pointed at the spec: "how can we make this change easy?" That is the highest-value prompt for it. |
| `/domain-modeling` | Whenever terminology drifts, or a hard-to-reverse decision needs an ADR. |
| `/diagnosing-bugs` | Any confirmed bug that resists a first look. |

## Phase boundaries: what to do with context

At the end of a phase, in order of preference:

1. Keep going, if the window is still healthy.
2. `/compact`, when the same harness and same directory continue.
3. `/handoff`, when the harness changes, the directory changes, a colleague takes over, or a side task forks off.
4. Fresh session against the written artifact (spec, ticket, handoff doc).
5. `/wayfinder`, when the session grew past what one map-less session can hold.

## Decision table

| You have | Run |
| --- | --- |
| An idea, no repo | `/grill-me` |
| An idea, in a repo | `/grill-with-docs` |
| A settled conversation, build spans sessions | `/to-spec` then `/to-tickets` |
| A settled conversation, build is small | `/implement` |
| A ticket | `/implement #42` |
| One concrete behaviour to build test-first | `/tdd` |
| A diff to check | `/code-review` |
| Something broken | `/diagnosing-bugs` |
| A question talk cannot settle | `/prototype` |
| An external fact a decision waits on | `/research` |
| A tracker full of other people's reports | `/triage` |
| An effort too big for one session | `/wayfinder` |
| A decision stuck in someone else's head | `/to-questionnaire` |
| A message that did not land | `/wait-what` |
| No idea which of these applies | `/ask-matt` |
