# NodeAxe architecture

NodeAxe explores self-hosted Bitcoin infrastructure and open-source miner monitoring.

## Reference deployment (development, not an installation guide)

```text
HOME network                              OFFICE network
Bitcoin Core (mainnet)                    Quantus GPU miner
  ├─ local solo Stratum pool                ├─ local Bitaxe / NerdQAxe miners
  ├─ HOME Bitaxe miners                     ├─ Avalon miner
  └─ HOME telemetry API                     └─ NodeAxe Command Center
                └── private overlay network ──┘
```

The Command Center combines remote HOME telemetry with OFFICE mining metrics. The mining pool and Bitcoin Core remain independent of the dashboard. A dashboard failure should not interrupt mining.

## Design boundaries

- Bitcoin Core RPC and sensitive services remain local-only.
- Miner configuration changes require deliberate operator approval.
- Remote connectivity should use authenticated, encrypted access.
- Device inventory should use stable hardware identities rather than IP addresses alone.
- Keep production and development configurations separate.
- Never commit real wallet secrets, RPC credentials, private network inventories, or host-specific configuration.

## Status

This document describes the project architecture at a high level. It is not a claim that the public repository contains a complete deployable implementation. Production dashboard source is not yet published.
