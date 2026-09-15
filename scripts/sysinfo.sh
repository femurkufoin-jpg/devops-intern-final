#!/bin/bash

echo "===== System Information ====="
echo "Hostname: $(hostname)"
echo "Operating System: $(uname -s)"
echo "Kernel: $(uname -r)"
echo "Architecture: $(uname -m)"
echo "Uptime: $(uptime -p)"
echo "Current User: $(whoami)"

echo ""

echo "===== Memory Usage ====="
if command -v free >/dev/null 2>&1; then
    free -h
else
    echo "Memory usage: 'free' command is not available on this system."
    echo "Run this script on a Linux system to display memory usage."
fi

echo ""

echo "===== Disk Usage ====="
df -h /