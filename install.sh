#!/usr/bin/env bash

sudo apt update
sudo apt install software-properties-common git ansible curl zip unzip
ansible-playbook ./ubuntu.yml -JK
