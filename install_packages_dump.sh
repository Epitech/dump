#!/usr/bin/env bash

clear
echo "INSTALLING PACKAGES FOR EPITECH'S DUMP"
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
cat /etc/fedora-release | grep "Fedora release 38"
if [[ $? -ne 0 ]]; then
    echo "This script must be run onto a Fedora 38";
    exit 1
fi
echo "Press ENTER to continue..."
read

dnf upgrade -y

packages_list=(boost-devel.x86_64
               boost-static.x86_64
               ca-certificates.noarch
               clang.x86_64
               cmake.x86_64
               CUnit-devel.x86_64
               curl.x86_64
               flac-devel.x86_64
               freetype-devel.x86_64
               gcc.x86_64
               gcc-c++.x86_64
               gdb.x86_64
               git
               glibc.x86_64
               glibc-devel.x86_64
               glibc-locale-source.x86_64
               gmp-devel.x86_64
               ksh.x86_64
               elfutils-libelf-devel.x86_64
               libjpeg-turbo-devel.x86_64
               libvorbis-devel.x86_64
               SDL2.x86_64
               SDL2-static.x86_64
               SDL2-devel.x86_64
               libX11-devel.x86_64
               libXext-devel.x86_64
               ltrace.x86_64
               make.x86_64
               nasm.x86_64
               ncurses.x86_64
               ncurses-devel.x86_64
               ncurses-libs.x86_64
               net-tools.x86_64
               openal-soft-devel.x86_64
               python3-numpy.x86_64
               python3.x86_64
               rlwrap.x86_64
               ruby.x86_64
               strace.x86_64
               tar.x86_64
               tcsh.x86_64
               tmux.x86_64
               sudo.x86_64
               tree.x86_64
               unzip.x86_64
               valgrind.x86_64
               vim
               emacs-nox
               which.x86_64
               xcb-util-image.x86_64
               xcb-util-image-devel.x86_64
               zip.x86_64
               zsh.x86_64
               avr-gcc.x86_64
               qt-devel
               docker
               docker-compose
               java-17-openjdk
               java-17-openjdk-devel
               boost
               boost-math
               boost-graph
               autoconf
               automake
               tcpdump
               wireshark
               nodejs
               emacs-tuareg
               libvirt
               libvirt-devel
               virt-install
               haskell-platform
               golang
               systemd-devel
               libgudev-devel
               php.x86_64
               php-devel.x86_64
               php-bcmath.x86_64
               php-cli.x86_64
               php-gd.x86_64
               php-mbstring.x86_64
               php-mysqlnd.x86_64
               php-pdo.x86_64
               php-pear.noarch
               php-xml.x86_64
               php-gettext-gettext.noarch
               php-phar-io-version.noarch
               php-theseer-tokenizer.noarch
               SFML.x86_64
               SFML-devel.x86_64
               CSFML.x86_64
               CSFML-devel.x86_64
               irrlicht.x86_64
               irrlicht-devel.x86_64
               rust.x86_64
               cargo.x86_64
               mariadb-server.x86_64
               x264.x86_64
               lightspark.x86_64
               lightspark-mozilla-plugin.x86_64
               teams.x86_64)

dnf -y install ${packages_list[@]}

# Criterion
curl -sSL "https://github.com/Snaipe/Criterion/releases/download/v2.4.2/criterion-2.4.2-linux-x86_64.tar.xz" -o criterion-2.4.2.tar.xz
tar xf criterion-2.4.2.tar.xz
cp -r criterion-2.4.2/* /usr/local/
echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf
ldconfig
rm -rf criterion-2.4.2.tar.xz criterion-2.4.2/

# Gradle
wget https://services.gradle.org/distributions/gradle-7.2-bin.zip
mkdir /opt/gradle && unzip -d /opt/gradle gradle-7.2-bin.zip && rm -f gradle-7.2-bin.zip
echo 'export PATH=$PATH:/opt/gradle/gradle-7.2/bin' >> /etc/profile

# Stack
curl -sSL https://get.haskellstack.org/ | sh

# CONFIG EMACS
git clone https://github.com/Epitech/epitech-emacs.git
cd epitech-emacs
git checkout 278bb6a630e6474f99028a8ee1a5c763e943d9a3
./INSTALL.sh system
cd .. && rm -rf epitech-emacs

# CONFIG VIM
git clone https://github.com/Epitech/vim-epitech.git
cd vim-epitech
git checkout ec936f2a49ca673901d56598e141932fd309ddac
./install.sh
cd .. && rm -rf vim-epitech
