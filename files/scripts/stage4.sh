#!/usr/bin/env bash
set -oue pipefail

dnf upgrade -y && dnf install -y \
    cargo \
    rust \
    git \
    gcc \
    pkg-config \
    gtk4-devel \
    gtk4-layer-shell-devel \
    pango-devel \
    cairo-devel

git clone https://github.com/anyrun-org/anyrun /tmp/anyrun
cd /tmp/anyrun
cargo build --release
cp /tmp/anyrun/target/release/anyrun /tmp/bin/anyrun
mkdir -p /tmp/anyrun-plugins
cp /tmp/anyrun/target/release/*.so /tmp/anyrun-plugins/

