# Security Standards

## Secrets

- Never commit passwords, API tokens, credentials, or production secrets.
- Use Rails encrypted credentials or environment variables as appropriate.

## Authorization

- Authorization is enforced server-side against persisted authoritative state.
- Client-side visibility is not an authorization boundary.
- Restricted actions require explicit policy coverage and negative tests.

## Dependencies

- Dependency changes must be reviewed.
- CI should run dependency and static security checks once the Rails application foundation is generated.

## Environments

- Phase 0 work is non-production only.
- Staging credentials and data must remain isolated from production systems.
