# Phase 0 Milestone 2 Evidence

## Milestone

Milestone 2 — Accepted Pilot Slices

## Implemented pilot slices

- Email/password member registration.
- New members default to `pending`.
- Account states: `pending`, `active`, and `suspended`.
- Session sign-in and sign-out.
- Restricted member dashboard.
- Authoritative server-side account-state authorization.
- Password hashing through `has_secure_password` / bcrypt.
- Database constraints and indexes for account state and normalized email.

## Automated authorization evidence

GitHub Actions CI run `33571611776` completed successfully for commit `3cedc3b5e91e337341d3a7d2dfcd2c94c2327fa6` on PR #4.

The automated suite covers the required positive and negative authorization paths:

- registration creates a pending member;
- anonymous access to the restricted member dashboard is denied;
- pending-member access is denied;
- suspended-member access is denied;
- active-member access is allowed;
- model coverage validates default pending state and normalized email behavior.

Required CI checks completed successfully: `test`, `lint`, and `security`.

## Non-Production Staging evidence

Provider: Render

Workspace: May December Club

Web Service: `may-december-staging`

URL: `https://may-december-staging.onrender.com`

Deployment branch: `phase-0/milestone-2-registration-authorization`

Environment designation: business-controlled non-Production Staging only.

The Milestone 2 branch was deployed successfully. During initial Staging validation, the application returned HTTP 500 because the new database migration had not been applied by the service startup process. The Staging startup configuration was corrected to prepare/migrate the database before Puma starts, after which the application loaded successfully and the Registration / Pending Member slice was exercised manually.

## Manual Staging authorization validation

Manual Staging validation was completed on 2026-09-01 against the deployed Milestone 2 branch.

Observed results:

| Scenario | Expected result | Observed result |
|---|---|---|
| New registration | Account created with `pending` state | Passed |
| Anonymous access to `/members/dashboard` | Access denied; redirect to sign in | Passed |
| Pending member access to `/members/dashboard` | Access denied | Passed |
| Active member access to `/members/dashboard` | Restricted dashboard accessible | Passed |
| Suspended member access to `/members/dashboard` | Access denied | Passed |

The account-state transitions used for manual validation were performed in the Staging environment only.

## Defect / rework note

A Staging deployment issue was discovered during Milestone 2 acceptance validation: the web service initially started Puma without applying the newly introduced database migration. This produced HTTP 500 responses after deployment. The startup process was corrected to run `bundle exec rails db:prepare` before `bundle exec puma`. The application then loaded successfully and all required manual authorization scenarios passed.

This issue was limited to Staging deployment configuration and was resolved before submission for Product Owner acceptance.

## Acceptance readiness

The Registration / Pending Member vertical slice and representative higher-risk account-state authorization slice are implemented in business-controlled non-Production Staging. Automated CI evidence and manual positive/negative authorization validation are complete.

Milestone 2 is ready to be submitted to the Product Owner for acceptance review. No Production deployment or out-of-scope feature work is included.
