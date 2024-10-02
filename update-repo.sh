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

git branch -f pages HEAD
git switch pages

for package in "${packages[@]}"; do
  package_files="$(makepkg ${MAKEPKG_OPTS-} --dir "$package" --packagelist)"
  if xargs -n1 test -e <<< "$package_files"; then continue; fi
  rm -f "$package"/*.pkg.*
  makepkg ${MAKEPKG_OPTS-} -sc --dir "$package"
  repo-add iliazeus.db.tar $package_files
  git add -f $package_files
done

git add -f iliazeus.db* iliazeus.files*
git commit -m $(date -Id)
git switch -
git push -f origin pages
