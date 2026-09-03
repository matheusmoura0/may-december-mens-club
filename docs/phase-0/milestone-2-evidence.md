# Phase 0 Milestone 2 Evidence

## Milestone and acceptance status

Milestone 2 — Accepted Pilot Slices (milestone name only).

**Current Product Owner acceptance status: Submitted / Changes Required — corrected resubmission package prepared for review. This document does not represent Product Owner acceptance.** PR #4 remains unmerged.

## Implemented pilot slices

- Guided two-step member registration.
- Save/resume registration behavior across sign-out/sign-in.
- Persisted registration completion state through `registration_completed_at`.
- Email/password member registration.
- New members default to `pending`.
- Account states: `pending`, `active`, and `suspended`.
- Session sign-in and sign-out.
- Session reset on successful authentication and registration.
- Basic password recovery foundation with time-limited reset tokens.
- Password reset request and completion endpoints plus mailer foundation.
- Restricted member dashboard.
- Authoritative server-side account-state authorization, including stale authenticated-session enforcement.
- Password hashing through `has_secure_password` / bcrypt.
- Explicit minimum password length of **12 characters**.
- Database constraints and indexes for account state and normalized email.

## Mandatory acceptance requirement mapping

### 2.1 Automated proof of stale-state authorization enforcement

Implementation remains authoritative on current server-side `User#account_state`; an authenticated session stores identity but does not cache or override authorization state.

Automated proof:

- File: `test/integration/registration_authorization_test.rb`
- Test: `active session is denied after authoritative account state changes to suspended`
- Behavior: signs in an Active user, confirms restricted access, changes that same database record to Suspended without ending the session, directly requests the restricted route again, and verifies denial.

Evidence type: **Automated**. The previously validated Active/Suspended restricted-route behavior is also covered in manual Staging validation.

### 2.2 Canonical business-controlled password-reset host

Password reset links no longer derive their host/protocol/port from the incoming request.

- Implementation: `app/controllers/password_resets_controller.rb`, private `application_base_url` method.
- Configuration key: `APP_BASE_URL`.
- Staging setting: `APP_BASE_URL=https://may-december-staging.onrender.com`.
- Deployed environments require the configured value; local non-Production development may fall back to `http://localhost:3000`.
- No Production provider credentials are required.

Automated proof:

- File: `test/integration/registration_authorization_test.rb`
- Test: `password reset request uses configured canonical application base URL`

Evidence type: **Automated + deployed Staging configuration**.

### 2.3 Correct default sender domain

- File: `app/mailers/application_mailer.rb`
- Default sender: `no-reply@maydecemberclub.com`.
- `MAIL_FROM` remains an environment override for a separately approved controlled sender.
- Live mail-provider activation is not enabled or required for Phase 0.

Evidence type: **Code/configuration review**.

### 2.4 Minimum password-strength foundation

- File: `app/models/user.rb`
- Constant: `User::MINIMUM_PASSWORD_LENGTH = 12`.
- Validation rejects passwords shorter than 12 characters while retaining `has_secure_password` / bcrypt.

Automated proof:

- File: `test/integration/registration_authorization_test.rb`
- Test: `password below minimum length is rejected and valid password is accepted`

Evidence type: **Automated**.

### 2.5 Negative and failure-path automated coverage

All required scenarios are covered in `test/integration/registration_authorization_test.rb`:

| Required scenario | Exact automated test | Evidence |
|---|---|---|
| Invalid reset token rejected | `invalid password reset token is rejected` | Automated |
| Expired reset token rejected | `expired password reset token is rejected` | Automated |
| Invalid sign-in rejected without authenticated session | `invalid sign in credentials are rejected without creating an authenticated session` | Automated |
| Case-normalized duplicate email rejected | `case normalized duplicate email registration is rejected` | Automated |
| Anonymous user cannot modify registration completion | `anonymous user cannot modify registration completion state` | Automated |
| Stale Active → Suspended session denied | `active session is denied after authoritative account state changes to suspended` | Automated |

