#!/bin/bash

set -e

filename='ggml-alpaca-7b-q4.bin'
link='magnet:?xt=urn:btih:5aaceaec63b03e51a98f04fd5c42320b2a033010&dn=ggml-alpaca-7b-q4.bin&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=udp%3A%2F%2Fopentracker.i2p.rocks%3A6969%2Fannounce'
data_home="${XDG_DATA_HOME:-"$HOME/.local/share"}"
md5sum='31a542719abb9dfb641cf9489130ab42'

mkdir -p "$data_home/alpaca-cpp"

if [[ -e "$data_home/alpaca-cpp/$filename" ]]
then
  if md5sum --check <(echo "$md5sum  $data_home/alpaca-cpp/$filename")
  then
    exit 0
  else
    rm "$data_home/alpaca-cpp/$filename"
    aria2c "$link" -d "$data_home/alpaca-cpp"
  fi
else
  aria2c "$link" -d "$data_home/alpaca-cpp"
fi
