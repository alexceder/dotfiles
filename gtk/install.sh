#!/bin/sh

set -e

dir=$(dirname $0)

# Copy gtk.css
echo "Copying gtk.css"
cp $dir/gtk.css ~/.config/gtk-3.0/gtk.css

echo "gtk setup done!"
