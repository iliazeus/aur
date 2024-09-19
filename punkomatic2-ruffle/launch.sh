#!/bin/sh

/usr/lib/ruffle-punkomatic2/ruffle /usr/lib/ruffle-punkomatic2/pom2.swf \
  --storage disk --save-directory "$HOME/.local/share/ruffle-punkomatic2/SharedObjects" \
  --config "$HOME/.config/ruffle-punkomatic2" \
  --tcp-connections deny --open-url-mode confirm
