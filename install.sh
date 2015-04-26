cp -al bashrc ~/.bashrc
cp -al vim ~/.vim
cp -al vimrc ~/.vimrc
cp -al solarized ~/.solarized

# The following installs the solarized dark theme to the 2nd terminal profile
~/.solarized/gnome-terminal-colors-solarized/install.sh -s "dark" -p "Default" 
eval `dircolors ~/.solarized/dircolors-solarized/dircolors.256dark` 
