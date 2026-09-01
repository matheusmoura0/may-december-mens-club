# Phase 0 Defect Log

Track defects discovered during implementation and review.

## Milestone 1 closure

No material product, security, authorization, or data-integrity defects were recorded for Milestone 1 — Foundation.

The initial Render deployment failure caused by the absence of a committed `Gemfile.lock` was a deployment/reproducibility configuration issue discovered during Staging setup. It was corrected by generating and committing the Bundler lockfile, after which the Render build and deployment completed successfully. It did not result in a material product defect or change the approved Milestone 1 scope.

| ID | Date | Area | Description | Severity | Found by | Resolution | Rework time |
|---|---|---|---|---|---|---|---:|

## Severity guide

- Critical: security, authorization bypass, or data integrity risk.
- High: core pilot flow cannot be completed reliably.
- Medium: incorrect behavior with a practical workaround.
- Low: minor issue that does not materially affect the pilot outcome.
