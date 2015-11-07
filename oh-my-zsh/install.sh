#!/usr/bin/env sh

set -e

dir=$(dirname $0)

# Copy .zshrc
echo "Copying .zshrc"
cp $dir/.zshrc ~/.zshrc

# Copy themes
echo "Copying themes"
cp -r $dir/themes ~/.oh-my-zsh/custom/

echo "oh-my-zsh setup done!"