Additional existing automated coverage includes pending/active/suspended/anonymous restricted access, registration save/resume, password-reset success and token invalidation, and configured canonical reset URL.

### 2.6 Named Milestone 2 human technical/security review

**Reviewer:** Matheus Moura  
**Review completion date:** 2026-09-03  
**Human review effort:** 2.0h (included in the Technical Lead-confirmed Milestone 2 effort accounting).

Areas personally reviewed for Milestone 2:

- registration and save/resume flow;
- session authentication and session reset behavior;
- password hashing and minimum-password validation;
- password-reset token lifecycle and canonical reset-link construction;
- account-state model and authoritative restricted-route enforcement;
- stale authenticated-session Active → Suspended behavior;
- normalized email uniqueness behavior;
- negative/failure-path integration coverage;
- Staging deployment configuration and Phase 0 boundary controls.

Findings/corrections recorded during Milestone 2 review include the initial missing save/resume and recovery scope, Staging database-preparation HTTP 500, missing stale-session proof, request-derived reset host, incorrect sender domain, missing explicit password minimum, incomplete negative-path coverage, and the CI test-environment SMTP attempt. These findings are retained in `docs/phase-0/defect-log.md` and `docs/phase-0/rework-log.md`.

Residual findings at resubmission: **no known unresolved finding within the authorized Milestone 2 scope after the listed corrections and green corrected-code CI**. Product Owner acceptance is still pending.

Reviewer statement: the Milestone 2 high-risk authorization and authentication/recovery code was reviewed for **correctness, maintainability, security, and architectural consistency** within the authorized Phase 0 scope.

### 2.7 Milestone 2 effort, rework, and defect accounting

Controlled record: `docs/phase-0/effort-log.md`.

Technical Lead-confirmed approximate actual Milestone 2 human effort: **21.0h**:

- Specification / clarification: 2.0h
- Human implementation: 8.0h
- AI-assisted work / supervision: 3.0h
- Human review: 2.0h
- Rework: 2.0h
- Testing / Staging validation: 3.0h
- Defect correction: 1.0h

Rework + defect correction = **3.0h / 21.0h = 14.3% of total M2 human effort**, used as the equivalent Phase 0 rework measure rather than inventing a literal source-line rewrite percentage.

The initial omission of guided registration save/resume and password recovery is explicitly retained as rework evidence. The fixed Milestone 2 amount remains **BRL 7,200**.

## Automated CI evidence

Historical successful runs retained for traceability:

- Original account-state authorization implementation: run `33571611776`.
- Guided-registration save/resume + password-recovery completion before integration: run `33633085047`.
- Integrated Milestone 2 implementation: run `33658392543`.
- Previous evidence/closure head: run `33659136594`.

The first Changes Required correction head `14bea8d6bc4226c46982d802d37079c08f920d76` produced run `33681299930`: `lint` and `security` passed, while `test` failed because the canonical reset-link integration test attempted SMTP delivery to `localhost:25`. That failure is retained in the defect record.

The test-environment mail configuration was corrected in commit `cbfe4d3c66d2be4c2616bf1596185e88169a4211`. GitHub Actions run **`33779992886` / run #104** completed successfully for that corrected-code commit.

Required checks on that corrected-code baseline: **test, lint, security — green**.

This documentation consolidation commit triggers a new PR CI run. The exact final immutable resubmission head SHA and its green CI run are recorded in the PR #4 resubmission note after that run completes; updating this file solely with its own newly created run ID would itself create another head commit. Product Owner review must use the final PR head and final PR check suite, not an earlier run.

## Non-Production Staging evidence

Provider: Render  
Workspace: May December Club  
Web Service: `may-december-staging`  
URL: `https://may-december-staging.onrender.com`  
Deployment branch: `phase-0/milestone-2-registration-authorization`  
Environment designation: business-controlled **non-Production Staging only**.  
Startup command: `bundle exec rails db:prepare && bundle exec puma`.  
Canonical application URL configuration: `APP_BASE_URL=https://may-december-staging.onrender.com`.

