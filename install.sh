#!/usr/bin/env bash

sudo apt update
sudo apt install software-properties-common git ansible curl
ansible-playbook ./ubuntu.yml -JK
