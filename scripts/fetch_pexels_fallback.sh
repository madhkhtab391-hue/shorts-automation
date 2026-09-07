#!/usr/bin/env bash
# Optional fallback only. The Cloudflare Worker owns any Pexels credentials;
# this repository receives public video metadata and never stores a key.

set -euo pipefail
source "$(dirname "$0")/config.sh"

: "${PEXELS_FALLBACK_ENDPOINT:?Set PEXELS_FALLBACK_ENDPOINT to the Cloudflare Worker URL.}"

metadata="$BUILD_DIR/pexels-videos.json"
curl --fail --location --retry 3 --retry-all-errors --silent --show-error \
  "$PEXELS_FALLBACK_ENDPOINT" --output "$metadata"

video_url="$(jq -er '.[0].videoUrl' "$metadata")"
if [[ ! "$video_url" =~ ^https://([a-z0-9-]+\.)?pexels\.com/ ]]; then
  echo "Worker returned an unexpected video URL host." >&2
  exit 1
fi

curl --fail --location --retry 3 --retry-all-errors --silent --show-error \
  "$video_url" --output "$BUILD_DIR/pexels-background.mp4"

ffprobe -v error -select_streams v:0 -show_entries stream=codec_type \
  -of default=noprint_wrappers=1:nokey=1 "$BUILD_DIR/pexels-background.mp4" | grep -qx video
echo "Downloaded Pexels fallback background."
