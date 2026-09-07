#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/config.sh"

if [[ ! -f "$ASSET_PATH" ]]; then
  echo "Required dinosaur artwork is missing: $ASSET_PATH" >&2
  exit 1
fi

if ! file --brief --mime-type "$ASSET_PATH" | grep -qx 'image/png'; then
  echo "Dinosaur artwork must be a PNG: $ASSET_PATH" >&2
  exit 1
fi

echo "Using dinosaur artwork: $ASSET_PATH"
identify -format 'Artwork dimensions: %wx%h\n' "$ASSET_PATH" 2>/dev/null || true
