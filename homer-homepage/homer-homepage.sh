#!/bin/bash

set -xE

cachedir="${XDG_CONFIG_HOME:-"$HOME/.cache"}/homer-homepage"
configdir="${XDG_CONFIG_HOME:-"$HOME/.config"}/homer-homepage"
datadir="${XDG_DATA_HOME:-"$HOME/.local/share"}/homer-homepage"
runtimedir="${XDG_RUNTIME_DIR:-"/run/user/$UID"}/homer-homepage"

mkdir -p "$cachedir" "$configdir" "$datadir" "$runtimedir"

mkdir -p "$configdir/assets"
cp --no-clobber /opt/homer-homepage/assets/config.yml.dist "$configdir/assets/config.yml" || true

mkdir -p "$cachedir/overlay-workdir" "$runtimedir/www"
umount --quiet "$runtimedir/www" || true
fuse-overlayfs -o "lowerdir=$configdir:/opt/homer-homepage,workdir=$cachedir/overlay-workdir" "$runtimedir/www"

darkhttpd "$runtimedir/www" "$@"

umount --quiet "$runtimedir/www" || true
