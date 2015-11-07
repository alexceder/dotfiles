#!/usr/bin/env sh

set -e

echo "Running all install.sh scripts."
find ./**/install.sh | while read filename; do
    echo "\nRunning $filename:"
    sh $filename
done
