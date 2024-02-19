#!/bin/bash

if [ -f /etc/os-release ]; then
    . /etc/os-release
    ID=$ID
fi

if [ $ID = ubuntu ] || [ $ID = pop ] || [ $ID = elementary ]; then
sudo apt update -y && sudo apt upgrade -y && sudo apt install zsh i3 i3blocks alacritty picom feh -y