#!/bin/bash

CURRENT_DIR=`pwd`
VIM_PLUGINS_DIR=~/.vim/bundle

[ -f ~/.vimrc ] && rm ~/.vimrc
ln -s ${CURRENT_DIR}/vimrc ~/.vimrc

git clone https://github.com/VundleVim/Vundle.vim.git ${VIM_PLUGINS_DIR}/Vundle.vim

# sudo apt-get install astyle cppcheck pep8 pylint3 || echo 'Not a Debian-based distro. Install desired tools on your own.'

vim +PluginInstall +qall

mkdir -p ~/.fonts
cp ${VIM_PLUGINS_DIR}/fonts/UbuntuMono/*.ttf ~/.fonts/
fc-cache -vf ~/.fonts/

mkdir -p ~/.vim/colors
cp solarized.vim ~/.vim/colors/

cat gtk.css >>.config/gtk-3.0/gtk.css


# Set up Tmux

sudo apt install tmux

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || echo "Tmux plugin manager already installed"

[ -f ~/.tmux.conf ] && rm ~/.tmux.conf
ln -s ${CURRENT_DIR}/tmux.conf ~/.tmux.conf

tmux source-file ~/.tmux.conf