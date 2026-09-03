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
| 2026-09-03 | Product Owner UAT password-recovery corrections | Product Owner found missing reset confirmation and no delivered recovery email; runtime diagnosis later surfaced outbound SMTP `Net::OpenTimeout`. | Additional post-baseline human correction time has not yet been confirmed and is intentionally not fabricated. | Confirmation UI corrected; business-controlled Brevo Staging delivery configured/corrected; Product Owner end-to-end recovery UAT now passes, including receipt, canonical link, password update, new-password sign-in, invalid token and used-token rejection. |

The previously confirmed Milestone 2 accounting remains a **21.0h baseline**, including 2.0h rework and 1.0h defect correction. Additional human time for the 2026-09-03 UAT corrections must be added only after the Technical Lead confirms the actual amount.

Milestone 2 remains under Product Owner review pending the remaining Active-member / same-session Active -> Suspended Staging authorization test. PR #4 remains unmerged.
