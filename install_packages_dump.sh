#!/usr/bin/env bash

clear

forceflag=false

while getopts 'f' flag; do
  case "${flag}" in
    f) forceflag=true ;;
    *) error "Invalid option ${flag}" ;;
  esac
done


echo "INSTALLING PACKAGES FOR EPITECH'S DUMP"
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

cat /etc/issue | ( grep "Ubuntu 23.10\|Ubuntu 24.04" )
if [[ $? -ne 0 ]]; then
    echo "This script must be run onto an Ubuntu 23.10 or 24.04";
    exit 1
fi
if [[ $forceflag == false ]]; then
    echo "Press ENTER to continue..."
    read
fi

add-apt-repository -y -s universe
apt update
apt upgrade -y

echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections

packages_list=(
    avr-libc
    build-essential
    ca-certificates-java
    cabal-install
    cargo
    clang
    clang-tools
    cmake
    diffutils
    docker-compose
    docker.io
    elfutils
    elpa-tuareg
    emacs-nox
    ffmpeg
    flac
    gcovr
    ghc
    golang
    haskell-stack
    ksh
    liballegro5-dev
    libboost1.74-all-dev
    libc-bin
    libc-dev-bin
    libc-devtools
    libc6
    libc6-dbg
    libc6-prof
    libcsfml-dev
    libcsfml-doc
    libcunit1
    libcunit1-dev
    libelf-dev
    libfreetype-dev
    libgmp-dev
    libgmp10
    libgmp10-doc
    libgmp3-dev
    libgmpxx4ldbl
    libgudev-1.0-dev
    libirrlicht-dev
    libirrlicht1.8
    libjpeg-turbo8-dev
    libncurses-dev
    libopenal-dev
    libsdl2-dev
    libsfml-doc
    libuuid1
    libvirt-dev
    libvorbis-dev
    libx11-doc
    libx11-xcb-dev
    libxcb-image0
    libxcb-image0-dev
    libxcb-util-dev
    libxcb-util0-dev
    libxcb-util1
    libxcursor-dev
    libxext-dev
    libxext-doc
    libxi-dev
    libxinerama-dev
    libxrandr-dev
    locales
    ltrace
    mariadb-server
    nasm
    ncurses-base
    net-tools
    npm
    nodejs
    openjdk-21-jdk
    openjdk-21-jre
    php-bcmath
    php-dev
    php-gd
    php-mbstring
    php-mysql
    php-phar-io-version
    php-php-gettext
    php-tokenizer
    python3
    python3-pycryptodome
    python3-dev
    python3-numpy
    python3-pip
    python3-pyte
    python3-requests
    python3-yaml
    qt6-base-dev
    qt6-base-dev-tools
    rlwrap
    ruby
    rustc
    strace
    sudo
    systemd-dev
    tar
    tcpdump
    tcsh
    tmux
    tree
    unzip
    uuid-dev
    valgrind
    vim
    virt-manager
    wireshark
    x264
    zip
    zsh
)

export DEBIAN_FRONTEND=noninteractive
apt -y install ${packages_list[@]}

## Microsoft teams

snap install teams-for-linux

## Bun

npm install -g bun

# Criterion
curl -sSL "https://github.com/Snaipe/Criterion/releases/download/v2.4.2/criterion-2.4.2-linux-x86_64.tar.xz" -o criterion-2.4.2.tar.xz
tar xf criterion-2.4.2.tar.xz
cp -r criterion-2.4.2/* /usr/local/
echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf
ldconfig
rm -rf criterion-2.4.2.tar.xz criterion-2.4.2/

# Gradle
if [[ ! -d "/opt/gradle/gradle-8.7" ]]; then
    wget https://services.gradle.org/distributions/gradle-8.7-bin.zip
    mkdir /opt/gradle && unzip -d /opt/gradle gradle-8.7-bin.zip && rm -f gradle-8.7-bin.zip
    echo 'export PATH=$PATH:/opt/gradle/gradle-8.7/bin' >> /etc/profile
fi

# CONFIG EMACS
git clone https://github.com/Epitech/epitech-emacs.git
cd epitech-emacs
git checkout 278bb6a630e6474f99028a8ee1a5c763e943d9a3
./INSTALL.sh system
cd .. && rm -rf epitech-emacs

# CONFIG VIM
git clone https://github.com/Epitech/vim-epitech.git
cd vim-epitech
git checkout b97cab4bd988dc2a8432664dd43b4656d9931ce3
./install.sh system
cd .. && rm -rf vim-epitech

# Coding style
wget https://raw.githubusercontent.com/Epitech/coding-style-checker/main/coding-style.sh -P /tmp/
chmod +x /tmp/coding-style.sh
mv /tmp/coding-style.sh /usr/local/bin/coding-style