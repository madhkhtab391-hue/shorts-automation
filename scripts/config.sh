#!/usr/bin/env bash
# Shared, non-secret settings for the Arabic kids dinosaur Short.

set -euo pipefail

readonly WIDTH=1080
readonly HEIGHT=1920
readonly FPS=30
readonly TARGET_DURATION=20
readonly ASSET_PATH="assets/dino-kids.png"
readonly BUILD_DIR="build"
readonly NARRATION_TEXT="هل تعرف أن بعض الديناصورات كانت أكبر من الحافلة؟ تخيّل ديناصورًا ضخمًا يمشي بجانب حافلة مدرسية! واو! عالم الديناصورات مذهل!"

mkdir -p "$BUILD_DIR"
