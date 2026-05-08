<!--
Cognition pull request template.

Every section below is part of the artifact bundle that the cognition judge
validates. HTML comments are stripped before validation, so replace each
comment with real content - do not leave the prompts in place.
-->

**Cluster**: <!-- claude or codex (required, exactly one) -->

**Mission**: <!-- link to the mission issue, e.g. #12 -->

## Claim

<!-- What does this change assert is now true? One or two sentences. -->

## Evidence

<!--
What files, commands, tests, benchmarks, logs, or references support the claim?
Prefer inspectable references over prose: file paths with line numbers, command
output excerpts, links to CI runs.
-->

## Assumptions

<!--
What must be true for this change to remain valid? List the load-bearing
assumptions a reviewer needs to challenge.
-->

## Test Results

<!--
For each check class you ran, fill in one block. Required: at least one block
with a non-empty Result.

Class:    tests | lint | security | benchmark | other
Command:
Result:   pass | fail | skip
Notes:
-->

```text
Class:
Command:
Result:
Notes:
```

## Counterargument

<!--
What is the strongest reason this change might be wrong, incomplete, or risky?
The validator rejects "N/A", "none", "nothing", or fewer than ~80 characters of
substance. If you cannot find a real risk, the change is probably under-scoped
or under-reviewed.
-->

## Decision

Requested governor outcome (check exactly one):

- [ ] Merge
- [ ] Revise
- [ ] Reject
- [ ] Split task

## Artifact Checklist

- [ ] Cluster identity declared
- [ ] Mission issue linked
- [ ] Claim is explicit
- [ ] Evidence is inspectable
- [ ] Assumptions are recorded
- [ ] Test Results include every relevant check class
- [ ] Counterargument is a real risk, not a dismissal
- [ ] Conflict ledger updated when needed
- [ ] Nap checkpoint planned after merge
