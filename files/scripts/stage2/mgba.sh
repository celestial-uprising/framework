#!/usr/bin/env bash
set -oue pipefail

dnf install -y --setopt=install_weak_deps=False \
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

git clone --depth 1 https://github.com/mgba-emu/mgba.git /tmp/mgba

# --- PASS 1: Zen 3 ---
mkdir -p /tmp/mgba/build-zen3 && cd /tmp/mgba/build-zen3
cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DCMAKE_BUILD_TYPE=Release \
        -DUSE_FFMPEG=OFF \
        -DUSE_LUA=OFF \
        -DUSE_EDITLINE=OFF \
        -DBUILD_LIBRETRO=OFF \
        -DCMAKE_C_FLAGS="-march=znver3 -O3 -flto -fuse-linker-plugin -ffast-math" \
        -DCMAKE_CXX_FLAGS="-march=znver3 -O3 -flto -fuse-linker-plugin -ffast-math" \
        ..
make -j$(nproc)
cp qt/mgba-qt /tmp/bin/mgba-qt-zen3

# --- PASS 2: AMD64v3 ---
mkdir -p /tmp/mgba/build-v3 && cd /tmp/mgba/build-v3
cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DCMAKE_BUILD_TYPE=Release \
        -DUSE_FFMPEG=OFF \
        -DUSE_LUA=OFF \
        -DUSE_EDITLINE=OFF \
        -DBUILD_LIBRETRO=OFF \
        -DCMAKE_C_FLAGS="-march=x86-64-v3 -O3 -flto -fuse-linker-plugin -ffast-math" \
        -DCMAKE_CXX_FLAGS="-march=x86-64-v3 -O3 -flto -fuse-linker-plugin -ffast-math" \
        ..
make -j$(nproc)
cp qt/mgba-qt /tmp/bin/mgba-qt-v3
make install
