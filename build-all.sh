#!/bin/bash

set -e

for pkg in *
do
    [ -d $pkg ] || continue
    pushd $pkg
    makepkg --force --syncdeps --rmdeps --clean --check --sign --noconfirm
    popd
done
