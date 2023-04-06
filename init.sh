#!/bin/bash

# packages
# sudo apt-get update
sudo apt-get install -y htop tmux git-lfs

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
	cat dotfiles/shrc >> ~/.bashrc
fi

# path
cp bin/*  ~/packages/bin/
