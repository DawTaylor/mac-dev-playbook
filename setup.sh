#!/usr/bin/env bash

export PATH="$HOME/Library/Python/3.9/bin:/opt/homebrew/bin:$PATH"
sudo pip3 install --upgrade pip
pip3 install ansible
ansible-galaxy install -r requirements.yml
