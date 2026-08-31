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

## CI evidence

The latest GitHub Actions run for the foundation branch completed successfully with all three required jobs passing:

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

## Review vehicle

Pull Request #1: `Milestone 1: Rails foundation and engineering controls`

Base: `main`

Head: `phase-0/milestone-1-foundation`

## Administrative completion status

The technical implementation for Milestone 1 is complete. Administrative closure
status:

1. Repository ownership transfer: completed. The authoritative repository is now `may-december-club/may-december-mens-club`.
2. Branch protection/ruleset: completed. The active `Protect main` ruleset requires pull-request based changes and successful required CI checks.
3. Business-owned cloud/Staging: awaiting Product Owner / business account setup confirmation. No Staging deployment configuration is present in this repository. The intended non-Production Staging proposal discussed is Render, using one non-Production Rails Web Service and one PostgreSQL database under a business-owned May December Club account/workspace. Michael / May December Club still needs to confirm the provider/account, what account/access setup is needed, and that May December Club retains administrative ownership/control.
4. Actual human effort log: completed with Technical Lead-supplied effort ranges in `docs/phase-0/effort-log.md`.

No Production deployment is included in this evidence package.
