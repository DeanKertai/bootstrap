#!/bin/bash

# Simple script for quickly installing my most used
# applications in a new install of Linux

cd ~

sudo apt update
sudo apt upgrade -y

# Some of these are snaps unfortunately. Might have to install snapd if this is Mint


read -p "Install snap store? (y/N) " install_snap
read -p "Install programming tools? (y/N) " install_programming
read -p "Install browsers? (y/N) " install_browsers
read -p "Install graphics and photography apps? (y/N) " install_graphics
read -p "Install games? (y/N) " install_games
read -p "Install Microsoft Teams? (y/N) " install_teams

# Unit conversion utility
sudo apt-get install units -y -qq

# Snapd (unfortunately required for some of these applications)
if [[ $install_snap =~ y|Y ]]; then

    # If this is Linux Mint 20, we need to enable snapd install
    NO_SNAP_PREF=/etc/apt/preferences.d/nosnap.pref
    if test -f "$NO_SNAP_PREF"; then
        echo 'Linux Mint detected. Disabling No-Snap preference'
        rm $NO_SNAP_PREF
        echo 'No-Snap pref file deleted'
    fi

    sudo apt install snapd -qq
fi

# Programming Tools
if [[ $install_programming =~ y|Y ]]; then
    # Git
    sudo apt-get -qq install git -y
    git config --global user.name "deankertai"
    git config --global user.email "deankertai@gmail.com"
    git config --global credential.helper store
        
    # IDEs and other programs
    sudo snap install --classic code
    sudo snap install postman
    sudo snap install pycharm-community --classic
    sudo snap install slack --classic
    sudo snap install teams-for-linux
    
    # AWS CLI
    echo 'Installing AWS CLI'
    sudo apt-get -qq install unzip -y
    curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -qq awscliv2.zip
    sudo ./aws/install
    rm awscliv2.zip
    sudo rm -r aws
    fi


# Browsers
if [[ $install_browsers =~ y|Y ]]; then
    sudo apt-get -qq install firefox -y
    sudo snap install chromium
fi


# Graphics and Photography
if [[ $install_graphics =~ y|Y ]]; then
    sudo apt-get -qq install darktable -y
    sudo apt-get -qq install gimp -y
    sudo apt-get -qq install kdenlive -y
fi


# Games
if [[ $install_games =~ y|Y ]]; then
    sudo apt-get -qq install steam -y
fi


# Teams
if [[ $install_teams =~ y|Y ]]; then
    sudo snap install teams-for-linux
fi
