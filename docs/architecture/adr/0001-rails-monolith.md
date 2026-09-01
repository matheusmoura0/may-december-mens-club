# ADR 0001: Rails Monolith for Phase 0

- Status: Accepted for Phase 0
- Date: 2026-08-28

## Context

Phase 0 is intended to validate delivery quality, authorization behavior, testability, and implementation efficiency with a controlled non-production slice. The pilot does not require independent deployable services.

## Decision

Use a single Ruby on Rails application as the application boundary for Phase 0. Keep domain behavior modular inside the monolith and avoid introducing service decomposition unless evidence from the pilot demonstrates a concrete need.

## Consequences

### Positive

- Lower operational complexity during the pilot.
- Faster end-to-end implementation and review.
- Easier transactional consistency for account and membership state.
- Simpler automated integration coverage.

### Trade-offs

- Internal boundaries must be kept explicit to avoid a tightly coupled codebase.
- Future extraction of services, if required, must be driven by measured operational or organizational needs rather than by the Phase 0 architecture itself.
