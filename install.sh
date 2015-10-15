#!/bin/bash
echo "This script will install the solarized color scheme, along with"
echo "home directory files.  The following files and directories will be"
echo "overwritten:"
echo "  ~/.bashrc"
echo "  ~/.vimrc"
echo "  ~/.colors"
echo "  ~/.git-ps1.sh"
echo "  ~/.vim/"
echo "  ~/.solarized"
echo
echo "Would you like to continue? (y/N)"
read yesno

if [[ $yesno != y ]]; then
    echo "Confirmation failed - aborting."
    exit 1; 
fi

echo "Linking home directory hidden files."
ln -f bashrc ~/.bashrc
ln -f vimrc ~/.vimrc
ln -f colors ~/.colors
ln -f git-ps1.sh ~/.git-ps1.sh

if [[ ! -d vim/bundle/vim-colors-solarized ]]; then
    mkdir -p vim/bundle
    cd vim/bundle
    git clone https://github.com/altercation/vim-colors-solarized.git
    cd ../..
fi

echo "Overwriting ~/.vim/"
rm -rf ~/.vim
cp -al vim ~/.vim

if [[ ! -d solarized ]]; then
    mkdir solarized
    cd solarized
    git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
    git clone https://github.com/seebi/dircolors-solarized.git
    cd ..
fi

echo "Overwriting ~/.solarized/"
rm -rf ~/.solarized
cp -al solarized ~/.solarized

if [[ $(dpkg-query -W -f='${Status}' dconf-cli 2>/dev/null | grep -c "ok installed") -eq 0 ]];
then
    apt-get install dconf-cli;
fi

echo "Changing terminal theme colors."
~/.solarized/gnome-terminal-colors-solarized/install.sh -s "dark" -p "Default" 
echo "Installation succesful. Most directory settings will take effect"
echo "in new terminal."
