# Milestone 1 Evidence — Foundation

Date: 2026-08-28

Repository: `may-december-club/may-december-mens-club`

## Scope covered

This document records the evidence assembled for Phase 0 Milestone 1 — Foundation.

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

The latest recorded Milestone 1 GitHub Actions evidence completed successfully with all three required jobs passing:

- test: passed
- lint: passed
- security: passed

Workflow run: `33189384487`

The workflow history was preserved after transfer of the repository from
`matheusmoura0/may-december-mens-club` to
`may-december-club/may-december-mens-club`.

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
- Required CI contexts for `main`: `test`, `lint`, and `security`.
- Branch deletion and non-fast-forward/force pushes blocked.
- No bypass actors configured.

## Non-Production Staging

Business-controlled non-Production Staging has been established in the May December Club Render workspace.

Staging components:

- Provider: Render.
- Rails Web Service: `may-december-staging`.
- PostgreSQL database: `may-december-staging-db`.
- Region: Oregon (US West).
- Web Service compute: Free ($0/month at setup).
- Staging URL: `https://may-december-staging.onrender.com`.
- Source repository: `may-december-club/may-december-mens-club`.
- Deployment branch at setup: `phase-0/milestone-1-foundation`.

The initial Staging deployment completed successfully: dependencies were installed from the committed lockfile, the build completed successfully, Puma 8.0.2 booted on Ruby 3.3.8, Render reported the service live, and the application and `/up` health endpoint were manually confirmed operational.

This environment is for Phase 0 non-Production Staging only. No Production infrastructure is included in this evidence package.

## Review vehicle

Pull Request #1: `Milestone 1: Rails foundation and engineering controls`

Base: `main`

Head: `phase-0/milestone-1-foundation`

## Administrative completion status

The Milestone 1 implementation and administrative closure items are complete and ready for Product Owner final acceptance review:

1. Repository ownership transfer: completed. The authoritative repository is `may-december-club/may-december-mens-club`.
2. Branch protection/ruleset: completed. The active `Protect main` ruleset requires pull-request based changes and successful required CI checks.
3. Business-owned cloud/Staging: completed. Non-Production Rails and PostgreSQL Staging services are established in the May December Club Render workspace and the application is operational.
4. Actual human effort log: completed with Technical Lead-supplied effort ranges in `docs/phase-0/effort-log.md`.

Milestone 1 is ready for final acceptance review.
