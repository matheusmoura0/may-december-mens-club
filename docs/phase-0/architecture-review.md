# Phase 0 Milestone 3 Architecture Review

## Status

**Technical Lead review complete for the accepted Phase 0 pilot slice.** This review evaluates the architecture actually implemented in the repository and identifies conditions for any future full-MVP build. It does not authorize Production deployment or additional scope.

## Reviewed areas

- Rails application structure and request flow;
- User/account-state model;
- registration/save-resume flow;
- session authentication;
- authoritative member authorization;
- password recovery;
- Staging-only UAT transition support;
- persistence constraints;
- mail/environment configuration;
- automated CI/test architecture.

## Findings

### A1 — Account state is represented explicitly and constrained

**Classification: acceptable for Phase 0 / full-build planning.**

`User` uses a string-backed enum for `pending`, `active`, and `suspended`, with `pending` as the default. The database migration also applies a non-null default, an index on `account_state`, and a check constraint limiting stored values to those three states. This provides both application-level and persistence-level protection against invalid account-state values.

### A2 — Restricted member authorization is enforced server-side on every request

**Classification: acceptable for Phase 0 / full-build planning.**

The restricted member dashboard uses `before_action :require_active_member!`. `current_user` is resolved from the session user id through the database for the request, and `require_active_member!` checks the current authoritative `active?` state before allowing access. The accepted integration test explicitly covers an already-authenticated Active user becoming Suspended and being denied on the next request.

This architecture is appropriate for the approved higher-risk Phase 0 slice because authorization is not inferred only from login-time state or from client-side state.

### A3 — Authentication/session handling is intentionally simple and coherent for the pilot

**Classification: acceptable for Phase 0 / full-build planning.**

Authentication uses Rails `has_secure_password`. Successful sign-in and password reset both rotate the Rails session with `reset_session` before assigning `session[:user_id]`, reducing session-fixation risk. Pending and Suspended users may authenticate, but restricted feature access is independently enforced by account state.

For a future full MVP, authentication/session policy should be revisited together with MFA, device/session management, lockout/rate-limit behavior, and administrative account-state workflows.

### A4 — Registration completeness is modeled separately from membership authorization

**Classification: acceptable for Phase 0 / full-build planning.**

Registration completion is represented by `registration_completed_at`, while membership authorization remains represented by `account_state`. This separation avoids conflating onboarding completion with business approval/authorization and is consistent with the accepted Pending-member workflow.

The current guided registration is intentionally minimal for the pilot. A full build should move richer registration/application data into explicit domain models rather than expanding the `User` record without a domain review.

### A5 — Password-reset token lifecycle uses Rails signed-purpose tokens

**Classification: acceptable for Phase 0 / full-build planning.**

Password reset uses `generates_token_for :password_reset` with a 30-minute expiry and includes password-salt material in the token invalidation basis. Changing the password invalidates the prior token. Automated coverage exists for successful reset, invalid token, expired token, and used-token invalidation.

### A6 — Canonical application URL is configuration-driven

**Classification: acceptable for Phase 0 / full-build planning.**

Password reset links are built from `APP_BASE_URL`, and deployed environments fail closed when that configuration is absent. This avoids deriving security-sensitive reset links from an arbitrary request host. Staging uses the business-controlled canonical Render URL.

For a full multi-environment build, canonical URL configuration should be centralized in environment-specific application configuration or a dedicated URL service rather than remaining controller-local.

### A7 — Synchronous SMTP delivery is suitable only as a Phase 0/Staging simplification

**Classification: condition for future MVP implementation.**

The password reset request performs `deliver_now` in the web request. This was a deliberate Phase 0 choice so Staging could exercise business-controlled SMTP without requiring a separate job worker. It is not the preferred full-MVP architecture because external SMTP latency/failure is directly coupled to request latency and availability.

Before Production/full-MVP launch, delivery should move behind Active Job with a durable queue/retry strategy, operational monitoring, and user-facing behavior that remains non-enumerating even when the mail provider is degraded.

### A8 — Staging UAT state-transition endpoint is tightly scoped but must not become a Production feature

**Classification: condition for future MVP implementation.**

The Phase 0 UAT state-transition controller requires authentication, requires the exact configured Staging `APP_BASE_URL`, and requires the authenticated email to match `UAT_ACTIVE_EMAIL`. This is adequate for controlled non-Production pilot testing.

Before any Production launch, the UAT route/controller and related UAT environment configuration should be removed or disabled through an explicit environment capability, rather than relying on it remaining unreachable through configuration convention alone.

### A9 — Data constraints are adequate for the pilot baseline

**Classification: acceptable for Phase 0 / full-build planning.**

Email is normalized before validation, has application-level case-insensitive uniqueness validation, and has a database unique index. Because application writes normalize email to lowercase, the database index protects the normalized values against races. The account-state check constraint provides an additional persistence boundary.

For future bulk imports/admin integrations, all write paths must preserve the same normalization invariant.

### A10 — CI architecture provides three independent quality gates

**Classification: acceptable for Phase 0 / full-build planning.**

CI runs application tests against PostgreSQL, RuboCop linting, Brakeman static application security scanning, and `bundler-audit` dependency checks. This is a suitable baseline for the pilot and should be retained for full-MVP development.

Future work should add system/browser tests for critical end-to-end user journeys and, when frontend behavior becomes richer, appropriate frontend/static analysis coverage.

## Architecture conclusion

No architecture defect identified in this review requires correction before Milestone 3 submission based on the authorized Phase 0 scope. The accepted pilot architecture provides clear server-side authorization, explicit state modeling, secure password hashing/token handling, database constraints, and automated quality gates.

The main full-build conditions are to replace synchronous email delivery with resilient background delivery, remove/disable Phase 0 UAT-only endpoints before Production, and evolve the intentionally minimal pilot domain structure before expanding the MVP feature set.
