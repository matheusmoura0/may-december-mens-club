# Phase 0 Milestone 2 Evidence

## Milestone and acceptance status

Milestone 2 - Accepted Pilot Slices.

**Product Owner acceptance status: ACCEPTED on 2026-09-04.** Michael Fitzgerald provided final Milestone 2 acceptance after completion of the final evidence package and all hands-on UAT. PR #4 may now be merged in accordance with the Phase 0 process.

## Product Owner UAT - 2026-09-03

Product Owner Michael Fitzgerald completed hands-on non-Production Staging UAT after the final corrections.

### Confirmed passed

- Minimum password length rejects passwords shorter than 12 characters.
- Registration Step 1 persists valid credentials and creates a Pending account.
- Incomplete registration survives sign-out/sign-in and resumes at Step 2.
- Registration completion persists while membership remains Pending.
- Completed registration remains complete after a new sign-in.
- Normalized duplicate email is rejected.
- Wrong-password and nonexistent-email sign-in paths use generic behavior.
- Password-reset request for a nonexistent email does not disclose account existence.
- Password-reset request is accepted and returns the non-enumerating confirmation message.
- Recovery email is successfully transmitted through Brevo and received.
- Recovery link uses the canonical Staging host `may-december-staging.onrender.com`.
- A valid reset token opens the password-change form.
- A new password is successfully accepted.
- Authentication succeeds with the new password.
- A fabricated/invalid reset token is rejected.
- A previously used reset token cannot be reused.
- Pending-member authorization is enforced: direct `/members/dashboard` access is denied.
- Active-member authorization is enforced: the Active UAT account signs in and can access `/members/dashboard`.
- Stale-session authorization is enforced: with the same authenticated browser session retained, the authoritative account state was changed Active -> Suspended; the next `/members/dashboard` request was immediately denied and the application showed membership status Suspended.

**No Product Owner UAT scenarios remain.**

## Mandatory acceptance requirement mapping

### 2.1 Stale-state authorization enforcement

Automated proof exists in `test/integration/registration_authorization_test.rb` via `active session is denied after authoritative account state changes to suspended`.

Evidence status: **Automated passed + Product Owner coordinated Staging UAT passed.** The Product Owner retained the same authenticated session across the authoritative Active -> Suspended transition and observed immediate denial on the next restricted request.

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

Automated coverage includes invalid/expired reset token, invalid sign-in without session creation, normalized duplicate email, anonymous completion-state modification denial and stale-session denial. Product Owner UAT independently confirmed invalid reset-token rejection, used-token non-reuse, non-enumerating recovery handling and authorization denial paths.

### 2.6 Named Technical Lead / security review

**Final review confirmation - Matheus Moura, Technical Lead / Reviewer, 2026-09-03:** Following all Milestone 2 corrections and completed Product Owner UAT, I reviewed the final Milestone 2 implementation/evidence package for correctness, maintainability, security-sensitive authentication/password-recovery behavior, authoritative account-state authorization, architectural consistency with the approved Phase 0 slice, and non-Production Staging behavior. The identified Milestone 2 defects/corrections are represented in the retained defect/rework history. I confirmed the package was ready for Product Owner acceptance review.

### 2.7 Effort / rework / defect accounting

The previously confirmed Milestone 2 human-effort baseline was **21.0h**, including **2.0h rework** and **1.0h defect correction** within that baseline.

Matheus Moura confirmed an additional **3.0h of human work** after the baseline for the Product Owner UAT correction cycle, including password-recovery/SMTP diagnosis and correction plus final Staging/UAT support. Final actual Milestone 2 human effort is **24.0h**.

Total correction/rework-related effort identifiable from the confirmed accounting is **6.0h**, or **25.0% of the final 24.0h human effort**. This is an effort measure, not a source-line rewrite percentage.

The fixed Milestone 2 invoice amount remains **BRL 7,200** under the Phase 0 Authorization. With Product Owner acceptance now recorded, the accepted Milestone 2 invoice is payable under the agreement process.

## Defect/rework evidence retained

Historical password-recovery UX and SMTP-delivery failures remain in the defect/rework logs. They were corrected and subsequently passed Product Owner end-to-end UAT rather than being removed from history.

The correction path included visible reset confirmation, business-controlled Brevo Staging SMTP/sender configuration, synchronous delivery in the single Render web process, and stdout runtime diagnostics.

## Final correction head and CI

Verified correction/evidence head before final documentation closure: `47fb1c953616019adeed7788a70270ec59ccc409`, with GitHub Actions CI run **#150** (`33820896074`) successful.

The later final package head `f3771811b80a13718521692ab13540630a43cc98`, which includes the final effort-log reconciliation, also completed successfully on GitHub Actions CI run **#158**.

## Phase 0 boundaries

All work remains limited to business-controlled non-Production Staging. No Production deployment, real member Production data, live payment, live identity verification, MFA or broader full-MVP capability is authorized by this evidence record.

## Acceptance closure

Milestone 2 Product Owner UAT is **COMPLETE / PASSED** and the final evidence package is **ACCEPTED by Product Owner Michael Fitzgerald on 2026-09-04**.

PR #4 may be merged. Milestone 3 - Evidence & Recommendation is the next authorized Phase 0 milestone. Milestone 3 must remain within the approved Phase 0 scope and must be fully Technical Lead tested/UAT-validated in non-Production Staging before submission for Product Owner acceptance.
