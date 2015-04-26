#!/bin/sh

set -e

if [ $# -eq 1 ] && [ $1 = "--update" ];
then
    update=1
fi

dir=$(dirname $0)

# Copy .vimrc
echo "Copying .vimrc.."
cp $dir/.vimrc ~/.vimrc

# Install Pathogen
echo "Installing Pathogen.."
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Plugins
clone_plugin() {
    dir_bundle=~/.vim/bundle/
    name=$(echo $1 | rev | cut -d / -f 1 | rev | cut -d . -f 1)
    if [ ! -d $dir_bundle$name ];
    then
        echo " ..$name."
        git clone $1 $dir_bundle$name --quiet
    else
        echo " ..$name already installed."
        if [ $update ];
        then
            echo " ..$name pulling."
            git -C $dir_bundle$name pull
        fi
    fi
}

echo "Installing plugins.."
clone_plugin "https://github.com/chriskempson/base16-vim.git"
clone_plugin "git://git.wincent.com/command-t.git"
clone_plugin "https://github.com/xsbeats/vim-blade.git"
clone_plugin "git://github.com/mustache/vim-mustache-handlebars.git"

echo "vim setup done!"
