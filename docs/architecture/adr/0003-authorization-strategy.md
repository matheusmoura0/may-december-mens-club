# ADR 0003: Authoritative Server-Side Authorization

- Status: Accepted for Phase 0
- Date: 2026-08-28

## Context

Phase 0 must validate a higher-risk account-state authorization slice. Authorization decisions must not rely on UI visibility, client-side state, or controller conventions alone.

## Decision

All restricted member-facing actions in the pilot will be enforced on the server against authoritative persisted account/membership state.

Authorization rules will be centralized behind explicit policy objects or equivalent domain authorization boundaries. Controllers and views may consume those decisions, but the server-side policy remains authoritative.

## Testing requirements

Every protected behavior added during Phase 0 must include:

- Positive coverage proving an eligible account can perform the action.
- Negative coverage proving an ineligible account cannot perform the action.
- A direct request-level or integration-level assertion demonstrating that hiding a UI control is not the security boundary.

## Consequences

- Authorization behavior is reviewable and testable.
- UI and authorization concerns remain separate.
- New account states can be incorporated through explicit policy changes rather than scattered conditionals.
