# Phase 0 Measurement Scorecard

## Status

**Milestone 3 working baseline — not final / not yet submitted for Product Owner acceptance.**

This scorecard consolidates only metrics supported by the Phase 0 evidence currently recorded in the repository. Missing measurements remain explicitly unreported rather than estimated without evidence.

## Commercial baseline

| Milestone | Name | Fixed amount | Delivery status | Payment status |
|---|---|---:|---|---|
| M1 | Foundation | BRL 5,400 | Completed | Not restated here without a specific payment record in the current evidence set |
| M2 | Accepted Pilot Slices | BRL 7,200 | Accepted; PR #4 merged | Paid — confirmed by Matheus Moura on 2026-09-04 |
| M3 | Evidence & Recommendation | BRL 5,400 | In progress | Not yet due |
| **Phase 0** |  | **BRL 18,000** | In progress |  |

## Human-effort baseline

| Metric | Milestone 1 | Milestone 2 | Phase 0 recorded subtotal before M3 |
|---|---:|---:|---:|
| Actual/reconstructed human effort | 15.0h | 24.0h | **39.0h** |
| Specification / clarification | Not separately recorded | 2.0h in confirmed baseline | At least 2.0h; not fully comparable across milestones |
| Human implementation / documentation | 7.0h | 8.0h in confirmed baseline | 15.0h in explicitly categorized records |
| AI-assisted work / supervision | 3.5h | 3.0h in confirmed baseline | 6.5h in explicitly categorized records |
| Human review | 1.5h | 2.0h in confirmed baseline | 3.5h in explicitly categorized records |
| Rework | 1.0h | 2.0h in confirmed baseline | 3.0h in explicitly categorized records |
| Testing / Staging validation | 2.0h | 3.0h in confirmed baseline | 5.0h in explicitly categorized records |
| Defect correction | No separate M1 defect-correction amount recorded | 1.0h in confirmed baseline | 1.0h explicitly categorized |
| Post-baseline aggregate correction/UAT | — | 3.0h | 3.0h |

### Comparability note

The Milestone 2 3.0h post-baseline correction/UAT amount was intentionally retained as an aggregate because no reliable category-level split was recorded. It must not be redistributed across implementation, testing, rework, or defect correction for presentation purposes.

## Rework / correction indicators

### Milestone 1

- Explicit rework recorded: **1.0h**.
- Recorded M1 effort: **15.0h**.
- Simple explicit-rework share: **6.7%** (1.0 / 15.0), provided only as an effort ratio based on the existing log.
- No separate material source-line rewrite percentage was reliably measured.

### Milestone 2

- Explicit baseline rework: **2.0h**.
- Explicit baseline defect correction: **1.0h**.
- Post-baseline correction/UAT aggregate: **3.0h**.
- Total identifiable correction/rework-related effort: **6.0h**.
- Final M2 effort: **24.0h**.
- Identifiable correction/rework-related effort share: **25.0%**.
- This is an effort-based metric, not a literal percentage of source-code lines rewritten.

### Phase 0 subtotal before Milestone 3

- Recorded human effort: **39.0h**.
- Identifiable M1 explicit rework + M2 correction/rework-related effort: **7.0h**.
- Indicative recorded correction/rework effort share across the 39.0h subtotal: **17.9%**.

This 17.9% subtotal is an arithmetic roll-up of recorded effort categories, not a normalized code-rewrite metric. It may understate categories that were not separately captured in M1 and must be interpreted with that limitation.

## Accepted-output / quality evidence available so far

### Milestone 1

- Foundation deliverables were completed and retained on `main`.
- Architecture/engineering standards, CI, repository governance and Staging foundation evidence are present in the Phase 0 documentation set.

### Milestone 2

- All Product Owner hands-on acceptance scenarios passed before acceptance.
- Registration/save-resume, password-strength and negative authentication/recovery paths were exercised.
- End-to-end password recovery through business-controlled Staging email infrastructure passed.
- Pending/Active/Suspended authorization passed.
- Same-session Active -> Suspended stale-state authorization denial passed.
- M2 was explicitly accepted on 2026-09-04 and PR #4 was merged to `main`.

## Metrics not yet reliably measured

The following must not be presented as final numeric Phase 0 metrics until supported by actual records:

- literal material source-code rewrite percentage;
- accepted-output efficiency as a normalized output-per-hour measure;
- comparable defect density across milestones;
- comparable defect discovery rate by source (CI vs Technical Lead vs Product Owner) unless the defect log supports a complete classification;
- Milestone 3 effort/rework/testing figures;
- full Phase 0 elapsed calendar-cycle efficiency independent of human effort.

Milestone 3 will either derive these from existing traceable evidence or mark them as **not reliably measured** in the final scorecard.

## Milestone 3 measurements to capture prospectively

For every M3 work session, record actual human effort for the categories supported by the work performed. In addition, M3 should explicitly capture:

- Technical Lead review time;
- Technical Lead Staging UAT time;
- defects first found during Technical Lead review/UAT;
- correction time attributable to those defects;
- retest time;
- any material documentation/code rewrite and the basis used to measure it;
- final submission-preparation time;
- whether the first Product Owner M3 submission is accepted without corrective resubmission.

## Finalization rule

This document is a working scorecard. Final values are frozen only after Milestone 3 Technical Lead review, end-to-end Staging UAT, defect/rework reconciliation and final CI evidence are complete.
