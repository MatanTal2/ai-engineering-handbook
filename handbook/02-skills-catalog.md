# Skills catalog

Two invocation classes, and the difference matters more than any other property:

- **User-invoked**: reachable **only when a human types it** (`disable-model-invocation: true`). These orchestrate. No other skill can call them either.
- **Model-invoked**: reachable by the human **or by the agent on its own** when the task fits. These hold reusable discipline, and their descriptions carry trigger phrasing so auto-invocation fires.

A user-invoked skill may call model-invoked skills, never another user-invoked one.

---

## Engineering

### User-invoked

**`/ask-matt`** - Router over the skills. Describe your situation, get the skill or flow that fits. Useless once you already know which skill you want.

**`/grill-with-docs`** - Relentless interview that sharpens a plan **and** builds the domain docs as it goes (`CONTEXT.md`, ADRs). Reach for it at the start of any change in a repo, when the plan is fuzzy and the words are not settled. Also useful aimed at a repo with no domain docs at all, with no particular feature in mind.

**`/to-spec`** - Turns the current conversation into a spec on the tracker. No interview, pure synthesis of what was already discussed. It grounds the spec in the current codebase, sketches the testing seams, and quizzes you about which modules the change touches. Trigger: the build is too big for one session and has to survive being split.

**`/to-tickets`** - Breaks a spec (or the raw conversation) into tracer-bullet tickets with blocking edges. Vertical slices, so unknown unknowns surface early and agents can work in parallel. Skip it if the change fits one context window.

**`/implement`** - Builds the work in a spec or ticket, driving `/tdd` at pre-agreed seams and finishing with `/code-review`. One ticket per session. If the plan lives only in the conversation, say so when invoking, or it goes hunting for a file that does not exist.

**`/triage`** - Moves issues and external PRs through a state machine of triage roles: categorise, verify, grill if needed, write agent-ready briefs. Only for work that arrived from someone else.

**`/wayfinder`** - Plans an effort larger than one agent session as a shared map of decision tickets on the tracker, resolved one at a time until the route is clear. The heaviest flow in the set, so the trigger is narrow. Works on legacy codebases as well as greenfield, arguably better, because there the fog is "what is already true here".

**`/improve-codebase-architecture`** - Surveys the codebase for deepening opportunities (concept sprawl across files, over-extracted pure functions hiding bugs, tightly coupled modules) and presents them as an HTML report, then grills through whichever you pick. It is a survey, not a rescue. Run it every few days, before a big build, on a brownfield audit, or before writing tests against untestable code.

**`/setup-matt-pocock-skills`** - One-time per-repo configuration (tracker, labels, docs layout). Run before the first use of anything else here.

### Model-invoked

**`/tdd`** - Red-green-refactor, one vertical slice at a time: one failing test, minimal code to pass it, refactor once green, repeat. It exists because agents default to horizontal slicing, writing all tests up front, and tests written in bulk test imagined behaviour, not observed behaviour. Good tests exercise real code through public interfaces and describe what the system does; bad tests mock internals and break on refactor. This is the most consistent way to improve agent output: when you can trust the tests, you can trust the code. Gap to know: it decides where the seams go, not whether a change is worth the loop at all. On config, wiring, glue, or straight CRUD delegation, that judgement is still yours.

**`/code-review`** - Reviews the diff since a fixed point on two axes in parallel sub-agents: **Standards** (does it follow the repo's documented standards, plus a Fowler smell baseline?) and **Spec** (does it do what the originating issue asked?). You must supply the fixed point. For bug hunting in the diff (null paths, races, off-by-one) use the harness's built-in review instead: different job, similar name.

**`/diagnosing-bugs`** - Gated diagnosis loop for hard bugs and performance regressions: build a feedback loop that goes **red** on this bug, minimise, hypothesise, instrument, fix, regression-test. Has a performance branch (baseline, then bisect). Heavy by design, wrong tool for a one-message question, and it does not audit a codebase for unnamed bottlenecks.

**`/codebase-design`** - Shared vocabulary for **deep modules**: a lot of behaviour behind a small interface, placed at a clean seam, testable through that interface. The bench where you redesign a module you have already chosen.

**`/domain-modeling`** - Actively builds and sharpens the domain model: challenges terms against the glossary, stress-tests with edge cases, updates `CONTEXT.md` and ADRs inline. Known weakness: auto-invocation is unreliable. If a grilling session ends and `CONTEXT.md` is untouched, it was skipped; name it explicitly alongside the other skill.

**`/prototype`** - Throwaway code that answers a design question: a single shareable HTML file for state and logic, or several radically different UI variations behind one route. Reach for it the moment grilling starts ballooning on a question talking cannot settle.

**`/research`** - Investigates a question against high-trust primary sources in a background agent and leaves a cited Markdown file in the repo. The line against `grill-with-docs` is **shelf life**: research produces short-lived facts, grilling produces decisions you keep.

**`/resolving-merge-conflicts`** - Works an in-progress merge or rebase hunk by hunk, resolving by intent traced to each side's source, then finishes the operation. Never `--abort`.

**`/wizard`** - Generates an interactive bash wizard for steps only a human can do: provisioning infra, minting credentials and CI secrets, clicking through a third-party dashboard, a one-off migration or cutover. Better than writing those steps into a README, which rots quietly.

---

## Productivity

### User-invoked

**`/grill-me`** - The interview, anywhere: no repo, no files written, subject need not be code. Start it in a **fresh conversation**, not on top of a plan an agent already wrote, and leave plan mode **off**, because plan mode primes the agent to rush to a plan, the opposite of staying in inquiry. Expect 16 to 50+ questions.

**`/handoff`** - Compacts the conversation into a handoff document for another agent. Four triggers: swapping harness, changing directory or repo, giving the work to a colleague, forking a side task. Anything else, `/compact`.

**`/teach`** - Multi-session teaching workspace for when the learning is the project. Not for one explanation in passing.

**`/to-questionnaire`** - Turns a decision you cannot answer into a Markdown questionnaire for the person who can. Common case: a grilling session stalls on questions that are not yours to answer.

**`/wait-what`** - Fire it the second you notice you are skimming. The agent re-pitches its last message in plain English using the `CONTEXT.md` vocabulary. Only you know when you stopped following, which is why the agent never fires it.

### Model-invoked

**`/grilling`** - The reusable interview primitive behind `grill-me`, `grill-with-docs`, `triage`, `wayfinder` and `improve-codebase-architecture`. Rarely typed directly; usually a skill you did type is running it.

**`/writing-for-agents`** - Reference for writing anything an agent reads: skills, `AGENTS.md` and `CLAUDE.md`, specs, tickets, system prompts. See [05-writing-skills.md](05-writing-skills.md).

---

## Also worth stealing

**`git-guardrails-claude-code`** - Sets up hooks that block destructive git commands (`push`, `reset --hard`, `clean`, `branch -D`) before they execute. See [`templates/settings.json`](../templates/settings.json).

**`setup-pre-commit`** - Husky and lint-staged with formatting, typecheck and tests at commit time. Feedback loops the agent cannot skip.
