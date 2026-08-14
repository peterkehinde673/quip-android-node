#!/usr/bin/env bash
set -euo pipefail

# Installs the current Quip v0.2 miner from the official upstream repository.
# This wrapper does not vendor or modify Quip source code.

INSTALL_ROOT="${QUIP_INSTALL_ROOT:-$HOME/quip-android-node-runtime}"
UPSTREAM_URL="https://gitlab.com/quip.network/quip-protocol.git"
UPSTREAM_DIR="$INSTALL_ROOT/quip-protocol"
VENV_DIR="$INSTALL_ROOT/.venv"

printf '%s\n' '=== Quip Android Miner installer ==='

if [ "$(uname -m)" != "aarch64" ]; then
  echo "ERROR: This setup currently targets ARM64/aarch64 Android." >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "ERROR: python3 is required." >&2
  exit 1
fi

if ! python3 -m venv --help >/dev/null 2>&1; then
  echo "ERROR: Python venv support is required." >&2
  exit 1
fi

mkdir -p "$INSTALL_ROOT"

if [ -d "$UPSTREAM_DIR/.git" ]; then
  echo "Updating official Quip repository..."
  git -C "$UPSTREAM_DIR" fetch --depth=1 origin main
  git -C "$UPSTREAM_DIR" reset --hard origin/main
else
  echo "Cloning official Quip repository..."
  git clone --depth=1 "$UPSTREAM_URL" "$UPSTREAM_DIR"
fi

if [ ! -d "$VENV_DIR" ]; then
  python3 -m venv "$VENV_DIR"
fi

# shellcheck disable=SC1091
source "$VENV_DIR/bin/activate"
python -m pip install --upgrade pip setuptools wheel
python -m pip install -e "$UPSTREAM_DIR"

printf '\nInstallation complete.\n'
printf 'Runtime: %s\n' "$INSTALL_ROOT"
printf 'Activate with: source %s/bin/activate\n' "$VENV_DIR"
printf 'Verify with: quip-miner --help\n'
printf '\nIMPORTANT: A validator WebSocket endpoint and a properly funded/registered signer are required before mining.\n'
