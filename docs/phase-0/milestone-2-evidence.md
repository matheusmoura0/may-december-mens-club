# Phase 0 Milestone 2 Evidence

## Milestone and acceptance status

Milestone 2 — Accepted Pilot Slices (milestone name only).

**Current Product Owner acceptance status: UAT INCOMPLETE / NOT ACCEPTED.** PR #4 remains unmerged. This evidence record does not represent Product Owner acceptance or payment approval.

## Product Owner interim UAT — 2026-09-03

Product Owner hands-on Staging UAT confirmed the following scenarios as passed:

- minimum password length rejects passwords shorter than 12 characters;
- Registration Step 1 persists valid credentials and creates a Pending account;
- incomplete registration survives sign-out/sign-in and resumes at Step 2;
- registration completion persists while membership remains Pending;
- completed registration remains complete after a new sign-in;
- Pending member direct access to `/members/dashboard` is denied;
- case-normalized duplicate email is rejected;
- wrong-password and nonexistent-email sign-in paths return the same generic error;
- password-reset request for a nonexistent email does not disclose account existence.

The Product Owner identified password recovery as a blocking failure. The reset request originally returned to Sign In without a visible confirmation and no recovery email was received. The confirmation rendering was corrected. The business then provisioned a Brevo Staging SMTP service using authenticated sending domain `mail.maydecemberclub.com` and verified sender `May December Men's Club <no-reply@mail.maydecemberclub.com>`.

Rails was updated to consume the Staging SMTP environment configuration and to perform the password-reset delivery synchronously in the single Render web service. Runtime logging was also directed to stdout for Staging diagnosis.

Latest observed runtime result on 2026-09-03: the reset request reaches `PasswordResetsController#create` and the synchronous mail-delivery call, but terminates after approximately five seconds with `Net::OpenTimeout (execution expired)`. Brevo showed no corresponding transaction. This demonstrates that the current blocker is the application/runtime opening the configured SMTP connection, before Brevo accepts/authenticates a message.

**Password-recovery UAT remains failed/pending until a recovery message is actually delivered and the Product Owner retests the complete reset lifecycle.**

## Implemented pilot slices

- Guided two-step member registration with save/resume.
- Persisted registration completion state through `registration_completed_at`.
- Email/password authentication; new members default to `pending`.
- Account states: `pending`, `active`, and `suspended`.
- Session sign-in/sign-out and session reset on successful authentication/registration.
- Time-limited password-reset tokens and canonical reset URLs.
- Restricted member dashboard with authoritative server-side account-state authorization.
- Stale authenticated-session enforcement.
- Password hashing through `has_secure_password` / bcrypt.
- Explicit minimum password length of 12 characters.
- Database constraints/indexes for account state and normalized email.

## Mandatory acceptance requirement mapping

### 2.1 Stale-state authorization

`test/integration/registration_authorization_test.rb` contains `active session is denied after authoritative account state changes to suspended`, preserving the authenticated session, changing the authoritative DB state Active → Suspended, and proving the next restricted request is denied.

Evidence: **Automated passed; coordinated Product Owner Staging test still pending.** Dedicated Pending/Active/Suspended Staging account provisioning support is implemented in `lib/tasks/phase0_uat.rake`.

### 2.2 Canonical password-reset host

Reset links use environment-controlled `APP_BASE_URL`. Staging is configured for `https://may-december-staging.onrender.com`. Automated coverage verifies canonical URL construction.

Evidence: **Automated + Staging configuration. Full delivered-link UAT pending SMTP delivery.**

### 2.3 Sender / Staging mail infrastructure

Staging mail configuration consumes `SMTP_ADDRESS`, `SMTP_PORT`, `SMTP_USERNAME`, `SMTP_PASSWORD`, `SMTP_FROM_ADDRESS`, and `SMTP_FROM_NAME`. The business-controlled verified sender is `May December Men's Club <no-reply@mail.maydecemberclub.com>`.

Evidence: **Configuration/code present; end-to-end delivery not yet passed.** Latest runtime attempt failed with `Net::OpenTimeout` before a Brevo transaction was created.

### 2.4 Password-strength foundation

`User::MINIMUM_PASSWORD_LENGTH = 12`; automated coverage rejects shorter passwords. Product Owner UAT passed this scenario.

### 2.5 Negative/failure paths

Automated coverage includes invalid/expired reset token, invalid sign-in without session creation, case-normalized duplicate email, anonymous registration completion denial, and stale Active → Suspended denial. Product Owner UAT independently passed the generic sign-in/no-enumeration and duplicate-email scenarios described above.

### 2.6 Human technical/security review

Repository history contains a prior review record attributed to Matheus Moura dated 2026-09-03. Subsequent Product Owner UAT exposed additional Staging mail-delivery findings, so that earlier record must not be interpreted as evidence that final Staging UAT is complete. Final human review/closure remains pending after the current corrections and Product Owner retest.

### 2.7 Effort / rework / defect accounting

The previously confirmed Milestone 2 effort baseline was 21.0h. Additional UAT correction work has occurred after that baseline. Its human effort has not yet been confirmed by the Technical Lead and therefore is **not fabricated or silently added** here. The fixed Milestone 2 commercial amount remains **BRL 7,200**; invoicing does not itself constitute Product Owner acceptance.

## CI and deployment evidence

Historical CI is retained in repository/GitHub Actions history. Relevant correction heads include:

- `620bdc3a856907da87e553433f3076b5b39713e4` — password-reset delivery changed to synchronous delivery for the single Staging web service; GitHub Actions run #126 completed successfully.
- `80b6d7175d8a4cce5f9aecb358542a865bfaf0ad` — Staging stdout/error logging correction to expose runtime delivery failures.

Render successfully deployed the correction branch to `may-december-staging`. Runtime requests for normal sign-in, registration, sign-out and home navigation were observed completing successfully. The password-reset POST alone was observed returning HTTP 500 with `Net::OpenTimeout` at the synchronous delivery call.

## Current Staging blocker and required retest

Before final Milestone 2 acceptance evidence can be submitted:

1. Correct/verify the Brevo SMTP endpoint/port connectivity in the Render Staging environment and prove a transaction reaches Brevo.
2. Product Owner repeats password-reset UAT and verifies sender, canonical Staging reset URL, valid token/password update, invalid/reused token behavior and subsequent sign-in.
3. Provide/use dedicated Pending, Active and Suspended Staging UAT accounts.
4. Coordinate the Active → Suspended stale-session test without terminating the Product Owner browser session.
5. Record final Product Owner acceptance explicitly before merging PR #4.

## Phase 0 boundaries

All work remains limited to business-controlled non-Production Staging. No Production deployment, Production member data, live payment, live identity verification, MFA, or broader full-MVP capability is authorized by this evidence record.

## Resubmission status

PR #4 must remain **unmerged**. Milestone 2 remains **UAT INCOMPLETE / NOT ACCEPTED** until Michael Fitzgerald explicitly confirms Product Owner acceptance. This document intentionally preserves the UAT failure and SMTP timeout rather than representing the milestone as complete.
