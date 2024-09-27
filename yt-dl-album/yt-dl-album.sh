#!/bin/bash
set -euo pipefail

USAGE="Usage: YTDLP_OPTS='...' yt-dl-album <playlist_url> [beets_opts...]"

if [ "$#" -eq 0 ]
then
  echo "$USAGE"
  exit 1
fi

playlist_url="$1"; shift
beets_opts="$@"
ytdlp_opts="${YTDLP_OPTS-}"

tmp_dir="./tmp/$(date -Ins)"

yt-dlp --yes-playlist \
  --format "aac/aac-hi/m4a/bestaudio/best" \
  --extract-audio --audio-format "m4a" \
  --embed-metadata \
  --output "$tmp_dir/%(id)s.%(ext)s" \
  "$playlist_url" \
  $ytdlp_opts

beet import "$tmp_dir" $beets_opts

rm -r "$tmp_dir"
