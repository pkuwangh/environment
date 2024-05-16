#!/bin/bash

# packages
sudo apt-get update

# General
echo -e "\n\nInstalling daily system packages\n"
sudo apt-get install vim zip

# OIDC
echo -e "\n\nInstalling OIDC-related system packages\n"
sudo apt-get install xdg-utils wslu

# python
echo -e "\n\nInstalling Python-related system packages\n"
sudo apt-get install python3-pip

# python packages
echo -e "\n\nInstalling virtualenv Python packages\n"
pip3 install virtualenv

