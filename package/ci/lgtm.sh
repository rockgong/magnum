#!/bin/bash
set -ev

# Corrade
wget -O corrade-master.zip https://github.com/mosra/corrade/archive/master.tar.gz?cachebust=$(time +%s)
tar -xzvf corrade-master.zip

# Build Corrade
cd corrade-master
mkdir build && cd build
cmake .. \
    -DCMAKE_CXX_FLAGS="$CMAKE_CXX_FLAGS" \
    -DCMAKE_INSTALL_PREFIX=$HOME/deps \
    -DCMAKE_INSTALL_RPATH=$HOME/deps/lib \
    -DCMAKE_BUILD_TYPE=Debug \
    -DWITH_INTERCONNECT=OFF \
    -G Ninja
ninja install
cd ../..

mkdir build && cd build
cmake .. \
    -DCMAKE_INSTALL_PREFIX=$HOME/deps \
    -DCMAKE_BUILD_TYPE=Debug \
    -DWITH_AUDIO=ON \
    -DWITH_VK=OFF \
    -DWITH_GLFWAPPLICATION=ON \
    -DWITH_SDL2APPLICATION=ON \
    -DWITH_WINDOWLESSGLXAPPLICATION=ON \
    -DWITH_GLXCONTEXT=ON \
    -DWITH_OPENGLTESTER=ON \
    -DWITH_ANYAUDIOIMPORTER=ON \
    -DWITH_ANYIMAGECONVERTER=ON \
    -DWITH_ANYIMAGEIMPORTER=ON \
    -DWITH_ANYSCENEIMPORTER=ON \
    -DWITH_MAGNUMFONT=ON \
    -DWITH_MAGNUMFONTCONVERTER=ON \
    -DWITH_OBJIMPORTER=ON \
    -DWITH_TGAIMAGECONVERTER=ON \
    -DWITH_TGAIMPORTER=ON \
    -DWITH_WAVAUDIOIMPORTER=ON \
    -DWITH_DISTANCEFIELDCONVERTER=ON \
    -DWITH_FONTCONVERTER=ON \
    -DWITH_IMAGECONVERTER=ON \
    -DWITH_GL_INFO=ON \
    -DWITH_AL_INFO=ON \
    -DBUILD_TESTS=ON \
    -DBUILD_GL_TESTS=ON \
    -G Ninja

ninja
