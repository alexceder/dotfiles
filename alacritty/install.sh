#!/usr/bin/env sh

set -e

dir=$(dirname "$0")

# Copy alacritty.toml
echo "Copying alacritty.toml"
mkdir -p ~/.config/alacritty
cp "$dir"/alacritty.toml ~/.config/alacritty

uname="$(uname -s)"
case "$uname" in
  Linux*)  os=linux;;
  Darwin*) os=macos;;
  *)       os="UNKNOWN:${uname}"
esac
os_file="alacritty.${os}.toml"
if [ -f "$dir/$os_file" ]; then
  echo "Appending ${os_file} to ~/.config/alacritty/alacritty.toml"
  {
    echo
    echo "# Following lines appended from $os_file"
  } >> ~/.config/alacritty/alacritty.toml
  cat "$dir/$os_file" >> ~/.config/alacritty/alacritty.toml
else
  echo "Either OS ${os} is not valid or ${os_file} does not exist"
fi

echo "alacritty setup done!"
