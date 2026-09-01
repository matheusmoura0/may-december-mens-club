# Development Standards

## Branching

- `main` is the integration baseline.
- Phase 0 work is developed in short-lived branches and merged through pull requests.
- Branch names should describe the milestone or work item.

## Pull requests

- Keep changes focused and reviewable.
- Include tests for behavior changes.
- Document architecture-impacting decisions through ADRs.
- Do not merge with failing CI.

## Rails conventions

- Prefer Rails conventions before introducing custom abstractions.
- Keep controllers thin and move business rules to explicit domain/service/policy objects when controller/model callbacks would hide behavior.
- Avoid authorization checks scattered across views or controllers; use the documented authorization boundary.
- Database changes must be expressed as reversible migrations whenever practical.

## AI-assisted implementation

AI-generated or AI-assisted output must be reviewed by a human before acceptance. Phase 0 work must record implementation, supervision/review, rework, testing, and material rewrites in the Phase 0 logs.

## Scope control

Do not add production deployments, paid external services, unrelated product features, or material architecture changes as part of Phase 0 without explicit approval.
