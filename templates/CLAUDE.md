<!--
Template. Copy to the repo root as CLAUDE.md (or AGENTS.md, and symlink).

Rule: as small as possible. Every line loads on every request of every session.
Include only what the agent cannot discover by reading the repo.
Do NOT run /init. Do not paste architecture summaries, command lists, or file
trees here: package.json, the imports and the directory layout already say it,
and they stay current.

Delete every line below that does not apply. An empty CLAUDE.md is a good one.
-->

<!-- One sentence. What is this project? -->
Checkout service for the storefront: takes a cart, returns a paid order.

<!-- Only if it is not npm. -->
pnpm workspaces. Never npm or yarn.

<!-- Only commands that differ from the obvious default. -->
Typecheck is `pnpm check`, not `pnpm tsc`.

<!-- Unwritten conventions and gotchas no config confesses. -->
Prices are integer minor units everywhere. A float in a money path is a bug.

<!-- Pointers to disclosed reference. One line each, wording does the triggering. -->
Testing conventions, including what we do and do not mock: @docs/TESTING.md
Domain glossary, for terminology: @CONTEXT.md
