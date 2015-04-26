#!/bin/sh

set -e

DIR=$(dirname $0)

echo "Copying .tmux.conf"
cp $DIR"/".tmux.conf ~/.tmux.conf

echo "tmux setup done!"
