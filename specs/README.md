# specs/

System-of-record specifications: durable contracts that outlive any single PR. Examples: protocol invariants, interface contracts between cluster nodes, schema definitions for shared artifacts.

Specifications change through PRs that follow the same artifact-bundle protocol as code. A spec change is itself a load-bearing decision and belongs in `.ai/decision-log.md`.
