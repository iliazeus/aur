#!/bin/bash

set -e

git checkout -f gh-pages
git rm -f *.pkg.tar.zst
git stash
git checkout -

cp */*.pkg.tar.zst .
git checkout -f gh-pages
git stash pop

repo-add --new --prevent-downgrade --verify --sign iliazeus.db.tar.gz *.pkg.tar.zst || true
git add --ignore-errors iliazeus.* *.pkg.tar.zst

git commit --amend -m "update $(date -Is)"
git push --force

rm -f *.pkg.tar.zst
git checkout -
