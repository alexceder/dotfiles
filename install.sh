#!/bin/sh

set -e

echo "Running all install.sh scripts."
find -mindepth 2 -name "install.sh" | while read filename; do
    echo "\nRunning $filename:"
    sh $filename
done
