#!/usr/bin/env bash

sudo apt update
sudo apt install software-properties-common git ansible curl zip unzip fd-find ripgrep
ansible-playbook ./ubuntu.yml -JK
