#!/usr/bin/env sh

set -e

dir=$(dirname "$0")

# Copy tmux.conf
echo "Copying tmux.conf"
mkdir -p ~/.config/tmux
cp "$dir"/tmux.conf ~/.config/tmux.conf

# Append OS specific configuration.
uname="$(uname -s)"
case "$uname" in
  Linux*)  os=linux;;
  Darwin*) os=macos;;
  *)       os="UNKNOWN:${uname}"
esac
os_file="tmux.${os}.conf"
if [ -f "$dir/$os_file" ]; then
  echo "Appending ${os_file} to ~/.config/tmux.conf"
  {
    echo
    echo "# Following lines appended from $os_file"
  } >> ~/.config/tmux.conf
  cat "$dir/$os_file" >> ~/.config/tmux.conf
else
  echo "Either OS ${os} is not valid or ${os_file} does not exist"
fi

echo "tmux setup done!"
