# NodeAxe roadmap

This roadmap is directional; features are not promises of release.

## Phase 1 — Repository foundations
- [ ] Replace placeholder documentation with project overview.
- [ ] Establish security and contribution processes.
- [ ] Audit and retire the legacy setup script before recommending installation.
- [ ] Decide license(s) after reviewing upstream dependencies and hardware assets.

## Phase 2 — Command Center source control
- [ ] Audit existing dashboard source and configuration for sensitive data.
- [ ] Import a sanitized development copy into a private repository.
- [ ] Add tests for HOME/ OFFICE telemetry aggregation and stale data.
- [ ] Separate application configuration from code.

## Phase 3 — Miner fleet management
- [ ] Discover AxeOS devices safely within approved LAN subnets.
- [ ] Persist miner identity across IP changes.
- [ ] Store per-miner historical telemetry.
- [ ] Display actual pool destination and fallback state dynamically.
- [ ] Add thermal and efficiency diagnostics.

## Phase 4 — Carefully reviewed open-source releases
- [ ] Publish installation instructions and verified test results.
- [ ] Add CI, versioning, and changelogs.
- [ ] Review third-party licenses and attribution before reusing code.
- [ ] Evaluate optional pooled-mining research separately from production solo mining.
