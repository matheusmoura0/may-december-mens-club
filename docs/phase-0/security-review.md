# Phase 0 Milestone 3 Security Review

## Status

**Technical Lead security review complete for the accepted Phase 0 pilot slice.** Findings are limited to the repository implementation and accepted non-Production Staging behavior. This is not a Production security certification.

## Reviewed controls

- password storage and policy;
- session creation/rotation;
- login failure behavior;
- password-recovery enumeration resistance;
- reset-token expiration/invalidation;
- canonical reset-link host;
- authoritative account-state authorization;
- stale-session denial;
- Staging UAT-only state transition;
- SMTP/secrets configuration;
- CI security checks;
- obvious abuse/rate-limit gaps relevant to full-MVP planning.

## Findings

### S1 — Password storage and minimum length

**Classification: acceptable for Phase 0 / full-build planning.**

Passwords are handled with Rails `has_secure_password`/bcrypt. The application enforces a 12-character minimum and the integration suite contains explicit short-password rejection coverage.

A future Production policy should be reviewed against the final business/security requirements and may add breached-password checks or other controls, but no Phase 0 submission correction is required here.

### S2 — Session fixation mitigation

**Classification: acceptable for Phase 0 / full-build planning.**

Successful authentication and successful password reset call `reset_session` before storing the authenticated user id. This is the expected session-rotation pattern for the current Rails session architecture.

### S3 — Authentication failure messaging is generic

**Classification: acceptable for Phase 0 / full-build planning.**

Invalid email and invalid password share the same `Invalid email or password.` response. Automated coverage confirms invalid credentials do not create an authenticated session.

### S4 — Password-recovery visible messaging is non-enumerating

**Classification: acceptable for Phase 0, with a future-MVP hardening condition.**

The visible password-reset request result is generic whether or not the email exists. However, the current implementation sends SMTP synchronously only when a user exists. This creates a potential timing/availability side channel: requests for existing users can wait on SMTP or fail if the provider is unavailable, while nonexistent users do not perform that work.

This did not invalidate the accepted Phase 0 visible-response requirement, but before Production the workflow should be moved to an asynchronous job and designed so provider latency/failure does not make account existence materially distinguishable through response timing or status.

### S5 — Reset tokens have bounded lifetime and one-time behavior after password change

**Classification: acceptable for Phase 0 / full-build planning.**

The reset token expires after 30 minutes and is invalidated by password-salt change when the password is updated. Automated tests cover valid reset, invalid token, expired token and prior-token non-reuse.

### S6 — Reset links use controlled canonical configuration

**Classification: acceptable for Phase 0 / full-build planning.**

Reset URLs use `APP_BASE_URL` rather than request host/protocol. Deployed environments without that configuration raise rather than silently using an arbitrary host. This addresses the host-header/reset-link concern identified during M2.

### S7 — Account-state authorization is authoritative at request time

**Classification: acceptable for Phase 0 / full-build planning.**

Restricted member access uses a server-side `active?` check against the user loaded from persistence during the request. Automated and Product Owner UAT evidence already proved that an authenticated Active session is denied immediately after the database state changes to Suspended.

### S8 — Pending and Suspended users may authenticate but cannot access the restricted member area

**Classification: acceptable for Phase 0 / full-build planning.**

This is a deliberate separation between identity authentication and business authorization. It enables the application to present registration/membership state while protecting restricted functionality through `require_active_member!`.

A future MVP should define which non-restricted authenticated capabilities remain available to Suspended users and test every privileged feature against the same authorization policy.

### S9 — Staging UAT transition endpoint is restricted but must not ship as a Production capability

**Classification: condition for future MVP implementation.**

The UAT transition endpoint requires authentication, exact Staging `APP_BASE_URL`, and exact `UAT_ACTIVE_EMAIL`. That is sufficient for the controlled Phase 0 environment. Before Production, remove or explicitly disable this route/controller and the corresponding UAT configuration.

### S10 — SMTP credentials are environment-driven

**Classification: acceptable for Phase 0 / full-build planning.**

SMTP address, username, password, sender and transport behavior are supplied through environment configuration; credentials are not embedded in the reviewed source. Mail delivery is opt-in based on configured environment values.

No secret value is copied into Phase 0 documentation.

### S11 — No application-level rate limiting is visible for sign-in or password-reset requests

**Classification: condition for future MVP implementation.**

The reviewed controllers do not implement request throttling/lockout for repeated login or password-reset requests. This is acceptable for the narrowly controlled Phase 0 pilot, but Production/full-MVP planning should add abuse controls appropriate to the deployment architecture, preferably at both edge/platform and application levels where necessary.

### S12 — CI includes static security and dependency checks

**Classification: acceptable for Phase 0 / full-build planning.**

The GitHub Actions workflow runs Brakeman and `bundler-audit` in addition to tests and linting. These should remain mandatory quality gates for future development.

## Security conclusion

No security issue identified by this review requires a code correction before Milestone 3 submission within the authorized non-Production Phase 0 scope.

The material future-MVP conditions are: asynchronous/resilient password-email delivery with enumeration-resistant failure behavior, explicit removal/disablement of UAT-only routes before Production, and rate limiting/abuse protection for authentication and recovery endpoints. These conditions must be carried into the final Technical Lead recommendation rather than represented as completed Production controls.
