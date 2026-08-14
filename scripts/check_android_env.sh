#!/usr/bin/env bash
set -u

printf '%s\n' '=== Quip Android Node environment check ==='
printf 'Architecture: '; uname -m
printf 'Kernel: '; uname -r
printf 'Ubuntu: '; . /etc/os-release 2>/dev/null && printf '%s %s\n' "$NAME" "$VERSION_ID" || printf 'unknown\n'
printf 'Python: '; python3 --version 2>&1 || true
printf 'pip: '; python3 -m pip --version 2>&1 || true
printf 'venv: '; python3 -m venv --help >/dev/null 2>&1 && printf 'available\n' || printf 'missing\n'
printf 'Git: '; git --version 2>&1 || true
printf 'Docker: '; command -v docker >/dev/null 2>&1 && docker --version || printf 'not installed\n'
printf '\n=== Memory ===\n'
free -h
printf '\n=== Storage ===\n'
df -h / 2>/dev/null || true
printf '\n=== CPU ===\n'
nproc 2>/dev/null || true
