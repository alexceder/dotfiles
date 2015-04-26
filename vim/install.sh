#!/bin/sh

set -e

DIR=$(dirname $0)

echo "Copying .vimrc.."
cp $DIR"/".vimrc ~/.vimrc

# Install Pathogen
echo "Installing Pathogen.."
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Plugins
clone_plugin() {
    if [ ! -d ~/.vim/bundle/$2 ]; then
        echo " ..$2."
        git clone $1 ~/.vim/bundle/$2 --quiet
    else
        echo " ..$2 already installed."
    fi
}

echo "Installing plugins.."
clone_plugin "https://github.com/chriskempson/base16-vim.git" "base16-vim"
clone_plugin "git://git.wincent.com/command-t.git" "command-t"
clone_plugin "https://github.com/xsbeats/vim-blade.git" "vim-blade"

echo "vim setup done!"
