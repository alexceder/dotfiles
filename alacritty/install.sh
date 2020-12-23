#!/usr/bin/env sh

set -e

dir=$(dirname "$0")

# Copy alacritty.yml
echo "Copying alacritty.yml"
mkdir -p ~/.config/alacritty
cp "$dir"/alacritty.yml ~/.config/alacritty

echo "Alacritty setup done!"
