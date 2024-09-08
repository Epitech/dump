#!/usr/bin/env bash

clear

echo "INSTALLING TOOLS AND PACKAGES FOR EPITECH'S DUMP"
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

cat /etc/issue | ( grep "Ubuntu 23.10\|Ubuntu 24.04" ) > /dev/null
if [[ $? -ne 0 ]]; then
    echo "This script must be run onto an Ubuntu 23.10 or 24.04";
    exit 1
fi

# Install netcat to prepare cache usage
apt update
apt install -y netcat-openbsd

# Install proxy detection
echo '#!/bin/bash
proxy=192.168.42.1
nc -zw1 $proxy 3142 && echo http://$proxy:3142/ || echo DIRECT
' > /etc/apt/detect_proxy.sh

chmod +x /etc/apt/detect_proxy.sh

echo 'Acquire::http::Proxy-Auto-Detect "/etc/apt/detect_proxy.sh";' > "/etc/apt/apt.conf.d/01acng"

# Add epitech ppa signing key and repository
gpg --homedir /tmp --no-default-keyring --keyring /etc/apt/trusted.gpg.d/epitechppa.gpg --keyserver keyserver.ubuntu.com --recv-keys 87daad0e2657726c
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/epitechppa.gpg] https://ppa.launchpadcontent.net/epitech/ppa/ubuntu ./devel main" | tee /etc/apt/sources.list.d/epitechppa.list > /dev/null
echo "deb-src [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/epitechppa.gpg] https://ppa.launchpadcontent.net/epitech/ppa/ubuntu ./devel main" >> /etc/apt/sources.list.d/epitechppa.list > /dev/null

# Enable universe
add-apt-repository -y -s universe

# Reload package cache
apt update

# Install 
export DEBIAN_FRONTEND=noninteractive
apt install -y epitech-dump
