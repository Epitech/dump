#!/usr/bin/env bash

clear

echo "INSTALLING TOOLS AND PACKAGES FOR EPITECH'S DUMP"
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

cat /etc/issue | ( grep "Ubuntu 26.04" ) > /dev/null
if [[ $? -ne 0 ]]; then
    echo "This script must be run onto an Ubuntu 26.04";
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
export DEBIAN_FRONTEND=noninteractive

# postfix arrives as a recommend of mailutils (itself recommended by emacs-bin-common,
# pulled in by epitech-emacs) and is not needed here; block it for the duration of the
# installs so every other recommend is still honoured
cat > /etc/apt/preferences.d/99-no-postfix <<'EOF'
Package: postfix
Pin: release *
Pin-Priority: -1
EOF

apt install -y epitech-cpool
apt install -y epitech-emacs
apt install -y epitech-vim

rm -f /etc/apt/preferences.d/99-no-postfix

# clang-20 comes in via epitech-cpool (banana-coding-style-checker);
# make bare `clang` resolve to it
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-20 100 && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-20 100

snap install teams-for-linux
