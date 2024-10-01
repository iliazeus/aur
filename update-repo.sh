#!/bin/bash
set -euo pipefail

packages=(
  dump-projector
  http-prompt-pex
  iso2god
  punkomatic2-ruffle
  tailscale-systray-git-iliazeus
  yt-dl-album
)

if [ -e packages.tar ]; then
  bsdtar -xf packages.tar
fi

for package in "${packages[@]}"; do
  package_files="$(makepkg $MAKEPKG_OPTS --dir "$package" --packagelist)"
  if xargs -n1 test -e <<< "$package_files"; then continue; fi
  rm -f "$package"/*.pkg.*
  makepkg $MAKEPKG_OPTS -sc --dir "$package"
  repo-add packages.db.tar $package_files
done

bsdtar -cf packages.tar */*.pkg.*
