#!/usr/bin/env sh

set -e

dir=$(dirname "$0")

# Copy alacritty.yml
echo "Copying alacritty.yml"
mkdir -p ~/.config/alacritty
cp "$dir"/alacritty.yml ~/.config/alacritty

uname="$(uname -s)"
case "$uname" in
  Linux*)  os=linux;;
  Darwin*) os=macos;;
  *)       os="UNKNOWN:${uname}"
esac
os_file="alacritty.${os}.yml"
if [ -f "$dir/$os_file" ]; then
  echo "Appending ${os_file} to ~/.config/alacritty/alacritty.conf"
  {
    echo
    echo "# Following lines appended from $os_file"
  } >> ~/.config/alacritty/alacritty.yml
  cat "$dir/$os_file" >> ~/.config/alacritty/alacritty.yml
else
  echo "Either OS ${os} is not valid or ${os_file} does not exist"
fi

echo "Alacritty setup done!"
