# Phase 0 Defect Log

Track defects discovered during implementation, Staging validation, CI, and Product Owner review/UAT.

## Milestone 1 closure

No material product, security, authorization, or data-integrity defects were recorded for Milestone 1 — Foundation.

## Milestone 2

| ID | Date | Area | Description | Severity | Found by | Resolution / current state | Rework / defect accounting |
|---|---|---|---|---|---|---|---|
| M2-01 | 2026-09-01 | Staging deployment | Render returned HTTP 500 because Puma started before the new database migration was prepared/applied. | High | Staging validation | Startup changed to `bundle exec rails db:prepare && bundle exec puma`; Staging subsequently loaded. | Included in prior aggregate M2 defect effort. |
| M2-02 | 2026-09-02 | Scope completeness | Initial M2 implementation omitted guided registration save/resume and password-recovery foundation. | High | Scope review | Authorized missing scope implemented/tested/deployed. | Included in prior aggregate M2 rework. |
| M2-03 | 2026-09-02 | Authorization proof | Tests did not explicitly prove an already-authenticated Active member is denied after authoritative state changes to Suspended. | High | Product Owner review | Integration proof added; coordinated Product Owner Staging stale-session test remains pending. | Prior M2 acceptance-review rework. |
| M2-04 | 2026-09-02 | Password recovery security | Reset URL used request host/protocol instead of controlled canonical URL. | High | Product Owner review | Reset links use `APP_BASE_URL`; Staging canonical URL configured. | Prior M2 acceptance-review rework. |
| M2-05 | 2026-09-02 | Mail configuration | Default sender used incorrect project domain. | Medium | Product Owner review | Sender configuration corrected; later updated for business-controlled Brevo verified sender. | Prior M2 acceptance-review rework. |
| M2-06 | 2026-09-02 | Authentication | Explicit application-level minimum password length missing. | Medium | Product Owner review | 12-character validation and tests added; Product Owner UAT passed. | Prior M2 acceptance-review rework. |
| M2-07 | 2026-09-02 | Failure paths | Negative/failure coverage incomplete. | Medium | Product Owner review | Required integration coverage added. | Prior M2 acceptance-review rework. |
| M2-08 | 2026-09-02 | CI test environment | Canonical reset-link test attempted SMTP delivery to localhost:25. | Medium | CI | Test environment isolated with Action Mailer test delivery. | Included in prior aggregate M2 defect effort. |
| M2-09 | 2026-09-03 | Password recovery UX | Password-reset request redirected to Sign In but the generic success/confirmation notice was not rendered, preventing Product Owner confirmation that the request had been accepted. | Medium | Product Owner UAT | Sign-in view updated to render the notice. Product Owner subsequently observed the generic confirmation. | Additional UAT correction effort; human time not yet confirmed. |
| M2-10 | 2026-09-03 | Staging email delivery | Password-reset recovery email did not reach the recipient and Brevo showed no transaction. Initial Staging mail path/configuration did not successfully exercise business-controlled SMTP delivery. | High | Product Owner UAT | Rails configured to consume Staging SMTP variables and verified sender; delivery changed to synchronous for the single web service; stdout logging enabled. Latest runtime attempt reaches mail delivery but fails with `Net::OpenTimeout` before Brevo receives a transaction. **Open blocker.** | Additional UAT correction effort; human time not yet confirmed. |

## Current blocker

Milestone 2 remains **UAT INCOMPLETE / NOT ACCEPTED**. The latest observed reset request reaches `PasswordResetsController#create` and fails at outbound SMTP connection opening with `Net::OpenTimeout (execution expired)` after approximately five seconds. Normal sign-in/registration/navigation requests in the same runtime log complete successfully. The SMTP endpoint/port connectivity must be corrected/verified and full Product Owner password-recovery UAT repeated before closure.

The previously confirmed M2 effort baseline was 21.0h (including 1.0h defect correction and 2.0h rework). Work on M2-09/M2-10 occurred after that baseline; no additional human time is assigned here until confirmed by the Technical Lead.

## Severity guide

- Critical: security, authorization bypass, or data-integrity risk.
- High: core pilot flow cannot be completed reliably or required security proof is materially absent.
- Medium: incorrect/incomplete behavior or evidence with a practical correction path.
- Low: minor issue that does not materially affect the pilot outcome.
