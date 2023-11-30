#!/bin/bash

set -e

USAGE="Usage: BEETS_OPTS='...' YTDLP_OPTS='...' $0 <playlist_url>"

if [ "$#" -eq 0 ]
then
  echo "$USAGE"
  exit 1
fi

PLAYLIST_URL="${1?}"
shift

BEETS_OPTS="${BEETS_OPTS-}"
YTDLP_OPTS="${YTDLP_OPTS-}"

OUT_DIR="./tmp/$(xxd -ps -l 8 /dev/random)"

yt-dlp --yes-playlist \
  --format "aac/aac-hi/m4a/bestaudio/best" \
  --extract-audio --audio-format "m4a" \
  --embed-metadata \
  --output "$OUT_DIR/%(id)s.%(ext)s" \
  "$PLAYLIST_URL" \
  $YTDLP_OPTS

beet import "$OUT_DIR" $BEETS_OPTS
