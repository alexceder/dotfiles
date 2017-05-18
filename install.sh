#!/usr/bin/env sh

set -e

echo "Running all install.sh scripts."

find ./**/install.sh | while read -r name; do
    echo "Running $name:"
    sh "$name"
done
