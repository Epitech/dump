#!/usr/bin/env bash

clear

echo "INSTALLING TOOLS AND PACKAGES FOR EPITECH'S DUMP"
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

cat /etc/issue | ( grep "Ubuntu 24.04" ) > /dev/null
if [[ $? -ne 0 ]]; then
    echo "This script must be run onto an Ubuntu 24.04";
    exit 1
fi

###################
## Cache usage only for PXE
## Install netcat to prepare cache usage
#apt update
#apt install -y netcat-openbsd
#
## Install proxy detection
#echo '#!/bin/bash
#proxy=192.168.42.1
#nc -zw1 $proxy 3142 && echo http://$proxy:3142/ || echo DIRECT
#' > /etc/apt/detect_proxy.sh
#
#chmod +x /etc/apt/detect_proxy.sh
#
#echo 'Acquire::http::Proxy-Auto-Detect "/etc/apt/detect_proxy.sh";' > "/etc/apt/apt.conf.d/01acng"
#
##################

# Add epitech ppa repository
add-apt-repository -y -s ppa:epitech/ppa

# Enable universe
add-apt-repository -y -s universe

# Reload package cache
apt update

# Install 
echo "postfix postfix/mailname string epitech.eu" | debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
export DEBIAN_FRONTEND=noninteractive
apt install -y epitech-cpool
apt install -y epitech-emacs
apt install -y epitech-vim

apt purge -y postfix

## clang-20
apt install -y wget
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/llvm.asc
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/llvm.asc] https://apt.llvm.org/noble/ llvm-toolchain-noble-20 main" | tee /etc/apt/sources.list.d/llvm.list
## epiclang
wget -O - https://epitech.github.io/epiclang/key.asc | sudo tee /etc/apt/trusted.gpg.d/epiclang-apt.asc
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/epiclang-apt.asc] https://epitech.github.io/epiclang/ testing main" | sudo tee /etc/apt/sources.list.d/epiclang.list
apt install -y clang-20 epiclang
