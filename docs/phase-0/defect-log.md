# Phase 0 Defect Log

Track defects discovered during implementation, Staging validation, CI, and review.

## Milestone 1 closure

No material product, security, authorization, or data-integrity defects were recorded for Milestone 1 — Foundation.

The initial Render deployment failure caused by the absence of a committed `Gemfile.lock` was a deployment/reproducibility configuration issue discovered during Staging setup. It was corrected by generating and committing the Bundler lockfile, after which the Render build and deployment completed successfully. It did not result in a material product defect or change the approved Milestone 1 scope.

## Milestone 2

| ID | Date | Area | Description | Severity | Found by | Resolution | Rework / defect accounting |
|---|---|---|---|---|---|---|---|
| M2-01 | 2026-09-01 | Staging deployment | Render returned HTTP 500 because the service started Puma before preparing/applying the newly introduced database migration. | High | Staging validation | Startup changed to `bundle exec rails db:prepare && bundle exec puma`; Staging subsequently loaded successfully. | Included in aggregate M2 defect-correction effort. |
| M2-02 | 2026-09-02 | Scope completeness | First M2 implementation omitted guided registration save/resume and the password-recovery foundation required by the approved Phase 0 direction. | High | Scope-completeness review | Missing authorized scope implemented, tested, integrated, deployed and manually validated. | Included in aggregate 2.0h M2 rework. |
| M2-03 | 2026-09-02 | Authorization proof | Automated tests did not explicitly prove an already-authenticated Active member is denied after authoritative account state changes to Suspended. | High | Product Owner review | Added integration test preserving the session across Active → Suspended transition and directly re-requesting the restricted route. | Included in M2 acceptance-review rework. |
| M2-04 | 2026-09-02 | Password recovery security | Reset URL was constructed from request host/protocol instead of a controlled canonical application URL. | High | Product Owner review | Reset links now use explicit environment-based `APP_BASE_URL`; Staging is configured with the approved business-controlled Staging URL. | Included in M2 acceptance-review rework. |
| M2-05 | 2026-09-02 | Mail configuration | Default sender used `no-reply@maydecember.club` instead of the controlled project domain. | Medium | Product Owner review | Default corrected to `no-reply@maydecemberclub.com`; no live provider activation introduced. | Included in M2 acceptance-review rework. |
| M2-06 | 2026-09-02 | Authentication foundation | Application-level minimum password length was not explicitly validated. | Medium | Product Owner review | Added 12-character minimum validation plus automated rejected/accepted password coverage. | Included in M2 acceptance-review rework. |
| M2-07 | 2026-09-02 | Failure-path coverage | Negative/failure coverage was incomplete for invalid/expired reset tokens, invalid sign-in, duplicate normalized email and anonymous registration completion update. | Medium | Product Owner review | Required integration coverage added. | Included in M2 acceptance-review rework. |
| M2-08 | 2026-09-02 | CI test environment | Canonical password-reset URL test attempted SMTP delivery to `localhost:25`, causing the test job to error while lint/security remained green. | Medium | GitHub Actions CI | Test environment configured with `delivery_method = :test` and deliveries enabled locally, avoiding external SMTP. | Included in aggregate M2 defect-correction effort. |

Milestone 2 defect correction totals **1.0h** in the Technical Lead-confirmed effort accounting. Rework is separately recorded as **2.0h**. Per-defect elapsed times were not separately reconstructed and are intentionally not fabricated.

## Severity guide

- Critical: security, authorization bypass, or data integrity risk.
- High: core pilot flow cannot be completed reliably or required security proof is materially absent.
- Medium: incorrect/incomplete behavior or evidence with a practical correction path.
- Low: minor issue that does not materially affect the pilot outcome.
