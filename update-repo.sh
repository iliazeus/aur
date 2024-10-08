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

for package in "${packages[@]}"; do
  # TODO: can there ever be several files
  package_file="$(makepkg ${MAKEPKG_OPTS-} --dir "$package" --packagelist)"
  package_file_name="$(basename "${package_file}")"
  package_full_name="${package_file_name%-*}"

  if ! bsdtar -tf iliazeus.db.tar --include "$package_full_name/desc" &> /dev/null; then
    makepkg ${MAKEPKG_OPTS-} -sc --dir "$package"
    mv "$package_file" "_packages/$package_file_name"
    repo-add --remove iliazeus.db.tar "_packages/$package_file_name"
  fi
done

git branch -f pages HEAD
git switch pages
git add -f _packages/* iliazeus.db.* iliazeus.files.*
git commit -m $(date -Id)
git switch -
