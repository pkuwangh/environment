#!/bin/bash

# driver
sudo apt-get install nvidia-driver-535

# install cuda
# https://developer.nvidia.com/cuda-downloads
sudo apt install cuda-toolkit-12-3

# install docker
# https://docs.docker.com/engine/install/ubuntu/
sudo usermod -aG docker $USER
docker image list

# install Nvidia Container Toolkit
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
sudo apt search nvidia-container-toolkit
# restart docker service
sudo systemctl restart docker.service

# check sources
ls /etc/apt/keyrings/
ls /etc/apt/sources.list.d/
