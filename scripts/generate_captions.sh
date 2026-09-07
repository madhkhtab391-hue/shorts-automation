#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/config.sh"

cat > "$BUILD_DIR/captions.ass" <<'EOF'
[Script Info]
Title: Arabic Kids Dino Captions
ScriptType: v4.00+
PlayResX: 1080
PlayResY: 1920
WrapStyle: 0
ScaledBorderAndShadow: yes

[V4+ Styles]
Format: Name,Fontname,Fontsize,PrimaryColour,SecondaryColour,OutlineColour,BackColour,Bold,Italic,Alignment,MarginL,MarginR,MarginV,Encoding
Style: KidsArabic,Noto Sans Arabic,68,&H00FFFFFF,&H0000FFFF,&H001A2230,&H88000000,1,0,8,65,65,265,1

[Events]
Format: Layer,Start,End,Style,Name,MarginL,MarginR,MarginV,Effect,Text
Dialogue: 0,0:00:00.00,0:00:06.50,KidsArabic,,0,0,0,,هل تعرف أن بعض الديناصورات\Nكانت أكبر من الحافلة؟
Dialogue: 0,0:00:06.50,0:00:13.50,KidsArabic,,0,0,0,,تخيّل ديناصورًا ضخمًا يمشي\Nبجانب حافلة مدرسية!
Dialogue: 0,0:00:13.50,0:00:20.00,KidsArabic,,0,0,0,,واو! عالم الديناصورات\Nمذهل!
EOF
