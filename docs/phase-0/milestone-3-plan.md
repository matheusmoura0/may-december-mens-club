# Phase 0 Milestone 3 Plan — Evidence & Recommendation

## Status

**IN PROGRESS — NOT YET SUBMITTED FOR PRODUCT OWNER ACCEPTANCE**

Milestone 3 begins from the accepted Milestone 2 baseline merged to `main` in PR #4. This milestone is evidence/recommendation work inside the existing Phase 0 authorization; it does not authorize Production deployment, broader MVP implementation, staffing expansion, or new material external commitments.

## Commercial milestone

- Milestone: **3 — Evidence & Recommendation**
- Fixed amount: **BRL 5,400**
- Submission condition: final Phase 0 evidence and recommendation deliverables completed and submitted.
- Payment condition: Product Owner acceptance under the Phase 0 Authorization.

## Required deliverables

1. Acceptance evidence package.
2. Phase 0 measurement scorecard.
3. Consolidated defect/rework evidence.
4. Architecture review findings.
5. Code-quality / maintainability review findings.
6. Security review findings.
7. Cost/time summary.
8. Technical Lead end-to-end Staging UAT evidence.
9. Final Technical Lead Go / Go-with-conditions / No-Go recommendation.
10. Final Milestone 3 CI/SHA evidence and submission PR.

## Work sequence

### Gate A — Baseline consolidation

- Confirm M1 and M2 evidence present on `main`.
- Reconcile effort, defect, rework, CI and acceptance records.
- Preserve accepted M2 values: **24.0h actual human effort** and **6.0h identifiable correction/rework-related effort (25.0%)**.
- Record M2 acceptance, merge and payment status.
- Establish the initial Phase 0 scorecard without inventing unavailable metrics.

### Gate B — Technical review

Perform and document:

- Rails architecture review;
- authorization/state-transition review;
- authentication/password-recovery review;
- environment/configuration/secrets review;
- automated-test coverage review;
- maintainability/code-quality review;
- residual-risk review.

Every finding must be classified as one of:

- acceptable for Phase 0 / full-build planning;
- condition for future MVP implementation;
- correction required before Milestone 3 submission.

### Gate C — Technical Lead end-to-end Staging UAT

Before Product Owner submission, the Technical Lead must execute the relevant accepted pilot workflows directly against non-Production Staging and record actual PASS/FAIL results.

Minimum successful workflows:

- registration Step 1;
- guided save/resume through sign-out/sign-in;
- registration completion while Pending;
- valid authentication;
- password recovery email delivery;
- valid recovery token and password update;
- Active member restricted-feature access.

Minimum failure/negative workflows:

- password shorter than minimum;
- normalized duplicate email;
- wrong-password/nonexistent-user generic behavior;
- nonexistent-email recovery non-enumeration;
- invalid reset token;
- used reset token reuse attempt;
- anonymous restricted-route denial;
- Pending member restricted-route denial;
- Suspended member denial;
- same-session Active -> Suspended stale-state denial.

No Milestone 3 package should be submitted while a required scenario is failed or unverified. Any defect found during Technical Lead UAT must be retained in the defect/rework logs, corrected, retested and reflected in actual effort accounting.

### Gate D — Scorecard and commercial analysis

Consolidate actual Phase 0 metrics including, where supported by recorded evidence:

- human effort;
- specification/clarification;
- implementation;
- AI-assisted work/supervision;
- review;
- rework;
- testing/Staging validation;
- defect correction;
- elapsed effort;
- accepted-output efficiency;
- material rewrite/rework metric;
- fixed milestone cost;
- observed delivery/correction cycle characteristics.

Metrics that were not actually recorded must be marked **not reliably measured** rather than reconstructed without evidence.

### Gate E — Final recommendation

Prepare the final Technical Lead recommendation as exactly one of:

- **GO** — evidence supports proceeding to full-MVP commercial/technical planning;
- **GO WITH CONDITIONS** — proceed only subject to listed technical/commercial conditions;
- **NO-GO** — pilot evidence does not support proceeding under the evaluated approach.

The recommendation must address architecture, security, maintainability, testing quality, delivery predictability, rework/defect rate, human supervision burden, AI-assisted delivery effectiveness, cost/time evidence and residual risks.

## Submission gate

Milestone 3 is ready for Product Owner acceptance testing/review only when all of the following are true:

- all required deliverables are complete;
- Technical Lead architecture/security/code review is complete;
- Technical Lead Staging UAT success and negative scenarios are completed and recorded;
- all submission-blocking defects found by that UAT are corrected and retested;
- CI is green on the final submission head;
- final effort/rework/defect figures are reconciled;
- final recommendation is explicitly recorded;
- evidence references the final commit SHA and CI run.

The goal is a Technical Lead submission that has already been independently validated and is believed ready for Product Owner acceptance, minimizing correction/resubmission cycles.
