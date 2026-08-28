# Testing Standards

## Required coverage for Phase 0

- Model/domain tests for account and membership state transitions.
- Request/integration tests for registration and pending-member flows.
- Positive and negative authorization tests for every protected pilot feature.
- Regression coverage for defects fixed during the pilot.

## Principles

- Test behavior rather than implementation details.
- Authorization tests must make real server requests when possible.
- A hidden UI element is never considered sufficient authorization evidence.
- Tests must run in CI before merge.