The corrected branch was redeployed after `APP_BASE_URL` configuration. No live Production email provider activation was required.

## Manual Staging validation

Initial authorization validation occurred on 2026-09-01. Registration/save-resume/recovery validation occurred on 2026-09-02. After the Changes Required corrections, the corrected branch was redeployed and the Technical Lead reported the deployment/validation state as working with the required checks green; final resubmission remains subject to the final PR-head CI check suite.

| Scenario | Expected result | Evidence type | Result |
|---|---|---|---|
| New registration | Account created with `pending` state | Automated + Manual Staging | Passed |
| Registration Step 1 | Credentials saved and progress persisted | Automated + Manual Staging | Passed |
| Sign out before completion | Incomplete registration remains resumable | Automated + Manual Staging | Passed |
| Sign back in | Resume at registration Step 2 | Automated + Manual Staging | Passed |
| Complete registration | Completion state persisted | Automated + Manual Staging | Passed |
| Password reset request | Generic response; no enumeration disclosure | Automated + Manual Staging | Passed |
| Canonical reset link | Uses configured `APP_BASE_URL` | Automated + Staging config | Passed |
| Valid reset token | Password can be changed | Automated + Manual Staging | Passed |
| Used token | Cannot change password again | Automated + Manual Staging | Passed |
| Invalid reset token | Rejected | Automated | Passed |
| Expired reset token | Rejected | Automated | Passed |
| Invalid sign-in | Rejected; no authenticated session created | Automated | Passed |
| Duplicate normalized email | Rejected | Automated | Passed |
| Anonymous registration completion update | Denied | Automated | Passed |
| Anonymous restricted dashboard | Denied / redirected to sign in | Automated + Manual Staging | Passed |
| Pending member restricted dashboard | Denied | Automated + Manual Staging | Passed |
| Active member restricted dashboard | Allowed | Automated + Manual Staging | Passed |
| Suspended member restricted dashboard | Denied | Automated + Manual Staging | Passed |
| Existing Active session changed to Suspended in authoritative DB | Next direct restricted request denied without ending session | Automated | Passed |

Only synthetic/test member data was used for Phase 0 validation.

## Defect / rework record retained

The following evidence is intentionally retained rather than removed after correction:

1. **Staging HTTP 500 / database preparation defect:** the web service initially started Puma without applying the newly introduced database migration. Startup was corrected to `bundle exec rails db:prepare && bundle exec puma`.
2. **Initial scope-completeness omissions:** guided registration save/resume and password recovery were absent from the first M2 implementation and required rework.
3. **Product Owner Changes Required findings:** stale-session proof, canonical reset host, sender-domain correction, password minimum and negative/failure coverage were incomplete and were corrected.
4. **CI mail-test defect:** one correction run failed because the test environment attempted SMTP at `localhost:25`; test mail delivery was then isolated with Action Mailer test delivery.

Detailed records: `docs/phase-0/defect-log.md` and `docs/phase-0/rework-log.md`.

## Phase 0 exclusions / boundary confirmation

This resubmission introduced **none** of the following:

- Production deployment;
- Production credentials;
- real member personal data;
- live payment or financial transactions;
- live identity verification / biometric verification;
- live Production email-provider activation;
- MFA;
- profile completion/full Production registration experience;
- messaging, Circles, billing, or other excluded full-MVP capability.

Only the already-authorized Milestone 2 foundation and required acceptance corrections were implemented.

## Resubmission status

PR #4 must remain **unmerged**. Milestone 2 remains **Submitted / Changes Required** until Michael Fitzgerald explicitly confirms Product Owner acceptance.

The corrected implementation, automated evidence, non-Production Staging deployment, named human review, defect/rework accounting, and 21.0h effort record are prepared for consolidated Product Owner resubmission. No Milestone 3 work dependent on Milestone 2 acceptance is authorized by this document.
