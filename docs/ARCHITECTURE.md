# NodeAxe architecture

NodeAxe is a self-hosted Bitcoin infrastructure platform. Its intended default deployment places the **NodeAxe Command Center on the same Ubuntu Linux host as Bitcoin Core**, with the option to monitor miners on local and remote networks.

> **Status:** Target architecture, not a claim about the current development deployment. The Command Center currently runs on a separate monitoring host and consumes node telemetry remotely. Migration to the node host is planned, not completed.

## Recommended integrated deployment

```text
                     NODEAXE PLATFORM
                       Ubuntu host
                            |
             +--------------+--------------+
             |                             |
       Bitcoin services              Command Center
             |                             |
        Bitcoin Core                 Web dashboard
        Solo mining pool             Fleet monitoring
        Node telemetry               Device inventory
             |                             |
             +--------------+--------------+
                            |
                     Miner integrations
                            |
                  +---------+---------+
                  |                   |
             Local miners        Remote miners
             Bitaxe / ASICs      Bitaxe / ASICs
             GPU mining hosts    GPU mining hosts
                                      |
                              Secure private network
```

The Command Center is a **monitoring and management application**, not a dependency of Bitcoin Core or the mining pool. A dashboard outage must not interrupt node validation or mining.

## Optional distributed deployment

For larger or existing installations, Command Center may run on a separate Ubuntu host. Node telemetry and miner telemetry are exchanged over authenticated private network connections. The dashboard should work in both integrated and distributed configurations without changing the underlying mining services.

## Component responsibilities

| Component | Responsibility |
| --- | --- |
| Bitcoin Core | Independent full-node validation and Bitcoin RPC |
| Solo mining pool | Stratum connections and mining work distribution |
| Node telemetry | Read-only status for the node and local pool |
| Command Center | Dashboard, aggregated metrics, inventory, and history |
| Miner adapters | Device-specific collection for AxeOS/Bitaxe, ASICs, and GPU mining hosts |
| Secure networking | Optional authenticated access to remote sites and devices |

## Design principles

- **Local-first:** integrated Ubuntu installation is the preferred target.
- **Modular:** node, pool, telemetry, and dashboard are independently operable.
- **No unnecessary exposure:** Bitcoin Core RPC remains loopback-only; do not expose administrative APIs publicly.
- **Read-only by default:** explicit authentication and confirmation for any miner configuration changes.
- **Portable:** no machine names, private IPs, or location-specific assumptions in public code.
- **Stable inventory:** identify miners by persistent device identity, not IP alone.
- **Private by default:** secrets and production configuration stay outside source control.
- **Testable:** support development and staging independently of production services.

## Development status

The current implementation is a distributed prototype. The integrated Ubuntu-hosted Command Center is a design goal, and public installation instructions will follow testing and security review. Production dashboard source is not yet published in this repository.
