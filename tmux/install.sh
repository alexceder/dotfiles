#!/usr/bin/env sh

set -e

dir=$(dirname $0)

# Copy .tmux.conf
echo "Copying .tmux.conf"
cp $dir/.tmux.conf ~/.tmux.conf

echo "tmux setup done!"
