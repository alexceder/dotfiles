#!/usr/bin/env sh

set -e

dir=$(dirname "$0")

# Copy zshrc
echo "Copying .zshrc and touching .zshrc.local"
cp "$dir"/zshrc ~/.zshrc
touch ~/.zshrc.local

echo "zsh setup done!"
