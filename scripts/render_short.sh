#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/config.sh"

background="$ASSET_PATH"
if [[ "${BACKGROUND_SOURCE:-artwork}" == "pexels" ]]; then
  background="$BUILD_DIR/pexels-background.mp4"
fi

test -s "$background"
test -s "$BUILD_DIR/narration.mp3"
test -s "$BUILD_DIR/music.mp3"
test -s "$BUILD_DIR/pop.mp3"
test -s "$BUILD_DIR/captions.ass"

if [[ "$background" == *.png ]]; then
  video_input=(-loop 1 -framerate "$FPS" -i "$background")
  video_filter="[0:v]scale=${WIDTH}:${HEIGHT}:force_original_aspect_ratio=increase,crop=${WIDTH}:${HEIGHT},zoompan=z='min(zoom+0.00045,1.09)':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=1:s=${WIDTH}x${HEIGHT}:fps=${FPS},subtitles=${BUILD_DIR}/captions.ass[v]"
else
  video_input=(-stream_loop -1 -i "$background")
  video_filter="[0:v]scale=${WIDTH}:${HEIGHT}:force_original_aspect_ratio=increase,crop=${WIDTH}:${HEIGHT},fps=${FPS},subtitles=${BUILD_DIR}/captions.ass[v]"
fi

ffmpeg -y \
  "${video_input[@]}" \
  -i "$BUILD_DIR/narration.mp3" \
  -i "$BUILD_DIR/music.mp3" \
  -i "$BUILD_DIR/pop.mp3" \
  -filter_complex "${video_filter};[1:a]volume=1.25[narration];[2:a]volume=0.22[music];[3:a]asplit=2[sfxa][sfxb];[sfxa]adelay=600|600,volume=0.7[sfx1];[sfxb]adelay=13600|13600,volume=0.7[sfx2];[narration][music][sfx1][sfx2]amix=inputs=4:duration=longest:dropout_transition=2:normalize=0[a]" \
  -map '[v]' -map '[a]' -t "$TARGET_DURATION" \
  -c:v libx264 -preset medium -crf 22 -profile:v high -level 4.1 -pix_fmt yuv420p -movflags +faststart \
  -c:a aac -b:a 160k -ar 44100 -ac 2 \
  short.mp4
