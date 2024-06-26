#!/bin/bash

# packages
sudo apt-get update

# system
echo -e "\n\nInstalling daily system packages\n"
sudo apt-get install net-tools openssh-server
sudo apt-get install vim git git-lfs tmux curl
sudo apt-get install postgresql-client

# python
echo -e "\n\nInstalling Python-related system packages\n"
sudo apt-get install python3-pip

# python packages
echo -e "\n\nInstalling virtualenv Python packages\n"
pip3 install virtualenv

