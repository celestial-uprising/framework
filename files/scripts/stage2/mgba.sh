#!/usr/bin/env bash
set -oue pipefail

dnf install -y --setopt=install_weak_deps=False \
	qt6-qtbase-devel \
	libzip-devel \
	libpng-devel \
	zlib-devel \
	SDL2-devel \
	freetype-devel \
	fontconfig-devel \
        gcc \
        gcc-c++ \
        cmake \
        make \
        git \
        qt6-qtbase-devel \
        libzip-devel \
        libpng-devel \
        zlib-devel \
        SDL2-devel && \
    dnf clean all && \
    rm -rf /var/cache/dnf

git clone https://github.com/mgba-emu/mgba.git /tmp/mgba

# --- PASS 1: Zen 3 ---
mkdir -p /tmp/mgba/build-zen3 && cd /tmp/mgba/build-zen3
cmake -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DUSE_GDB_STUB=OFF \
    -DUSE_DISCORD_RPC=OFF \
    -DUSE_LUA=OFF \
    -DUSE_FFMPEG=OFF \
    -DUSE_EDITLINE=OFF \
    -DBUILD_LIBRETRO=OFF \
    -DENABLE_QT=ON \
    -DCMAKE_C_FLAGS="-march=znver3 -O3 -flto -fuse-linker-plugin -ffast-math" \
    -DCMAKE_CXX_FLAGS="-march=znver3 -O3 -flto -fuse-linker-plugin -ffast-math" \
    ..
make -j$(nproc)
cp qt/mgba-qt /tmp/bin/mgba-qt-zen3

# --- PASS 2: AMD64v3 ---
mkdir -p /tmp/mgba/build-v3 && cd /tmp/mgba/build-v3
cmake -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DUSE_GDB_STUB=OFF \
    -DUSE_DISCORD_RPC=OFF \
    -DUSE_LUA=OFF \
    -DUSE_FFMPEG=OFF \
    -DUSE_EDITLINE=OFF \
    -DBUILD_LIBRETRO=OFF \
    -DENABLE_QT=ON \
    -DCMAKE_C_FLAGS="-march=x86-64-v3 -O3 -flto -fuse-linker-plugin -ffast-math" \
    -DCMAKE_CXX_FLAGS="-march=x86-64-v3 -O3 -flto -fuse-linker-plugin -ffast-math" \
    ..
make -j$(nproc)
cp qt/mgba-qt /tmp/bin/mgba-qt-v3

mkdir -p /tmp/hicolor/{16x16,32x32,48x48,64x64,128x128,256x256,512x512}/apps
mv /tmp/mgba/res/mgba-16.png   /tmp/hicolor/16x16/apps/io.mgba.mGBA.png
mv /tmp/mgba/res/mgba-32.png   /tmp/hicolor/32x32/apps/io.mgba.mGBA.png
mv /tmp/mgba/res/mgba-48.png   /tmp/hicolor/48x48/apps/io.mgba.mGBA.png
mv /tmp/mgba/res/mgba-64.png   /tmp/hicolor/64x64/apps/io.mgba.mGBA.png
mv /tmp/mgba/res/mgba-128.png  /tmp/hicolor/128x128/apps/io.mgba.mGBA.png
mv /tmp/mgba/res/mgba-256.png  /tmp/hicolor/256x256/apps/io.mgba.mGBA.png
mv /tmp/mgba/res/mgba-512.png  /tmp/hicolor/512x512/apps/io.mgba.mGBA.png
