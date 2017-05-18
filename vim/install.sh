#!/usr/bin/env sh

set -e

if [ $# -eq 1 ] && [ $1 = "--update" ];
then
    update=1
fi

dir=`dirname $0`

# Copy .vimrc and .vim folder
echo "Copying .vimrc.b."
cp $dir/.vimrc ~/.vimrc
mkdir -p ~/.vim
cp -r $dir/.vim/* ~/.vim

# Install Pathogen
echo "Installing Pathogen.."
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Plugins
clone_plugin() {
    dir_bundle=~/.vim/bundle/
    name=`echo $1 | rev | cut -d / -f 1 | rev | cut -d . -f 1`
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
clone_plugin "https://github.com/AndrewRadev/splitjoin.vim"
clone_plugin "https://github.com/airblade/vim-gitgutter.git"
clone_plugin "https://github.com/chriskempson/base16-vim.git"
clone_plugin "https://github.com/mxw/vim-jsx.git"
clone_plugin "https://github.com/pangloss/vim-javascript.git"
clone_plugin "https://github.com/slim-template/vim-slim.git"
clone_plugin "https://github.com/tpope/vim-bundler.git"
clone_plugin "https://github.com/tpope/vim-commentary.git"
clone_plugin "https://github.com/tpope/vim-eunuch.git"
clone_plugin "https://github.com/tpope/vim-fugitive.git"
clone_plugin "https://github.com/tpope/vim-haml.git"
clone_plugin "https://github.com/tpope/vim-markdown.git"
clone_plugin "https://github.com/wincent/command-t.git"

echo "vim setup done!"
