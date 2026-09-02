# Phase 0 Milestone 2 Evidence

## Milestone

Milestone 2 — Accepted Pilot Slices

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
- Authoritative server-side account-state authorization.
- Password hashing through `has_secure_password` / bcrypt.
- Database constraints and indexes for account state and normalized email.

## Automated evidence

The original account-state authorization implementation passed CI in run `33571611776`.

The guided-registration save/resume and password-recovery completion implementation passed CI in run `33633085047` before integration into the Milestone 2 branch.

After integration, GitHub Actions CI run `33658392543` completed successfully for commit `e8b2397286511620cd5a34bf44b2d78642becec5` on PR #4.

Required CI checks completed successfully: `test`, `lint`, and `security`.

Automated coverage includes:

- registration creates a pending member;
- registration progress can be resumed after sign-out/sign-in;
- registration completion state is persisted;
- password reset tokens are time-limited and invalidated after password change;
- anonymous access to the restricted member dashboard is denied;
- pending-member access is denied;
- suspended-member access is denied;
- active-member access is allowed;
- model coverage validates default pending state and normalized email behavior.

The final evidence-documentation commit must also retain the required green CI checks before Product Owner acceptance.

## Non-Production Staging evidence

Provider: Render

Workspace: May December Club

Web Service: `may-december-staging`

URL: `https://may-december-staging.onrender.com`

Deployment branch: `phase-0/milestone-2-registration-authorization`

Environment designation: business-controlled non-Production Staging only.

Startup command: `bundle exec rails db:prepare && bundle exec puma`.

The Milestone 2 branch was deployed successfully. During initial Staging validation, the application returned HTTP 500 until the service startup process was corrected to prepare/migrate the database before Puma starts. After that correction, the application loaded successfully and the Registration / Pending Member slice was exercised manually.

## Manual Staging validation

Initial account-state authorization validation was completed on 2026-09-01. Final registration/save-resume/recovery validation was completed on 2026-09-02 against the integrated Milestone 2 branch.

Observed results:

| Scenario | Expected result | Observed result |
|---|---|---|
| New registration | Account created with `pending` state | Passed |
| Registration Step 1 | Credentials saved and progress persisted | Passed |
| Sign out before registration completion | Incomplete registration remains resumable | Passed |
| Sign back in | User resumes at registration Step 2 | Passed |
| Complete registration | Registration completion state is persisted | Passed |
| Password reset request | Request accepted without account-enumeration disclosure | Passed |
| Valid password-reset token | Password can be changed | Passed |
| Used/invalidated reset token | Token can no longer change the password | Passed |
| Anonymous access to `/members/dashboard` | Access denied; redirect to sign in | Passed |
| Pending member access to `/members/dashboard` | Access denied | Passed |
| Active member access to `/members/dashboard` | Restricted dashboard accessible | Passed |
| Suspended member access to `/members/dashboard` | Access denied | Passed |

The account-state transitions used for manual validation were performed in the Staging environment only.

## Defect / rework note

A Staging deployment issue was discovered during Milestone 2 acceptance validation: the web service initially started Puma without applying the newly introduced database migration. This produced HTTP 500 responses after deployment. The startup process was corrected to run `bundle exec rails db:prepare` before `bundle exec puma`. The application then loaded successfully.

A scope-completeness review subsequently identified two items explicitly present in the accepted Phase 0 Technical Direction but absent from the first Milestone 2 implementation: guided registration with save/resume behavior and the password-recovery foundation. These were implemented before Product Owner acceptance, covered by automated tests, integrated into the Milestone 2 branch, deployed to Staging, and manually validated.

No Production deployment or live Production credentials were introduced.

## Acceptance readiness

The complete Registration / Pending Member vertical slice, including guided registration, save/resume, password/session/recovery foundation, and the representative higher-risk account-state authorization slice, is implemented in business-controlled non-Production Staging.

Automated CI evidence and manual Staging validation are complete. Subject to green CI on the final evidence-documentation commit, Milestone 2 is ready to be submitted to the Product Owner for acceptance review.
