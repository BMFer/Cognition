# Nap Checkpoints

A nap checkpoint is the stable memory written after a reasoning cycle pauses. One checkpoint per merge.

## What Belongs Here vs. in the Decision Log

- **Nap checkpoint** = system-state snapshot at this merge: what changed, what is now proven, what remains uncertain, what the next cycle should answer.
- **Decision log** (`decision-log.md`) = explicit record of a chosen path over rejected alternatives, with the governor outcome.

The post-merge `cognition-checkpoint.yml` workflow comments a paste-ready stub on every merged PR. Land it in the next PR's first commit.

## Cycle

```text
Think -> commit -> summarize -> test -> review -> pause -> replan
```

## Template

```text
Date:
Checkpoint:
Merged commit / PR:
What changed:
What was proven:
What remains uncertain:
Next replan:
```

## Checkpoints

No stable checkpoints recorded yet.
