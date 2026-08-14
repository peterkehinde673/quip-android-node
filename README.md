# Quip Android Node

A dedicated project for testing the current **Quip v0.2 CPU miner** on Android through Termux + Ubuntu `proot-distro`.

> **Important:** Quip v0.2 is a stateless miner that connects to a Substrate validator over WebSocket. The old v0.1 `quip-network-node` P2P architecture is no longer the current mining path.

## Android environment checkpoint

Verified on the target phone:

- Device: Infinix Note G96
- Architecture: `aarch64` / ARM64
- Ubuntu: 26.04 LTS inside PRoot
- Python: 3.14.4
- pip: 25.1.1
- Git: 2.53.0
- Python `venv`: working
- Docker: not installed
- Storage: approximately 11 GB free at the last check

## Repository purpose

This repository contains Android-specific setup, diagnostics, configuration examples, and documentation. The official Quip source is fetched from its upstream GitLab repository at install time rather than copied into this repository.

## Current implementation

### 1. Environment diagnostic

```bash
bash scripts/check_android_env.sh
```

### 2. Install the official Quip v0.2 miner

```bash
bash scripts/install_quip_miner.sh
```

The installer:

1. Confirms ARM64.
2. Clones or updates the official Quip protocol repository.
3. Creates a dedicated Python virtual environment.
4. Installs the current Quip package with `pip install -e`.
5. Leaves the upstream source outside this Git repository.

## Upstream Quip workflow

The current upstream CLI uses `quip-miner`, including:

```text
quip-miner keygen
quip-miner bootstrap --validator <ws-endpoint>
quip-miner cpu --validator <ws-endpoint>
```

A validator WebSocket endpoint and an appropriately funded/registered signer are required before real mining can begin.

## Android safety / resource policy

This project deliberately avoids installing Docker on the phone until it is proven necessary. The phone currently has limited free storage and memory, and the first target is the lighter CPU miner client rather than a full validator stack.

Do not commit:

- private keys or keystores
- `.env` files
- faucet credentials
- API keys
- generated runtime databases
- large upstream source/build artifacts

## Roadmap

- [x] Verify ARM64 Android/PRoot environment
- [x] Create dedicated GitHub repository
- [x] Add Android environment diagnostic
- [x] Add official Quip miner installer
- [ ] Run installer on the phone
- [ ] Verify `quip-miner --help`
- [ ] Generate a dedicated miner signer/keystore
- [ ] Identify the appropriate Quip validator endpoint/faucet for the intended network
- [ ] Bootstrap/register the miner
- [ ] Run CPU mining with conservative CPU usage
- [ ] Measure temperature, RAM, storage and mining stability
- [ ] Add Android-friendly start/stop/status helpers

## Official upstream

Quip Protocol: https://gitlab.com/quip.network/quip-protocol

## Project owner

KennyBabs / `peterkehinde673`
