# drosera-ciltrap

Trap Name: **Citlalicue**

This repository contains the Drosera Ciltrap setup.  
It monitors a specific ERC20 token and triggers a response when the watched address transfers tokens above a configured threshold.

## Structure

- `src/CILTrap.sol` — Solidity trap contract
- `out/CILTRAP.sol/CILTrap.json` — Compiled JSON artifact
- `Drosera.toml` — Drosera config
- `setup.sh` — Setup and verification script

## Usage

1. Upload this repository to your server with Drosera and the trap installed.
2. Run:

```bash
chmod +x setup.sh
./setup.sh
```

3. Ensure all checks pass before running the trap.
