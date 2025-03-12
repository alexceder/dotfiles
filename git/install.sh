#!/usr/bin/env sh

set -e

dir=$(dirname "$0")

echo "Copying config, ignore, and templates folder."
mkdir -p ~/.config/git
cp "$dir"/config ~/.config/config
cp "$dir"/ignore ~/.config/ignore
cp -r "$dir"/templates ~/.config/templates
