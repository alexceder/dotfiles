#!/usr/bin/env sh

set -e

dir=$(dirname "$0")

# Copy gtk.css
gtk_path="$HOME/.config/gtk-3.0"
if [ -d "$gtk_path" ];
then
    echo "Copying gtk.css"
    cp "$dir"/gtk.css "$gtk_path"/gtk.css
    echo "gtk setup done!"
fi
