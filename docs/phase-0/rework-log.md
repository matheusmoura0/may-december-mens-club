# Phase 0 Rework Log

Track material rewrites and rework separately from first-pass implementation.

## Milestone 1 closure

No material rewrite or material implementation rework was recorded for Milestone 1 — Foundation.

Limited closure/documentation reconciliation and the Staging deployment reproducibility correction were performed as part of Milestone 1 completion. The Render deployment initially required a committed `Gemfile.lock`; the lockfile was generated with Bundler and committed, after which deployment succeeded. This was limited configuration/reproducibility rework and did not constitute a material rewrite of the Milestone 1 implementation.

## Milestone 2 rework

Milestone 2 includes measured rework and defect correction. The first Milestone 2 implementation did not yet contain two items explicitly required by the approved Phase 0 direction: guided registration save/resume and the password-recovery foundation. A scope-completeness review identified those omissions, and they were subsequently implemented, tested, integrated, deployed to Staging, and manually validated before Product Owner acceptance.

The Product Owner Changes Required review also identified missing proof/hardening in the already-authorized slice: stale-session authorization enforcement, canonical reset-link host configuration, sender-domain correction, minimum password length, and additional negative/failure-path tests. Those corrections remain within Milestone 2 scope and do not add full-MVP product scope.

| Date | Work item | Original approach | Reason for rework | Human rework time | AI-assisted rework | Rework measure | Outcome |
|---|---|---|---|---:|---:|---|---|
| 2026-09-02 | Scope-completeness correction: guided registration save/resume + password recovery | Initial M2 implementation covered registration, Pending state, sessions and authorization but omitted the complete save/resume and recovery foundation | Approved Phase 0 scope-completeness review | Included in M2 aggregate 2.0h rework | Included in M2 aggregate AI-assisted work | Aggregate M2 rework + defect correction = 3.0h / 21.0h = 14.3% of human effort | Corrected, automated coverage added, deployed and manually validated |
| 2026-09-02 to 2026-09-03 | Product Owner Changes Required corrections | Core behavior existed but proof/configuration and negative-path coverage were incomplete | Controlled Product Owner acceptance review | Included in M2 aggregate 2.0h rework | Included in M2 aggregate AI-assisted work | Same aggregate measure; no claim of literal code-line rewrite percentage | Stale-state test, canonical `APP_BASE_URL`, sender domain, minimum password length and negative-path coverage added |

The Technical Lead supplied and confirmed an aggregate Milestone 2 accounting of 2.0h rework and 1.0h defect correction. Per-item elapsed times were not separately reconstructed, so this log does not invent a false per-defect split.
