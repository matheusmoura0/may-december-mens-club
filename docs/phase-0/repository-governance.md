# Phase 0 Repository Governance

This document records the repository ownership, branch governance controls, and business-controlled non-Production Staging for Phase 0.

## Authoritative repository

Repository: `may-december-club/may-december-mens-club`

The repository was transferred intact from
`matheusmoura0/may-december-mens-club` to
`may-december-club/may-december-mens-club`. Repository branches, history, pull
requests, GitHub Actions workflow history, and evidence were preserved during
the transfer.

Michael Fitzgerald / May December Club retains business administrative ownership and control of the repository. Matheus Moura has the developer/repository access required to perform the approved Phase 0 work.

## Main branch ruleset

Ruleset name: `Protect main`

- Target: default branch / `main`
- Enforcement: active
- Pull requests required
- One approval required
- Stale approvals dismissed when new commits are pushed
- Review conversations must be resolved
- Required status checks: `test`, `lint`, `security`
- Branch must be up to date before merge
- Branch deletion blocked
- Non-fast-forward / force pushes blocked
- Bypass actors: none

These controls satisfy the Milestone 1 branch governance requirement that
normal changes to `main` require pull requests and passing CI.

## Cloud and Staging ownership

Business-controlled non-Production Staging is configured in the May December Club Render workspace.

Configured Phase 0 Staging resources:

- Provider: Render
- Workspace: May December Club
- Rails Web Service: `may-december-staging`
- PostgreSQL service: `may-december-staging-db`
- PostgreSQL database: `may_december_staging`
- Region: Oregon (US West)
- Web Service compute at setup: Free ($0/month)
- PostgreSQL plan at setup: Free
- Source repository: `may-december-club/may-december-mens-club`
- Deployment branch at Milestone 1 closure: `phase-0/milestone-1-foundation`
- Public Staging URL: `https://may-december-staging.onrender.com`
- Environment purpose: non-Production Phase 0 Staging only

The Staging build completed successfully, Puma booted on Ruby 3.3.8, Render reported the service live, and the application and `/up` health endpoint were manually verified as operational.

No Render credentials, database passwords, secret keys, or private database URLs are stored in this repository. Environment secrets remain managed through the Render environment configuration.

No paid infrastructure upgrade or Production deployment is included in this Milestone 1 closure. Production deployment remains out of scope unless separately approved in writing by the Product Owner.
