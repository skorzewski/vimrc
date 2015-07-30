#!/bin/bash

PWD=`pwd`
VIM_PLUGINS_DIR=~/.vim/bundle

rm ~/.vimrc
ln -s ${PWD}/vimrc ~/.vimrc

sudo apt-get install astyle cppcheck pep8 pyflakes pylint

vim +PluginInstall +qall

cp ${VIM_PLUGINS_DIR}/fonts/UbuntuMono/*.ttf ~/.fonts/
fc-cache -vf ~/.fonts/

pip install --user powerline-status
mkdir ~/.config/powerline
sed 's/"colorscheme": "default"/"colorscheme": "solarized"/g' <${VIM_PLUGINS_DIR}/powerline/powerline/config_files/config.json >~/.config/powerline/config.json

cp solarized.vim ~/.vim/colors/
