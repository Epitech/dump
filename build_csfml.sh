#! /bin/sh

GRAPH_LIB_NAME="libc_graph_prog.so"

SFML_SOURCE_URL="http://www.sfml-dev.org/files/SFML-2.3.2-sources.zip"
CSFML_SOURCE_URL="http://www.sfml-dev.org/files/CSFML-2.3-sources.zip"

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

SFML_PATH="`pwd`/SFML"
CSFML_PATH="`pwd`/CSFML"

echo "SFML Compilation"
cd SFML
# WARNING - START PATCH FOR __cpu_model symbol problem
echo "PATCH SFML CMake to fix a problem with __cpu_model"
CSFML_PATCH='
diff --git a/src/SFML/Graphics/CMakeLists.txt b/src/SFML/Graphics/CMakeLists.txt
index 6f02fb6..61638d2 100644
--- a/src/SFML/Graphics/CMakeLists.txt
+++ b/src/SFML/Graphics/CMakeLists.txt
@@ -150,6 +150,10 @@ if(SFML_COMPILER_GCC)
     set_source_files_properties(${SRCROOT}/ImageLoader.cpp PROPERTIES COMPILE_FLAGS -fno-strict-aliasing)
 endif()
 
+if (SFML_COMPILER_GCC)
+    list(APPEND GRAPHICS_EXT_LIBS "-lgcc_s -lgcc")
+endif()
+
 # define the sfml-graphics target
 sfml_add_library(sfml-graphics
                  SOURCES ${SRC} ${DRAWABLES_SRC} ${RENDER_TEXTURE_SRC} ${STB_SRC}
'
patch -p1 <<< $(echo "$CSFML_PATCH")
# WARNING - END OF PATCH
cmake -DBUILD_SHARED_LIBS=False -DCMAKE_CXX_FLAGS="-fPIC" .
make
make install
cd ..

echo "CSFML Compilation"
echo $SFML_PATH
cd CSFML
cmake -DCMAKE_CXX_FLAGS="-fPIC" -DSFML_STATIC_LIBRARIES=TRUE -DBUILD_SHARED_LIBS=False -DSFML_ROOT="$SFML_PATH" -DSFML_INCLUDE_DIR="$SFML_PATH/include" -DCMAKE_MODULE_PATH="$SFML_PATH/cmake/Modules" .
LD_LIBRARY_PATH="$SFML_PATH/lib"
make
make install
cd ..

echo "Building Graphical Programming Library"
g++ -Wl,--whole-archive \
		CSFML/lib/libcsfml-audio.a \
		CSFML/lib/libcsfml-graphics.a \
		CSFML/lib/libcsfml-system.a \
		CSFML/lib/libcsfml-window.a \
		CSFML/lib/libcsfml-network.a \
		SFML/lib/libsfml-audio-s.a \
		SFML/lib/libsfml-graphics-s.a \
		SFML/lib/libsfml-system-s.a \
		SFML/lib/libsfml-window-s.a \
		SFML/lib/libsfml-network-s.a \
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
		-lX11-xcb \
		-lxcb \
		-lxcb-image \
		-lxcb-randr \
		-lXext \
		-lgcc_s \
		-lgcc

cp $GRAPH_LIB_NAME /usr/local/lib/.

echo "/usr/local/lib/" > /etc/ld.so.conf.d/csfml.conf

# Update the Dynamic Linker Run Time Bindings
ldconfig

rm -rf "$CSFML_ZIP" "$CSFML_PATH" "$SFML_ZIP" "$SFML_PATH"
