# Phase 0 Milestone 3 — Technical Lead Staging UAT

## Status

**NOT YET EXECUTED / NOT READY FOR PRODUCT OWNER SUBMISSION.**

This checklist is the mandatory Technical Lead end-to-end UAT gate requested for Milestone 3. Results must be executed directly against the business-controlled non-Production Staging environment and recorded as actual PASS/FAIL observations. Automated-test success alone does not satisfy this gate.

Staging target: `https://may-december-staging.onrender.com`

## Execution rules

- Use synthetic UAT accounts only.
- Do not use real Production member data.
- Record actual observed outcome for every scenario.
- Preserve failures in the defect/rework logs; do not erase failed first attempts after correction.
- Any failed required scenario blocks Milestone 3 submission until corrected and retested.
- Retain the same browser session where the scenario explicitly requires stale-session verification.
- Do not record passwords, SMTP secrets, reset tokens, or other credentials in this document.

## Successful workflows

| ID | Scenario | Expected result | Actual result | Evidence / notes |
|---|---|---|---|---|
| M3-UAT-01 | Registration Step 1 with valid unique email and >=12-character password | User created as Pending; browser proceeds to registration continuation | NOT RUN | |
| M3-UAT-02 | Save/resume registration across sign-out/sign-in | Incomplete registration persists; sign-in returns user to registration continuation | NOT RUN | |
| M3-UAT-03 | Complete registration while Pending | Completion persists; membership remains Pending | NOT RUN | |
| M3-UAT-04 | Sign in with valid credentials | Authentication succeeds; session is established | NOT RUN | |
| M3-UAT-05 | Request password recovery for existing synthetic account | Generic confirmation shown; recovery email is delivered through configured Staging mail path | NOT RUN | |
| M3-UAT-06 | Open valid recovery link | Link uses canonical Staging host and opens password-change form | NOT RUN | |
| M3-UAT-07 | Change password with valid reset token | Password update succeeds; new password authenticates | NOT RUN | |
| M3-UAT-08 | Active member accesses `/members/dashboard` | Restricted dashboard returns successfully | NOT RUN | |

## Failure / negative workflows

| ID | Scenario | Expected result | Actual result | Evidence / notes |
|---|---|---|---|---|
| M3-UAT-09 | Registration with password shorter than 12 characters | Registration rejected with validation feedback; no valid account created | NOT RUN | |
| M3-UAT-10 | Register normalized duplicate email | Duplicate rejected | NOT RUN | |
| M3-UAT-11 | Sign in with wrong password | Generic invalid-credentials behavior; no authenticated restricted access | NOT RUN | |
| M3-UAT-12 | Sign in with nonexistent email | Same generic invalid-credentials behavior; no authenticated restricted access | NOT RUN | |
| M3-UAT-13 | Request password recovery for nonexistent email | Same generic visible confirmation; no account-existence disclosure in visible response | NOT RUN | |
| M3-UAT-14 | Use fabricated/invalid reset token | Token rejected; password not changed | NOT RUN | |
| M3-UAT-15 | Reuse a previously consumed reset token | Token rejected | NOT RUN | |
| M3-UAT-16 | Anonymous user accesses `/members/dashboard` | Redirected to sign in / restricted access denied | NOT RUN | |
| M3-UAT-17 | Pending member accesses `/members/dashboard` | Restricted access denied | NOT RUN | |
| M3-UAT-18 | Suspended member accesses `/members/dashboard` | Restricted access denied | NOT RUN | |
| M3-UAT-19 | Same authenticated session: Active -> Suspended, then request `/members/dashboard` again | Initial Active access succeeds; after authoritative transition, next request is immediately denied without signing out/in | NOT RUN | |

## Additional Technical Lead observations

Record any unexpected response, redirect, latency issue, delivery problem, state inconsistency, authorization anomaly, or confusing UX encountered while executing the checklist, even if the required expected result ultimately passes.

## Completion statement

Do not sign this section until all required scenarios have been executed.

Technical Lead: Matheus Moura

Final result: **PENDING**

Submission decision: **BLOCKED until all scenarios above are executed and all required results pass.**
