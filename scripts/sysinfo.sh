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
free -h

echo ""
echo "===== Disk Usage ====="
df -h /