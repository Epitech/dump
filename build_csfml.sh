#!/usr/bin/env bash

set -e

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

CSFML_SOURCE_URL="http://www.sfml-dev.org/files/CSFML-2.5-sources.zip"

CSFML_ZIP="/tmp/CSFML.zip"
CSFML_DIR="/tmp/CSFML-2.5"

echo "Download CSFML Sources to $CSFML_ZIP"
curl -Lo "$CSFML_ZIP" $CSFML_SOURCE_URL

echo "Unzip CSFML to $CSFML_DIR"
unzip -qq -o $CSFML_ZIP -d /tmp

echo "CSFML Compilation"
cd $CSFML_DIR
cmake .
make

echo "CSFML Installation"
make install

echo "ld.so configuration"
echo "/usr/local/lib/" > /etc/ld.so.conf.d/csfml.conf

# Update the Dynamic Linker Run Time Bindings
ldconfig

# Clean
rm -rf "$CSFML_ZIP" "$CSFML_PATH"
