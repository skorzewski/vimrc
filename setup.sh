#!/bin/bash

PWD=`pwd`

rm ~/.vimrc
ln -s ${PWD}/vimrc ~/.vimrc

sudo apt-get install astyle cppcheck pep8 pyflakes pylint
