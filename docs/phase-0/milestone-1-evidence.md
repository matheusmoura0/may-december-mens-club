# Milestone 1 Evidence — Foundation

Date: 2026-08-28

Repository: `may-december-club/may-december-mens-club`

## Scope covered

This document records the controlled evidence package assembled for Phase 0 Milestone 1 — Foundation.

Implemented and committed on `phase-0/milestone-1-foundation`:

- Rails 8.1 application foundation
- PostgreSQL configuration
- Architecture Decision Records for Rails monolith, PostgreSQL, and authorization strategy
- Development, testing, and security engineering standards
- Phase 0 effort, defect, and rework logs
- GitHub Actions CI
- Automated test job
- RuboCop / Rails Omakase lint job
- Brakeman security scan
- Bundler Audit dependency audit
- Dependabot configuration
- Active Storage local/test configuration
- Reproducible dependency resolution through committed `Gemfile.lock`

## CI evidence

The recorded Milestone 1 GitHub Actions evidence completed successfully with all three required jobs passing:

- test: passed
- lint: passed
- security: passed

Workflow run: `33189384487`

The workflow history was preserved after transfer of the repository from
`matheusmoura0/may-december-mens-club` to
`may-december-club/may-december-mens-club`.

Closure-documentation corrections committed after this recorded run are also required to pass the protected-branch CI checks before Product Owner approval and merge.

## Repository ownership and governance

The repository was transferred intact to the business-owned GitHub organization:
`may-december-club/may-december-mens-club`.

The active repository ruleset `Protect main` applies to the default branch
(`main`) and requires normal changes to go through pull requests with required
CI checks before merge.

Documented governance evidence:

- Repository transfer to `may-december-club/may-december-mens-club`: completed.
- `Protect main` ruleset: completed.
- Pull requests required for `main`: completed.
- One approval required before merge.
- Required CI contexts for `main`: `test`, `lint`, and `security`.
- Branch must be up to date before merge.
- Branch deletion and non-fast-forward/force pushes blocked.
- No bypass actors configured.

## Non-Production Staging

Business-controlled non-Production Staging has been established in the May December Club Render workspace.

Staging components:

- Provider: Render.
- Workspace: May December Club.
- Rails Web Service: `may-december-staging`.
- PostgreSQL service: `may-december-staging-db`.
- PostgreSQL database: `may_december_staging`.
- Region: Oregon (US West).
- Web Service compute at setup: Free ($0/month).
- PostgreSQL plan at setup: Free.
- Staging URL: `https://may-december-staging.onrender.com`.
- Source repository: `may-december-club/may-december-mens-club`.
- Deployment branch at Milestone 1 closure: `phase-0/milestone-1-foundation`.

The initial Staging deployment completed successfully: dependencies were installed from the committed lockfile, the build completed successfully, Puma booted on Ruby 3.3.8, Render reported the service live, and the application and `/up` health endpoint were manually confirmed operational.

No Render credentials, database passwords, secret keys, or private database URLs are stored in the repository. This environment is for Phase 0 non-Production Staging only. No Production deployment is included in this evidence package.

## Defect and rework records

No material product, security, authorization, or data-integrity defects were recorded for Milestone 1 — Foundation.

No material rewrite or material implementation rework was recorded for Milestone 1. Limited closure/documentation reconciliation and the Staging deployment reproducibility correction were performed. The initial Render deployment required a committed `Gemfile.lock`; after the lockfile was generated and committed, the deployment succeeded. This was limited configuration/reproducibility rework and not a material rewrite of the Milestone 1 implementation.

The detailed records are maintained in:

- `docs/phase-0/defect-log.md`
- `docs/phase-0/rework-log.md`
- `docs/phase-0/effort-log.md`

## Review vehicle

Pull Request #1: `Milestone 1: Rails foundation and engineering controls`

Base: `main`

Head: `phase-0/milestone-1-foundation`

PR #1 remains open and must not be merged until Product Owner approval is provided.

## Administrative completion status

The Milestone 1 implementation and administrative closure items are complete and submitted for Product Owner final acceptance review:

1. Repository ownership transfer: completed. The authoritative repository is `may-december-club/may-december-mens-club`.
2. Branch protection/ruleset: completed. The active `Protect main` ruleset requires pull-request based changes, approval, and successful required CI checks.
3. Business-owned cloud/Staging: completed. Non-Production Rails and PostgreSQL Staging services are established in the May December Club Render workspace and the application is operational.
4. Actual human effort log: completed with Technical Lead-supplied effort ranges in `docs/phase-0/effort-log.md`.
5. Defect and rework records: completed, with no material defects or material rewrites recorded for Milestone 1.

Milestone 1 is ready for final Product Owner acceptance review but is not yet formally accepted. Submission of this evidence package does not itself constitute acceptance.

Under the Phase 0 Authorization, Milestone 1 — Foundation is BRL 5,400. The invoice follows completion and submission of the Milestone 1 deliverables; payment is due only after the Product Owner confirms the applicable deliverables have been received and accepted.

Milestone 2 must not begin until Milestone 1 is formally accepted.
