# Phase 0 Defect Log

Track defects discovered during implementation, Staging validation, CI, and Product Owner review/UAT.

## Milestone 1 closure

No material product, security, authorization, or data-integrity defects were recorded for Milestone 1 - Foundation.

## Milestone 2

| ID | Date | Area | Description | Severity | Found by | Resolution / current state | Rework / defect accounting |
|---|---|---|---|---|---|---|---|
| M2-01 | 2026-09-01 | Staging deployment | Render returned HTTP 500 because Puma started before the new database migration was prepared/applied. | High | Staging validation | Startup changed to `bundle exec rails db:prepare && bundle exec puma`; Staging subsequently loaded. | Included in prior aggregate M2 defect effort. |
| M2-02 | 2026-09-02 | Scope completeness | Initial M2 implementation omitted guided registration save/resume and password-recovery foundation. | High | Scope review | Authorized missing scope implemented/tested/deployed. | Included in prior aggregate M2 rework. |
| M2-03 | 2026-09-02 | Authorization proof | Tests did not explicitly prove an already-authenticated Active member is denied after authoritative state changes to Suspended. | High | Product Owner review | Integration proof added; Product Owner coordinated same-session Active -> Suspended Staging UAT passed with immediate denial. **Closed.** | Prior M2 acceptance-review rework. |
| M2-04 | 2026-09-02 | Password recovery security | Reset URL used request host/protocol instead of controlled canonical URL. | High | Product Owner review | Reset links use `APP_BASE_URL`; Product Owner UAT confirmed canonical Staging URL. **Closed.** | Prior M2 acceptance-review rework. |
| M2-05 | 2026-09-02 | Mail configuration | Sender configuration did not match the business-controlled Staging sender setup. | Medium | Product Owner review | Corrected to business-controlled Brevo verified sender under `mail.maydecemberclub.com`; Product Owner end-to-end UAT passed. **Closed.** | Prior M2 acceptance-review rework plus post-baseline UAT correction cycle. |
| M2-06 | 2026-09-02 | Authentication | Explicit application-level minimum password length missing. | Medium | Product Owner review | 12-character validation and tests added; Product Owner UAT passed. **Closed.** | Prior M2 acceptance-review rework. |
| M2-07 | 2026-09-02 | Failure paths | Negative/failure coverage incomplete. | Medium | Product Owner review | Required integration coverage added; invalid and used reset tokens also passed Product Owner UAT. **Closed.** | Prior M2 acceptance-review rework. |
| M2-08 | 2026-09-02 | CI test environment | Canonical reset-link test attempted SMTP delivery to localhost:25. | Medium | CI | Test environment isolated with Action Mailer test delivery. **Closed.** | Included in prior aggregate M2 defect effort. |
| M2-09 | 2026-09-03 | Password recovery UX | Password-reset request redirected to Sign In but the generic success/confirmation notice was not rendered. | Medium | Product Owner UAT | Sign-in view updated to render the non-enumerating notice; Product Owner retest passed. **Closed.** | Included in confirmed 3.0h post-baseline UAT correction cycle. |
| M2-10 | 2026-09-03 | Staging email delivery | Password-reset recovery email initially did not reach the recipient and Brevo showed no transaction; synchronous diagnostics later surfaced `Net::OpenTimeout` opening the SMTP connection. | High | Product Owner UAT / runtime diagnostics | Staging SMTP connectivity/configuration corrected. Product Owner confirmed Brevo transmission and receipt, canonical link, valid password reset, new-password authentication, invalid-token rejection and used-token non-reuse. **Closed by Product Owner UAT.** | Included in confirmed 3.0h post-baseline UAT correction cycle. |

## Final UAT / acceptance state

All Product Owner hands-on Milestone 2 UAT scenarios completed and passed, including the final same-session Active -> Suspended authorization test. No known Milestone 2 UAT blocker remained at acceptance.

Milestone 2 was explicitly **ACCEPTED by Product Owner Michael Fitzgerald on 2026-09-04**, PR #4 was subsequently merged to `main`, and Matheus Moura confirmed the Milestone 2 payment was received on 2026-09-04.

## Final effort accounting

The previously confirmed M2 human-effort baseline was **21.0h**, including **2.0h rework** and **1.0h defect correction**. Matheus Moura confirmed an additional **3.0h human work** for the post-baseline password-recovery/SMTP correction and final UAT support cycle.

Final actual M2 human effort: **24.0h**.

Confirmed correction/rework-related effort identifiable from the aggregate accounting: **6.0h / 24.0h = 25.0%**, consisting of the prior 3.0h aggregate rework/defect correction plus the 3.0h post-baseline UAT correction cycle. No unsupported per-defect time split is invented.

## Milestone 3 review state

Milestone 3 technical review findings that are future-MVP conditions rather than defects in the authorized Phase 0 slice are recorded in `architecture-review.md`, `security-review.md`, and `code-quality-review.md`. Any actual defect discovered during Milestone 3 Technical Lead Staging UAT must be added here, corrected, retested, and reflected in actual effort/rework accounting before submission.

## Severity guide

- Critical: security, authorization bypass, or data-integrity risk.
- High: core pilot flow cannot be completed reliably or required security proof is materially absent.
- Medium: incorrect/incomplete behavior or evidence with a practical correction path.
- Low: minor issue that does not materially affect the pilot outcome.
