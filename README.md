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
quip-miner deregister-solver
```

(The exact commands should always be confirmed with `quip-miner --help` before use.)

## Master checkpoint — 15 Aug 2026

This section records the current Android/Termux work so a future session can continue without restarting completed steps.

### Working environment

- Working source tree: `~/quip-nodes`
- Android-specific project: `~/quip-android-node`
- Installed executable currently resolves to `/root/quip-android-node/.quip/bin/quip-miner`
- Python: `3.14.4`
- pip: `26.2.1`
- `quip-miner selftest` passed:
  - scalecodec type-registry presets load
  - multiprocessing spawn round-trip
- `quip-miner resolve-mode --config ~/quip-nodes/data/config.cpu.toml` returns `cpu`.
- Android shared storage is confirmed readable/writable from Ubuntu.
- All diagnostic files for easy Android sharing should be saved under `/storage/emulated/0/file output/`.

### Repository state

The checked-out Quip infrastructure repository is:

`https://gitlab.com/quip.network/nodes.quip.network.git`

- Branch: `main`
- Local commit: `f2b0236`
- Remote commit: `f2b0236`
- The local checkout is up to date; do not reclone, reset, or restart the completed repository setup.

### CPU configuration findings

Existing CPU configuration files include:

- `config/localdev.cpu.toml` — disposable Docker/local-development configuration; **not** the Android standalone miner configuration.
- `data/config.cpu.toml` — existing bundled-validator configuration.

`data/config.cpu.toml` currently points to:

```toml
validators = [
    "ws://quip-validator:9944",
]
```

That hostname is the Docker/compose-local validator address and must not be assumed reachable from standalone Android Ubuntu.

The repository documentation says miner-only nodes can use a public validator through:

```text
QUIP_VALIDATOR_RPC_URLS=wss://cpu-1.nodes.quip.network/rpc
```

However, an actual Android DNS/TCP/WebSocket test of `cpu-1.nodes.quip.network` failed with `Errno -5: No address associated with hostname`. Therefore **do not put that endpoint into the Android configuration until a currently reachable endpoint is verified**.

The latest endpoint search of the checked-out repository still found `cpu-1.nodes.quip.network` as the documented/example public RPC and `bootnode-1/2/3.testnet.quip.network` as testnet bootnode addresses, but did not establish a currently reachable public miner RPC endpoint.

### Current position

**READY FOR VALIDATOR ENDPOINT VERIFICATION — NOT MINING YET.**

Do not yet:

- generate or expose a wallet seed/private key
- commit a keystore
- run bootstrap/registration
- start CPU mining
- replace the existing config with an unverified RPC endpoint

The next task is to verify a currently reachable Quip public RPC/validator endpoint, then make the minimum Android-specific configuration change before proceeding to key generation, funding/registration, and a controlled CPU miner launch.

## Diagnostic files

Diagnostics created during this checkpoint include:

- `quip_test.txt`
- `quip_environment.txt`
- `quip_project_files.txt`
- `quip_cpu_configs.txt`
- `quip_config_validation.txt`
- `quip_cpu_help_and_endpoints.txt`
- `quip_public_rpc_test.txt`
- `quip_repo_status.txt`
- `quip_current_endpoints.txt`

The source copies remain in Android shared storage under `/storage/emulated/0/file output/` where applicable. Do not commit diagnostic files containing secrets.

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
- [x] Confirm Android shared-storage diagnostics path
- [x] Verify Quip CLI selftest
- [x] Verify CPU config resolution
- [x] Verify current GitLab checkout is synchronized with origin/main
- [x] Inspect current CPU configuration and endpoint references
- [x] Test documented public RPC hostname — DNS failed
- [ ] Verify a currently reachable Quip validator/public RPC endpoint
- [ ] Inspect `keygen`, `bootstrap`, and `cpu` options for the verified network
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
