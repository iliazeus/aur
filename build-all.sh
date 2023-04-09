#!/bin/bash

set -e

for pkg in *
do
    [ -d $pkg ] || continue
    pushd $pkg
    makepkg --force --syncdeps --rmdeps --clean --check --noconfirm
    popd
done
