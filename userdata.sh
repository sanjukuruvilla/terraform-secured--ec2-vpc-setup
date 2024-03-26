#!/bin/bash

# Update the package index and upgrade installed packages
sudo apt-get update
sudo apt-get upgrade -y

# Install Ansible
sudo apt-get install -y ansible
