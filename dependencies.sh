#!/bin/bash

if [ -f /etc/os-release ]; then
    . /etc/os-release
    ID=$ID
fi

if [ $ID = ubuntu ] || [ $ID = pop ] || [ $ID = elementary ]; then
sudo apt update -y && sudo apt upgrade -y && sudo apt install zsh i3 i3blocks alacritty picom feh -y

elif [ $ID = arch ] || [ $ID = manjaro ]
sudo pacman -Syu --noconfirm && sudo pacman -Syy --noconfirm && sudo pacman -S --noconfirm zsh i3 i3blocks alacritty picom feh

else
echo "Operating system not identified, try to install packages manually"
fi