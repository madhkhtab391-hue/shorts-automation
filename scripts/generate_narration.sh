#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/config.sh"

command -v edge-tts >/dev/null
output="$BUILD_DIR/narration.mp3"

# Taim is preferred. If Microsoft no longer exposes it for the runner, retry
# with Sana rather than falling back to the unsuitable espeak Arabic voice.
if edge-tts --voice ar-JO-TaimNeural --rate=-8% --volume=+0% \
  --text "$NARRATION_TEXT" --write-media "$output"; then
  echo "Narration voice: ar-JO-TaimNeural"
else
  echo "ar-JO-TaimNeural unavailable; retrying with ar-JO-SanaNeural." >&2
  edge-tts --voice ar-JO-SanaNeural --rate=-8% --volume=+0% \
    --text "$NARRATION_TEXT" --write-media "$output"
  echo "Narration voice: ar-JO-SanaNeural"
fi

test -s "$output"
