#!/usr/bin/env bash
set -oue pipefail

dnf install -y \
  protobuf-compiler \
  poppler-glib-devel \
  mpv-devel

git clone https://github.com/abenz1267/elephant.git /tmp/elephant
cd /tmp/elephant/cmd/elephant
env GOBIN=/tmp/bin go install elephant 

git clone https://github.com/abenz1267/walker.git /tmp/walker
cd /tmp/walker
cargo build --release --root /tmp
