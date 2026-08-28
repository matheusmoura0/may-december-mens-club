# ADR 0002: PostgreSQL as the Primary Database

- Status: Accepted for Phase 0
- Date: 2026-08-28

## Context

The pilot requires relational consistency across registration, membership/account state, authorization-relevant data, and audit-friendly evidence. The application may later need geospatial capabilities, but Phase 0 should keep the database choice simple and production-capable.

## Decision

Use PostgreSQL as the primary relational database for development, test, and non-production staging.

## Consequences

- Strong transactional guarantees for state changes.
- Mature Rails support.
- Straightforward CI and staging parity.
- Future PostGIS adoption remains available if validated by product requirements.
