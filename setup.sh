#!/bin/bash

CURRENT_DIR=`pwd`
VIM_PLUGINS_DIR=~/.vim/bundle

[ -f ~/.vimrc ] && rm ~/.vimrc
ln -s ${CURRENT_DIR}/vimrc ~/.vimrc

git clone https://github.com/VundleVim/Vundle.vim.git ${VIM_PLUGINS_DIR}/Vundle.vim

sudo apt-get install astyle cppcheck pep8 pyflakes pylint || echo 'Not a Debian-based distro. Install desired tools on your own.'

vim +PluginInstall +qall

mkdir -p ~/.fonts
cp ${VIM_PLUGINS_DIR}/fonts/UbuntuMono/*.ttf ~/.fonts/
fc-cache -vf ~/.fonts/

mkdir -p ~/.vim/colors
cp solarized.vim ~/.vim/colors/

sudo apt-get install python-pip || (echo 'Not a Debian-based distro. Install Powerline on your own.' && exit)
pip install --user powerline-status
mkdir -p ~/.config/powerline
sed 's/"colorscheme": "default"/"colorscheme": "solarized"/g' <${VIM_PLUGINS_DIR}/powerline/powerline/config_files/config.json >~/.config/powerline/config.json
