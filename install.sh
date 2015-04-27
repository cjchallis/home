#!/bin/bash
cp -al bashrc ~/.bashrc
cp -al vimrc ~/.vimrc

cd vim/bundle
git clone https://github.com/altercation/vim-colors-solarized.git
cd ..
cd ..
rm -rf ~/.vim
cp -al vim ~/.vim

mkdir solarized
cd solarized
git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
git clone https://github.com/seebi/dircolors-solarized.git
cd ..
rm -rf ~/.solarized
cp -al solarized ~/.solarized

~/.solarized/gnome-terminal-colors-solarized/install.sh -s "dark" -p "Default" 
