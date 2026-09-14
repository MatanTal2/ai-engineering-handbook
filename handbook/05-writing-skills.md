# Writing our own skills

Same craft applies to any document an agent reads: a `SKILL.md`, a `CLAUDE.md`, a spec, a ticket, a system prompt. The packaging differs; the writing does not. The goal is not the same output every run, it is the same **process** every run.

## Shape of a skill

```
skills/<bucket>/<skill-name>/
  SKILL.md            # frontmatter + steps + in-file reference
  SOME-REFERENCE.md   # disclosed reference, reached by a pointer
  scripts/            # anything deterministic enough to be code
```

```yaml
---
name: deploy-preview
description: Deploy a preview environment. Use when the user asks for a preview, a staging link, or to show a branch to someone.
---
```

## The two budgets

Everything you add spends one of two:

- **Context load**: always-loaded material (a `CLAUDE.md` line, a skill description). Costs tokens and attention every single turn, fired or not.
- **Cognitive load**: the cost on the human of knowing which documents exist and when to reach for each. Not a cost to minimise to zero. It is the price of human agency. Spend it where human judgement matters.

Material behind a pointer escapes context load for the price of the pointer's own line. Material with no pointer rides entirely on cognitive load.

## Information hierarchy

Three rungs, ranked by how immediately the agent needs the material:

1. **In-file step** - what the agent does, in order. The primary tier.
2. **In-file reference** - definitions and rules consulted on demand. A flat peer set (every rule of a review on one rung) is a fine arrangement, not a smell.
3. **Disclosed reference** - pushed to a separate file behind a pointer, loaded only when the pointer fires.

**Progressive disclosure** is the move down that ladder. The cleanest test is branching: inline what every branch needs, push behind a pointer what only some branches reach. Push too little and the top bloats; push too much and you hide what the agent actually needs.

**Co-location** is the within-file companion: a concept's definition, rules and caveats under one heading, so reading one part brings its neighbours. The test: it should read like documentation written for the agent.

**Sprawl** is the failure mode: a document simply too long even when every line is live. Attention thins across the excess.

## Steps end on completion criteria

Every step ends on the condition that tells the agent it is done. Two properties make that a lever:

- **Clarity**: can the agent tell done from not-done? A vague bound ("understanding reached") invites **premature completion**, the agent's attention slipping toward being finished while visible later steps pull it forward. Sharpen the bound first, it is local and cheap. Only if it is irreducibly fuzzy *and* you observe the rush, split the sequence so the later steps are out of view, and only across a real context boundary (a handoff or a subagent), because an inline call clears nothing.
- **Demand**: how much it requires. "Every modified model accounted for" forces thorough work where "produce a change list" does not. Demand drives the legwork the agent does inside the step.

The strongest criteria are both checkable and exhaustive.

## Leading words

A **leading word** is a compact concept already in the model's pretraining that the agent thinks with while running the document: *lesson*, *fog of war*, *tracer bullet*, *red*, *tight*, *relentless*. Repeated as a token, never restated as a sentence, it anchors a whole region of behaviour in a handful of tokens by recruiting priors the model already holds. Coining your own works only if you define it clearly, and you pay in definition tokens what a pretrained word gives free.

It anchors twice: in the body it steers execution, in a pointer it steers invocation. When the same word lives in our prompts, our docs and our code, the agent links them and reaches the material more reliably.

Hunt for passages that collapse into one token:

- "fast, deterministic, low-overhead" becomes *tight* (a tight loop).
- "a loop you believe in" becomes *red*, turning a fuzzy gate into a binary observable state.

**Negation is the failure mode beside this lever.** Steering by prohibition drags the forbidden behaviour into context and makes it *more* available. Don't think of an elephant. Prompt the positive: state the target behaviour so the banned one is never spoken. A prohibition earns its place only as a hard guardrail you cannot phrase positively, and even then pair it with the positive target.

## Pruning

- **Single source of truth.** One authoritative place per meaning, so a behaviour change is a one-place edit. Duplication costs maintenance, costs tokens, and inflates a meaning's apparent rank.
- **The environment is a source of truth too.** `package.json` scripts, config files, directory layout, `--help` output. A document restating them is a cache, and a cache earns its load only when the lookup is expensive. Cache what the agent cannot find by looking: the unwritten convention, the reason behind a choice, the gotcha no config confesses.
- **Relevance, line by line.** A line dies by never bearing on the task or by going stale. Without pruning the default fate is **sediment**: stale layers that settle because adding feels safe and removing feels risky.
- **Hunt no-ops.** An instruction the model already obeys by default pays load to say nothing. The test is model-relative, not reader-relative: two people disagreeing about a no-op disagree about the default, and settle it by running the document, not by arguing. When a sentence fails, delete the sentence, do not trim its words. The test also grades leading words: *be thorough* when the agent is already thorough-ish is a no-op, and the fix is a stronger word (*relentless*), not a different technique.

## Our checklist before merging a skill

- [ ] Invocation class chosen deliberately, and the description written for that audience.
- [ ] Description names the concrete phrases a person would actually type.
- [ ] Steps are ordered and each ends on a checkable criterion.
- [ ] Reference only some branches need is behind a pointer.
- [ ] Dependencies written as "Call the Skill tool with X", and X is model-invoked.
- [ ] No prohibition that could have been a positive instruction.
- [ ] No line restating `package.json`, the directory layout, or the model's defaults.
- [ ] Run it twice on different tasks before merging. A skill is a process, and you verify it by running it.
