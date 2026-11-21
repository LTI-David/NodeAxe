# Security policy

NodeAxe is an evolving research and development project. **Do not treat this repository as a production-ready Bitcoin node installer.**

## Reporting

Please avoid posting vulnerabilities, credentials, wallet material, or identifying network details in public issues. Contact the repository maintainers privately through GitHub before disclosing a vulnerability. A dedicated private reporting channel is planned.

## Important legacy warning

The historical `nodeaxe_setup.sh` is an unmaintained prototype, not a supported installer. It contains hardcoded sample RPC credentials and should not be run. Anyone who used those credentials on a real system should rotate them and review exposure. Removing credentials from a later commit does not erase Git history.

## Development safeguards

Never commit seed phrases, private keys, passwords, RPC cookies, Tailscale credentials, production environment files, or detailed network inventories. Use private configuration files and least-privilege permissions. Keep Bitcoin RPC local-only and require authentication for any control interface.
