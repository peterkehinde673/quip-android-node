# Quip Android Node

A dedicated project for testing the current **Quip v0.2 CPU miner** on Android through Termux + Ubuntu `proot-distro`.

> **Important:** Quip v0.2 is a stateless miner that connects to a Substrate validator over WebSocket. The old v0.1 `quip-network-node` P2P architecture is no longer the current mining path.

## Android environment checkpoint

Verified on the target phone:

- Device: Infinix Note G96
- Architecture: `aarch64` / ARM64
- Ubuntu: 26.04 LTS inside PRoot
- Kernel: `6.17.0-PRoot-Distro`
- Python: 3.14.4
- pip: 25.1.1
- Git: 2.53.0
- Python `venv`: working
- CPU: 8 cores
- RAM: 7.6 GiB total; about 1.6 GiB available at the last check
- Swap: 4.1 GiB
- Docker: not installed
- Storage: approximately 11 GB free at the last check

## Current implementation

### Source and installation status

- Official Quip repository cloned at `/root/quip-protocol`.
- Checked out official **v0.2.1** (`72a7e77`, shallow clone).
- Quip declares `requires-python = ">=3.10"`, so Python 3.14.4 satisfies the declared requirement.
- The Android project's `.quip` virtual environment is working.
- Quip dependencies installed successfully after a lengthy ARM64 installation.
- `quip-miner --help` works.
- Imports for `substrateinterface`, `blake3`, `dilithium_py`, and `numpy` were verified successfully.

### Verified CLI

The installed CLI exposes:

```text
quip-miner keygen
quip-miner bootstrap
quip-miner cpu
quip-miner gpu
quip-miner qpu
quip-miner identify
quip-miner register-solver
aquip-miner deregister-solver
```

(The exact commands should always be confirmed with `quip-miner --help` before use.)

## Current position

**READY FOR MINER CONFIGURATION — NOT MINING YET.**

The next work is to inspect the official v0.2.1 command help/configuration requirements for `keygen`, `bootstrap`, and `cpu`, then identify the correct validator/network endpoint. No wallet seed phrase or private key should ever be sent to ChatGPT or committed to GitHub.

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
- [x] Clone official Quip v0.2.1 source
- [x] Create Python virtual environment
- [x] Install Quip v0.2.1 dependencies
- [x] Verify `quip-miner --help`
- [x] Verify core Python imports
- [ ] Inspect `keygen`, `bootstrap`, and `cpu` options
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
