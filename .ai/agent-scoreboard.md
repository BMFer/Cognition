# Agent Scoreboard

The scoreboard is a lightweight signal, not a leaderboard. It records how each agent cluster contributes to working, verified progress.

## Metrics

| Agent | Role | Useful claims | Caught defects | Accepted changes | Rework caused | Notes |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| Claude Cluster | Builder / architect / refactor | 0 | 0 | 0 | 0 | Initial role |
| Codex Cluster | Reviewer / tester / alternate implementation | 0 | 0 | 0 | 0 | Initial role |
| GitHub Actions | Neutral judge | 0 | 0 | 0 | 0 | Initial role |
| Human Governor | Final merge authority | 0 | 0 | 0 | 0 | Initial role |

## Update Rule

This file is updated by hand, not by automation. Update it as part of the next PR after a stable checkpoint - never during open review. Prefer small, evidence-backed changes that point at the merged PR or commit.

If this file goes more than ten merges without an update, treat it as stale: either reset the counts and resume the discipline, or remove the scoreboard from the protocol entirely. A stale scoreboard is worse than no scoreboard.
