#!/usr/bin/env bash
set -euo pipefail

echo "===== System Information ====="
echo "Current User: $(whoami)"
echo "Effective UID: $(id -u)"
echo "Hostname: $(hostname)"
echo "Kernel Release: $(uname -r)"
echo "System Date: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"

echo ""
echo "===== Disk Usage ====="
df -h /

echo ""
echo "===== Memory Usage ====="

if command -v free >/dev/null 2>&1; then
    free -h
else
    echo "Memory usage: 'free' command is not available on this system."
    echo "Run this script on a Linux system to display memory usage."
fi

echo ""
echo "===== Docker Daemon Status ====="

if command -v docker >/dev/null 2>&1; then
    if docker info >/dev/null 2>&1; then
        echo "Docker daemon: running"
    else
        echo "Docker daemon: not running or inaccessible"
    fi
else
    echo "Docker: command not found"
fi