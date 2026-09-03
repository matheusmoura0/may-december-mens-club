# Phase 0 Milestone 2 Evidence

## Milestone and acceptance status

Milestone 2 - Accepted Pilot Slices (milestone name only).

**Current Product Owner acceptance status: UNDER REVIEW / NOT YET ACCEPTED.** PR #4 remains unmerged. This evidence record does not represent Product Owner acceptance.

## Product Owner UAT - 2026-09-03

Product Owner Michael Fitzgerald completed additional hands-on Staging UAT after the latest correction.

### Confirmed passed

- Password-reset request is accepted and returns the non-enumerating confirmation message.
- Recovery email is successfully transmitted through Brevo and received.
- Recovery link uses the canonical Staging host `may-december-staging.onrender.com`.
- A valid reset token opens the password-change form.
- A new password is successfully accepted.
- Authentication succeeds with the new password.
- A fabricated/invalid reset token is rejected.
- A previously used reset token cannot be reused.
- Pending-member authorization remains enforced: while signed in as Pending, direct navigation to `/members/dashboard` is denied and redirects to the root/pending-member screen.

Earlier Product Owner UAT also confirmed minimum password-length enforcement, registration Step 1 persistence, save/sign-out/resume behavior, registration completion persistence, normalized duplicate-email rejection, generic wrong-password/nonexistent-email sign-in behavior, and non-enumerating password-reset handling.

### Remaining Product Owner UAT

The remaining acceptance test is the Active-member/stale-session authorization path:

1. Product Owner signs in as an Active member and confirms `/members/dashboard` is authorized.
2. The existing browser session remains signed in.
3. The authoritative account state is changed from Active to Suspended in Staging without logging that session out.
4. The same existing session requests the restricted route again.
5. Expected result: immediate denial without requiring a new login.

Dedicated UAT account/state support exists in `lib/tasks/phase0_uat.rake` for Pending, Active and Suspended accounts and for transitioning the configured Active UAT account to Suspended.

## Mandatory acceptance requirement mapping

### 2.1 Stale-state authorization enforcement

Automated proof exists in `test/integration/registration_authorization_test.rb` via `active session is denied after authoritative account state changes to suspended`.

Evidence status: **Automated passed; Product Owner coordinated Staging validation pending.**

### 2.2 Canonical password-reset host

Reset links use business-controlled `APP_BASE_URL`, with Staging configured as `https://may-december-staging.onrender.com`.

Evidence status: **Automated passed + Product Owner end-to-end Staging UAT passed.**

### 2.3 Sender / Staging mail delivery

Staging uses the business-controlled Brevo SMTP setup and verified sender under `mail.maydecemberclub.com`.

Evidence status: **End-to-end Product Owner Staging UAT passed: message transmitted through Brevo and received.**

### 2.4 Minimum password strength

`User::MINIMUM_PASSWORD_LENGTH = 12` with automated rejection coverage.

Evidence status: **Automated passed + Product Owner UAT passed.**

### 2.5 Negative/failure paths

Automated coverage includes invalid/expired reset token, invalid sign-in without session creation, normalized duplicate email, anonymous completion-state modification denial and stale-session denial.

Product Owner UAT additionally confirmed invalid reset-token rejection and used-token non-reuse.

### 2.6 Human technical/security review

Repository history contains the named review record for Matheus Moura dated 2026-09-03. Because subsequent UAT exposed and then corrected Staging mail-delivery issues, final closure should include a brief final Technical Lead review confirmation after the remaining Active -> Suspended UAT completes.

### 2.7 Effort / rework / defect accounting

The previously confirmed Milestone 2 human-effort baseline is 21.0h. Additional UAT correction effort occurred after that baseline and has not yet been separately confirmed by the Technical Lead, so no additional hours are fabricated here.

The fixed Milestone 2 invoice amount remains **BRL 7,200** under the Phase 0 Authorization. Submission of an invoice does not itself constitute Product Owner acceptance; payment remains conditional on acceptance.

## Defect/rework evidence retained

The evidence intentionally retains the earlier password-recovery UAT failure and SMTP timeout as historical defects. They are now marked corrected/validated in the defect and rework logs rather than removed from history.

Relevant correction path included visible reset confirmation, Brevo Staging SMTP configuration, business-controlled sender configuration, synchronous delivery in the single Render web process, and stdout runtime diagnostics. Product Owner end-to-end password-recovery UAT now passes.

## Phase 0 boundaries

All work remains limited to business-controlled non-Production Staging. No Production deployment, real member Production data, live payment, live identity verification, MFA or broader full-MVP capability is authorized by this evidence record.

## Resubmission status

PR #4 must remain **unmerged**. Milestone 2 remains **UNDER PRODUCT OWNER REVIEW / NOT YET ACCEPTED** until Michael Fitzgerald completes the remaining Active-member/stale-session test and explicitly confirms acceptance. Dependent Milestone 3 work must not begin based on this document alone.
