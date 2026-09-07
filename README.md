# Arabic Kids YouTube Shorts Prototype

This repository generates a 20-second, 1080×1920 Arabic dinosaur Short for children aged 5–8. It uses the bundled dinosaur artwork, Edge TTS, Noto Sans Arabic captions, and locally synthesized music and sound effects.

## Run it

In GitHub, open **Actions → Create Arabic Kids Dino Short → Run workflow**. Choose:

- `artwork` (default): use `assets/dino-kids.png`.
- `pexels`: use the existing Cloudflare Worker/Pexels integration as a background fallback.

The resulting `short.mp4` is available as the `arabic-kids-dino-short` workflow artifact.

## Design

- `assets/dino-kids.png`: required bundled dinosaur/kids artwork.
- `scripts/`: reusable Bash scripts for preparation, narration, audio, captions, rendering, and validation.
- `.github/workflows/main.yml`: manually triggered orchestration only.

No API keys are stored in this project. The optional Pexels fallback calls the pre-existing Cloudflare Worker endpoint, which supplies public Pexels video metadata.
