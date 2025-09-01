#!/bin/sh

# Step 1: Package and download thumbnails
python3 -m sticker.pack "$1"
python3 -m sticker.download_thumbnails "$1/pack.json"

# Step 2: Move pack.json and thumbnails
PACK_NAME=$(basename "$1")
mv "$1/pack.json" "web/packs/${PACK_NAME}.json"
mv "$1/thumbnails/"* web/packs/thumbnails/

# Step 3: Update index.json
jq --arg pack "${PACK_NAME}.json" \
   '.packs += [$pack] | .packs |= unique' \
   web/packs/index.json > web/packs/index.tmp && mv web/packs/index.tmp web/packs/index.json
