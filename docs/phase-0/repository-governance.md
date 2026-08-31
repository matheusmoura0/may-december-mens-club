# Phase 0 Repository Governance

This document records the repository ownership and branch governance controls
for Phase 0.

## Authoritative repository

Repository: `may-december-club/may-december-mens-club`

The repository was transferred intact from
`matheusmoura0/may-december-mens-club` to
`may-december-club/may-december-mens-club`. Repository branches, history, pull
requests, GitHub Actions workflow history, and evidence were preserved during
the transfer.

Michael Fitzgerald / May December Club must retain administrative ownership and
control of the repository.

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

No Staging deployment configuration is currently present in this repository.

The intended non-Production Staging proposal discussed is Render, using one
Rails Web Service and one PostgreSQL database under a business-owned May
December Club account/workspace. Render is not documented here as configured.

Before Staging is used for Phase 0, the Product Owner / business owner should
confirm:

- the intended Staging provider and account/workspace;
- what infrastructure is already configured, if any;
- what account or access setup is still needed from Michael Fitzgerald;
- that May December Club retains administrative ownership/control;
- that Matheus has only the developer-level access needed for deployment; and
- that the environment is non-Production.

Production deployment is out of scope for Milestone 1 and Phase 0 closure unless
separately approved in writing by the Product Owner.
