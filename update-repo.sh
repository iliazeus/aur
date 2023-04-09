#!/bin/bash

set -e

cp */*.pkg.tar.zst .
git checkout -f gh-pages
repo-add --new --prevent-downgrade --verify --sign iliazeus.db.tar.gz *.pkg.tar.zst
git add iliazeus.* *.pkg.tar.zst
git commit --amend -m "update $(date -Is)"
git push --force
rm *.pkg.tar.zst
git checkout -
