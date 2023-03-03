#!/bin/bash

set -e

USAGE="Usage: $0 <playlist_url> [out_dir] [beet_args]..."

if [ "$#" -eq 0 ]
then
  echo "$USAGE"
  exit 1
fi

PLAYLIST_URL="${1?}"
OUT_DIR="${2-.}/tmp/$(xxd -ps -l 8 /dev/random)"
shift 2

yt-dlp --yes-playlist \
  --format "aac/aac-hi/m4a/bestaudio/best" \
  --extract-audio --audio-format "m4a" \
  --embed-metadata \
  --output "$OUT_DIR/%(id)s.%(ext)s" \
  "$PLAYLIST_URL"

beet import "$OUT_DIR" "$@"
