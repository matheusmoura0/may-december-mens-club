# Phase 0 Rework Log

Track material rewrites and rework separately from first-pass implementation.

## Milestone 1 closure

No material rewrite or material implementation rework was recorded for Milestone 1 - Foundation.

## Milestone 2 rework

Milestone 2 includes measured rework and defect correction. The first Milestone 2 implementation omitted guided registration save/resume and the password-recovery foundation; those authorized items were subsequently implemented, tested, integrated and deployed.

The Product Owner Changes Required review then identified missing proof/hardening in the authorized slice: stale-session authorization enforcement, canonical reset-link host configuration, sender-domain correction, minimum password length and additional negative/failure-path tests.

| Date | Work item | Reason for rework | Human rework accounting | Outcome |
|---|---|---|---|---|
| 2026-09-02 | Scope-completeness correction: guided registration save/resume + password recovery | Required authorized scope was incomplete in the first M2 implementation. | Included in previously confirmed aggregate 2.0h rework. | Corrected; automated coverage added and deployed. |
| 2026-09-02 to 2026-09-03 | Product Owner Changes Required corrections | Required proof/configuration and negative-path coverage were incomplete. | Included in previously confirmed aggregate 2.0h rework / 1.0h defect correction baseline. | Stale-state automated proof, canonical `APP_BASE_URL`, sender configuration, password minimum and failure-path coverage added. |
| 2026-09-03 | Product Owner UAT password-recovery / SMTP correction cycle | Product Owner found missing reset confirmation and no delivered recovery email; runtime diagnosis surfaced outbound SMTP `Net::OpenTimeout`. | **3.0h additional human work confirmed by Matheus Moura.** This is retained as an aggregate correction-cycle value; no unsupported per-defect split is invented. | Confirmation UI corrected; business-controlled Brevo Staging delivery corrected; Product Owner end-to-end recovery UAT passed. |
| 2026-09-03 | Final authorization UAT support | Required hands-on proof that an already-authenticated Active member is immediately denied after authoritative Active -> Suspended transition without a new login. | Included within the confirmed post-baseline 3.0h correction/UAT cycle. | Product Owner retained the same session, observed initial Active dashboard access, then immediate denial after the state transition. Passed. |

## Final Milestone 2 accounting

Previously confirmed human-effort baseline: **21.0h**, including **2.0h rework** and **1.0h defect correction**.

Confirmed additional post-baseline correction/UAT work: **3.0h**.

Final actual Milestone 2 human effort: **24.0h**.

Correction/rework-related effort identifiable from the confirmed aggregate accounting: **6.0h**, or **25.0% of 24.0h**. This combines the prior 3.0h aggregate rework/defect correction with the 3.0h post-baseline correction/UAT cycle; it is not represented as a literal code-line rewrite percentage.

All Product Owner hands-on Milestone 2 UAT scenarios completed and passed. Milestone 2 was **ACCEPTED on 2026-09-04**, PR #4 was merged to `main`, and Matheus Moura confirmed payment was received.

## Milestone 3 rule

Milestone 3 review findings that describe future-MVP hardening are not counted as rework unless the authorized Phase 0 submission itself must be changed because of them. Any defect or submission-blocking gap found during Technical Lead review/UAT must be recorded here with actual correction/retest effort before Product Owner submission.
