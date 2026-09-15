#!/usr/bin/env bash
set -euo pipefail

TARGET_URL="${1:-http://localhost:8080}"

if curl -fsS -o /dev/null "$TARGET_URL"; then
    echo "Health check passed: $TARGET_URL"
else
    echo "Health check failed: $TARGET_URL" >&2
    exit 1
fi
