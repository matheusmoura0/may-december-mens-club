# Phase 0 Milestone 3 Code Quality / Maintainability Review

## Status

**Technical Lead code-quality review complete for the accepted Phase 0 pilot slice.**

## Reviewed areas

- controller responsibilities and flow clarity;
- model responsibilities and invariants;
- route structure;
- test coverage organization;
- CI quality gates;
- configuration placement;
- maintainability risks for future MVP expansion.

## Findings

### Q1 — Pilot code is small and responsibilities are easy to trace

**Classification: acceptable for Phase 0 / full-build planning.**

The accepted slice keeps registration, sessions, password resets, member authorization and UAT transition behavior in separate controllers. The `User` model contains the principal identity/account-state invariants. For the current pilot size, this is understandable and reviewable without introducing unnecessary service-layer abstraction.

### Q2 — Authorization logic is centralized enough for the current slice

**Classification: acceptable for Phase 0 / full-build planning.**

Authentication and Active-member authorization are defined in `ApplicationController` and reused by the restricted dashboard. This avoids duplicating the critical account-state decision in the member feature implemented by the pilot.

For a full MVP with multiple roles, entitlements, administrative actions or object-level permissions, this should evolve into a more explicit authorization policy layer rather than accumulating additional controller predicates.

### Q3 — Registration controller is intentionally minimal

**Classification: acceptable for Phase 0 / full-build planning.**

The registration flow proves save/resume and completion semantics, but the current update action only records `registration_completed_at`. This is appropriate for the authorized pilot evidence; it is not a complete member-application domain model.

Future MVP work should define the actual registration/application aggregates and validation boundaries before extending this controller.

### Q4 — Password reset contains deployment-specific delivery logic in the controller

**Classification: condition for future MVP implementation.**

`PasswordResetsController#create` constructs the canonical reset URL and calls the mailer synchronously. This is simple and testable for the pilot, but the full build should separate delivery orchestration from the HTTP controller and use background execution/retry behavior.

### Q5 — Canonical URL logic should be centralized when environments expand

**Classification: condition for future MVP implementation.**

The `application_base_url` helper currently lives inside `PasswordResetsController`. It correctly enforces the configured host for the current slice, but a full application will likely need canonical URL behavior across mailers and other external links. Centralizing it will reduce drift.

### Q6 — Integration coverage is strong for the high-risk pilot behaviors

**Classification: acceptable for Phase 0 / full-build planning.**

The principal integration test covers registration persistence/resume, password minimum, canonical reset URL, generic reset confirmation, valid/invalid/expired token behavior, invalid sign-in, duplicate email, anonymous access denial, Pending/Suspended denial, Active access and same-session Active -> Suspended denial.

This aligns tests with the high-risk user journeys rather than relying only on isolated unit tests.

### Q7 — Unit/controller coverage is intentionally light outside the high-risk path

**Classification: acceptable for Phase 0, condition for future MVP implementation.**

The current repository has a small `UserTest` plus a basic home-controller test, with most critical behavior validated through integration tests. This is reasonable for the pilot. As the domain expands, model/service/policy tests should be added where they provide clearer defect localization and faster feedback.

### Q8 — CI is appropriately layered

**Classification: acceptable for Phase 0 / full-build planning.**

CI separates application tests, RuboCop linting, and security checks. Brakeman and `bundler-audit` are explicit jobs. This should remain the minimum baseline in later phases.

### Q9 — UAT-only code is clearly namespaced

**Classification: acceptable for Phase 0, condition for future MVP implementation.**

The state-transition helper is isolated under `Phase0::Uat`, which makes its purpose and removal boundary obvious. It should still be removed or explicitly disabled before Production.

## Maintainability conclusion

The accepted Phase 0 slice is maintainable at its current size and suitable as pilot evidence. No code-quality correction is required before Milestone 3 submission based on this review.

The primary future-MVP refactoring conditions are to introduce a more explicit authorization policy layer as permissions grow, model the full registration/application domain explicitly, move external mail delivery out of the request path, centralize canonical URL/configuration concerns, and expand targeted test layers as complexity increases.
