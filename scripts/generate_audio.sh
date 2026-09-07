#!/usr/bin/env bash
# The music and effects are synthesized locally with FFmpeg. No third-party
# recording is used, so this prototype has no music licensing dependency.

set -euo pipefail
source "$(dirname "$0")/config.sh"

ffmpeg -y \
  -f lavfi -i "sine=frequency=523.25:sample_rate=44100:duration=$TARGET_DURATION" \
  -f lavfi -i "sine=frequency=659.25:sample_rate=44100:duration=$TARGET_DURATION" \
  -f lavfi -i "sine=frequency=783.99:sample_rate=44100:duration=$TARGET_DURATION" \
  -filter_complex "[0:a][1:a][2:a]amix=inputs=3:normalize=0,volume=0.025,tremolo=f=4:d=0.25,afade=t=in:st=0:d=1,afade=t=out:st=18:d=2" \
  -c:a libmp3lame -b:a 128k "$BUILD_DIR/music.mp3"

ffmpeg -y \
  -f lavfi -i "sine=frequency=880:sample_rate=44100:duration=0.14" \
  -f lavfi -i "sine=frequency=1320:sample_rate=44100:duration=0.18" \
  -filter_complex "[0:a]afade=t=out:st=0.05:d=0.09[a];[1:a]afade=t=out:st=0.08:d=0.10[b];[a][b]concat=n=2:v=0:a=1,volume=0.35" \
  -c:a libmp3lame -b:a 128k "$BUILD_DIR/pop.mp3"
