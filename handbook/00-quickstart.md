# Quickstart

## 1. Install the skills (once per machine)

Two routes, two philosophies. Pick **one**; installing both leaves every skill duplicated.

**Claude Code plugin (recommended for the team).** Managed, read-only bundle that updates when upstream ships. Everyone runs the same version.

```bash
claude plugins install mattpocock-skills
```

or from inside a session:

```
/plugin install mattpocock-skills
```

It is in Claude Code's official marketplace, so there is nothing to add first.

**skills.sh installer (for repos where we want to fork and edit the skills).** Copies editable skill files into the project.

```bash
npx skills@latest add mattpocock/skills
```

The installer asks which skills to take and which agents to install on. Make sure `setup-matt-pocock-skills` is one of them. Pull updates later with `npx skills update`.

Use this route for Codex and other non-Claude agents too.

## 2. Set the repo up (once per repo)

```
/setup-matt-pocock-skills
```

It asks three things and writes the answers where the other skills look for them:

- which issue tracker (GitHub, Linear, or local files),
- which labels we apply when triaging,
- where generated docs live.

Symptom of skipping it: `triage`, `to-spec`, `to-tickets` and `wayfinder` start guessing where issues go, or apply labels the tracker does not have.

Running it on a repo that is already halfway through a project is fine. It reads what is there.

## 3. Add our harness config

Copy from [`templates/`](../templates/):

- `CLAUDE.md` at repo root, kept tiny (see [04-auto-invocation.md](04-auto-invocation.md) for why).
- `.claude/settings.json` with our guardrail hooks.

## 4. First session

```
/grill-with-docs
```

Answer the questions honestly, including "I don't know". When the interview ends you have an aligned plan, a `CONTEXT.md` glossary, and ADRs for the hard calls. Then follow the flow in [01-flows.md](01-flows.md).

## Lost?

```
/ask-matt
```

A router: describe the situation, it names the skill or flow that fits.
