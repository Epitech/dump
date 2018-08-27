#!/bin/sh

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

GRAPH_LIB_NAME="libc_graph_prog.so"

SFML_SOURCE_URL="http://www.sfml-dev.org/files/SFML-2.4.2-sources.zip"
CSFML_SOURCE_URL="http://www.sfml-dev.org/files/CSFML-2.4-sources.zip"

CSFML_ZIP="CSFML.zip"
SFML_ZIP="SFML.zip"

echo "Download SFML Sources"
curl -Lo "$SFML_ZIP" $SFML_SOURCE_URL
echo "Download CSFML Sources"
curl -Lo "$CSFML_ZIP" $CSFML_SOURCE_URL

echo "Unzip SFML"
unzip -qq -o $SFML_ZIP
echo "Unzip CSFML"
unzip -qq -o $CSFML_ZIP

mv SFML-* SFML
mv CSFML-* CSFML

SFML_PATH="$(realpath SFML)"
CSFML_PATH="$(realpath CSFML)"

echo "SFML Compilation"
cd SFML
cmake -DBUILD_SHARED_LIBS=False -DCMAKE_CXX_FLAGS="-fPIC" .
cmake .
make
# make install
cd ..

echo "CSFML Compilation"
cd CSFML
cmake -DCMAKE_CXX_FLAGS="-fPIC" -DSFML_STATIC_LIBRARIES=TRUE -DBUILD_SHARED_LIBS=FALSE -DSFML_ROOT="$SFML_PATH" -DSFML_INCLUDE_DIR="$SFML_PATH/include" -DCMAKE_MODULE_PATH="$SFML_PATH/cmake/Modules" .
LD_LIBRARY_PATH="$SFML_PATH/lib"
make
#make install
cd ..

echo "Building Graphical Programming Library"
g++ -Wl,--whole-archive \
		"$CSFML_PATH/lib/libcsfml-audio.a" \
		"$CSFML_PATH/lib/libcsfml-graphics.a" \
		"$CSFML_PATH/lib/libcsfml-system.a" \
		"$CSFML_PATH/lib/libcsfml-window.a" \
		"$CSFML_PATH/lib/libcsfml-network.a" \
	        "$SFML_PATH/lib/libsfml-audio-s.a" \
		"$SFML_PATH/lib/libsfml-graphics-s.a" \
		"$SFML_PATH/lib/libsfml-system-s.a" \
		"$SFML_PATH/lib/libsfml-window-s.a" \
		"$SFML_PATH/lib/libsfml-network-s.a" \
		-Wl,--no-whole-archive -shared -o $GRAPH_LIB_NAME \
		-lFLAC \
		-lfreetype \
		-lGL \
		-ljpeg \
		-logg \
		-lopenal \
		-lpthread \
		-lrt \
		-ludev \
		-lvorbis \
		-lvorbisenc \
		-lvorbisfile \
		-lX11 \
		-lXrandr \
		-lX11-xcb \
		-lxcb \
		-lxcb-image \
		-lxcb-randr \
		-lXext \
		-lgcc_s \
		-lgcc

mv $GRAPH_LIB_NAME /usr/local/lib64/.

echo "/usr/local/lib64/" > /etc/ld.so.conf.d/csfml.conf

# Update the Dynamic Linker Run Time Bindings
ldconfig

echo "Install real CSFM"
rm -rf "$CSFML_PATH"
unzip -qq -o "$CSFML_ZIP"
mv CSFML-* CSFML

cd CSFML
cmake -DCMAKE_MODULE_PATH="$SFML_PATH/cmake/Modules" .
make
make install
cd ..


rm -rf "$CSFML_ZIP" "$CSFML_PATH" "$SFML_ZIP" "$SFML_PATH"
