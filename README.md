# NodeAxe

**Open Bitcoin infrastructure · Self-hosted mining · Practical education**

**Build. Mine. Verify. Learn.**

NodeAxe is a developing ecosystem for people who want to understand and operate their own Bitcoin infrastructure. Our work spans Bitcoin full nodes, open-source ASIC miners, telemetry dashboards, cooling and hardware accessories, and hands-on STEM education.

> **Project status:** Active development. This repository is currently a documentation and project hub, **not** a supported installer or production-ready release.

## What we're building

- **Sovereign Node:** Self-hosted Bitcoin Core infrastructure and local solo-mining integrations.
- **Command Center:** Multi-location mining telemetry spanning Bitcoin nodes, Bitaxe/AxeOS, Avalon, GPU rigs, and pool metrics.
- **Open hardware R&D:** 3D-printed stands, cooling accessories, and miner experimentation.
- **Education:** Accessible lessons on Bitcoin, entropy, proof-of-work, and self-custody.

## Architecture

A reference deployment uses a HOME Bitcoin Core node and local mining pool, with telemetry forwarded privately to a separate OFFICE dashboard that also monitors local miners. The dashboard is independent of mining services.

See [Architecture](docs/ARCHITECTURE.md) and [Roadmap](docs/ROADMAP.md).

## Getting started

**No public production installer is available yet.** The historical `nodeaxe_setup.sh` is an unsupported prototype and **must not be run**. It contains legacy hardcoded sample RPC credentials; if those were used on a real node, rotate them. Git history may retain older content.

For now, explore the documentation, open an issue with feedback, or follow development progress.

## Open source and contributions

See [Contributing](CONTRIBUTING.md) and [Security](SECURITY.md). A repository-wide license has **not yet been selected**; do not assume the project code or designs are licensed for reuse until applicable licenses are published. Third-party upstream projects retain their own licenses.

## Links

- [NodeAxe website](https://nodeaxe.com)
- [Project roadmap](docs/ROADMAP.md)
- [Report security concerns](SECURITY.md)

**NodeAxe — Open by design. Verify everything.**
