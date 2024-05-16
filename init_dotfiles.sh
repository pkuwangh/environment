#!/bin/bash

# packages
sudo apt-get install -y tmux git-lfs

# git
git lfs install
git submodule update --init --recursive

# dotfiles
cp dotfiles/inputrc     ~/.inputrc
cp dotfiles/tmux.conf   ~/.tmux.conf
cp dotfiles/vimrc		~/.vimrc
cp dotfiles/gitconfig   ~/.gitconfig

if ! grep -Fsq "alias play" ~/.bashrc
then
	cat dotfiles/bashrc >> ~/.bashrc
fi

# path
mkdir -p ~/packages/bin
cp bin/tmux-session.py  ~/packages/bin/tmux-load
cp bin/tmux-session.py  ~/packages/bin/tmux-save

