# Phase 0 Effort Log

Record actual human effort throughout the pilot. Log specification/clarification, implementation, AI-assisted work/supervision, human review, rework, testing/Staging validation, defect correction, and accepted-output efficiency.

| Date | Work item | Specification / clarification | Human implementation | AI-assisted work / supervision | Human review | Rework | Testing / Staging validation | Defect correction | Total elapsed | Notes |
|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| 2026-08-28 | Repository initialization and Milestone 1 foundation setup | — | 6.0h | 2.5h | 1.0h | 0.5h | 1.0h | — | 11.0h | Actual recorded/reconstructed human time supplied by the Technical Lead. No material defects recorded; no material rewrite recorded. Foundation was included in the controlled PR evidence package after review and limited documentation rework. |
| 2026-08-31 to 2026-09-01 | Milestone 1 closure documentation, governance reconciliation, Staging setup and deploy verification | — | 1.0h | 1.0h | 0.5h | 0.5h | 1.0h | — | 4.0h | Actual recorded/reconstructed human time supplied by the Technical Lead. Includes closure documentation reconciliation, repository governance confirmation, Render Staging setup/deployment follow-up, lockfile/reproducibility correction, and final CI/deploy verification. |
| 2026-09-01 to 2026-09-03 | Milestone 2 Registration / Pending Member + account-state authorization pilot slice — confirmed baseline | 2.0h | 8.0h | 3.0h | 2.0h | 2.0h | 3.0h | 1.0h | 21.0h | Approximate actual human effort supplied and category split confirmed by Matheus Moura. Rework includes the scope-completeness correction for guided registration save/resume and password recovery. Defect correction includes Staging deployment correction and acceptance-review corrections. |
| 2026-09-03 | Milestone 2 post-baseline password-recovery/SMTP correction and final Product Owner UAT support | — | — | — | — | — | — | — | 3.0h | Additional actual human effort confirmed by Matheus Moura after the 21.0h baseline. This 3.0h covers the post-baseline password-recovery/SMTP correction cycle and final Staging/UAT support. No unsupported category-level split is invented; the aggregate is treated as identifiable correction/rework-related effort for the final M2 metric. |

## Milestone summaries

### Milestone 1

Milestone 1 actual recorded/reconstructed human effort totals 15.0 hours:

- Human implementation / documentation: 7.0h
- AI-assisted work: 3.5h
- Human review: 1.5h
- Rework: 1.0h
- Testing / deployment verification: 2.0h

### Milestone 2

Final confirmed Milestone 2 actual human effort totals **24.0 hours**.

The previously confirmed 21.0h baseline remains intact and consisted of:

- Specification / clarification: 2.0h
- Human implementation: 8.0h
- AI-assisted work / supervision: 3.0h
- Human review: 2.0h
- Rework: 2.0h
- Testing / Staging validation: 3.0h
- Defect correction: 1.0h

After that baseline, Matheus Moura confirmed an additional **3.0h** of human work for the password-recovery/SMTP correction cycle and final Product Owner Staging/UAT support. Because no reliable category-level split was recorded for those 3.0h, this log intentionally preserves it as an aggregate post-baseline correction/UAT amount rather than fabricating allocations among implementation, rework, testing, or defect-correction columns.

The identifiable correction/rework-related effort therefore totals **6.0h**, consisting of the prior confirmed **3.0h** aggregate rework + defect correction in the baseline plus the confirmed **3.0h** post-baseline correction/UAT cycle. This equals **25.0% of the final 24.0h Milestone 2 human effort**. This is an effort-based Phase 0 rework/correction measure and is not represented as a literal percentage of source-code lines rewritten.

The Milestone 2 fixed commercial amount is **BRL 7,200**.

## Milestone 2 acceptance and payment status

Milestone 2 was explicitly accepted by Product Owner Michael Fitzgerald on **2026-09-04** after all hands-on acceptance scenarios passed. PR #4 was subsequently merged to `main` as merge commit `58d9014ca7ae5c163dcb1feb17a803c492078dc7`. Matheus Moura confirmed on 2026-09-04 that the Milestone 2 invoice was paid.

### Milestone 3

Milestone 3 — Evidence & Recommendation — is now the active Phase 0 milestone. No Milestone 3 human-effort amount is recorded here until actual effort is supplied/confirmed. Work for M3 must continue to be logged using the same evidence rules below.

## Logging rules

- Update this file at least once per work session.
- Use real elapsed effort or clearly identified reconstructed/approximate actual effort supplied by the Technical Lead, not ungrounded estimates.
- Keep review and rework separate from initial implementation where an actual category split exists.
- When only an aggregate actual amount is confirmed, retain it as aggregate rather than inventing a category split.
- Note material rewrites, omissions, and defects when they occur.
