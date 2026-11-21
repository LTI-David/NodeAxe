# NodeAxe architecture

NodeAxe develops self-hosted Bitcoin infrastructure, miner monitoring, and education tools. The intended integrated host product is the **NodeAxe Sovereign Node & Home Server**: a general-purpose Ubuntu-based home server that can run multiple independent applications.

The **NodeAxe Command Center** is an application hosted on that server product. It is **not part of Bitcoin Core** and must not depend on Bitcoin Core being installed or running.

> **Status:** Target product architecture, not a claim about the current deployment. The current development Command Center runs on a separate monitoring machine and receives node telemetry remotely. Moving it to the Sovereign Node & Home Server product has not yet been completed.

## Recommended product architecture

```text
           NODEAXE SOVEREIGN NODE & HOME SERVER
                    Ubuntu-based host
                            |
         +------------------+-------------------+
         |                  |                   |
   Bitcoin services   NodeAxe Command     Optional self-hosted
     (optional)           Center               applications
         |                  |                   |
    Bitcoin Core       Web dashboard       Additional services
    Solo mining pool   Fleet monitoring    (separately managed)
    Node telemetry     Device inventory
         |                  |
         +---------+--------+
                   |
             Miner adapters
                   |
           +-------+--------+
           |                |
       Local miners     Remote miners
       Bitaxe / ASICs   Bitaxe / ASICs
       GPU hosts        GPU hosts
                            |
                    Secure private network
```

The server product is the **host platform**; Bitcoin Core, the solo-mining pool, and the Command Center are **separate services**. The Command Center can monitor miners independently of Bitcoin Core. A dashboard failure must not interrupt Bitcoin validation or mining.

## Optional distributed deployment

The Command Center may also be installed on a separate Ubuntu host for existing or larger deployments. Node and miner telemetry can be accessed across authenticated private network connections. Integrated hosting is the intended default for the Sovereign Node & Home Server product, not a hard requirement for Command Center.

## Component responsibilities

| Component | Responsibility |
| --- | --- |
| Sovereign Node & Home Server | Ubuntu-based product host for independently managed services |
| Bitcoin Core (optional service) | Independent full-node validation and local Bitcoin RPC |
| Solo mining pool (optional service) | Stratum connections and mining work distribution |
| Node telemetry | Read-only status for configured node and pool services |
| NodeAxe Command Center | Web dashboard, fleet monitoring, inventory, and history |
| Miner adapters | Device-specific collection for AxeOS/Bitaxe, other ASICs, and GPU mining hosts |
| Secure networking | Optional authenticated access to remote sites and devices |

## Design principles

- **Product-first:** the Sovereign Node & Home Server is the recommended integrated host.
- **Modular:** Bitcoin Core, pool, telemetry, Command Center, and other applications are independently operable.
- **Node-independent dashboard:** Command Center remains useful without Bitcoin Core.
- **No unnecessary exposure:** Bitcoin RPC remains loopback-only where installed; do not expose administrative APIs publicly.
- **Read-only by default:** explicit authentication and confirmation for miner configuration changes.
- **Portable:** no machine names, private IPs, or location-specific assumptions in public code.
- **Stable inventory:** identify miners by persistent device identity, not IP alone.
- **Private by default:** secrets and production configuration stay outside source control.
- **Testable:** support development and staging independently of production services.

## Development status

The current implementation is a distributed prototype. Hosting Command Center on the NodeAxe Sovereign Node & Home Server is a product design goal. Public installation instructions will follow testing and security review. Production dashboard source is not yet published in this repository.
