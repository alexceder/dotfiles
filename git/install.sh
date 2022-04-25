#!/usr/bin/env sh

set -e

dir=$(dirname "$0")

# Copy .gitconfig, .gitignore, and .git_template folder
echo "Copying .gitconfig file and .git_template folder."
cp "$dir"/.gitconfig ~/.gitconfig
cp "$dir"/gitignore ~/.gitignore
cp -r "$dir"/.git_template ~/.git_template
