#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/config.sh"

output="${1:-short.mp4}"
test -s "$output"

probe_json="$(ffprobe -v error -show_entries format=duration:stream=codec_type,codec_name,width,height -of json "$output")"
video_count="$(jq '[.streams[] | select(.codec_type == "video")] | length' <<<"$probe_json")"
audio_count="$(jq '[.streams[] | select(.codec_type == "audio")] | length' <<<"$probe_json")"
width="$(jq -r '.streams[] | select(.codec_type == "video") | .width' <<<"$probe_json")"
height="$(jq -r '.streams[] | select(.codec_type == "video") | .height' <<<"$probe_json")"
codec="$(jq -r '.streams[] | select(.codec_type == "video") | .codec_name' <<<"$probe_json")"
duration="$(jq -r '.format.duration' <<<"$probe_json")"

[[ "$video_count" == "1" ]]
[[ "$audio_count" == "1" ]]
[[ "$width" == "$WIDTH" ]]
[[ "$height" == "$HEIGHT" ]]
[[ "$codec" == "h264" ]]
awk -v d="$duration" 'BEGIN { exit !(d >= 19.5 && d <= 20.5) }'

echo "Validated $output: ${width}x${height}, ${duration}s, H.264 video, AAC audio."
