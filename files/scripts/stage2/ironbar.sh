#!/usr/bin/env bash
set -oue pipefail

mkdir -p /tmp/bin

dnf5 install -y \
	cargo \
	curl \
	tar 

curl -fsSL https://github.com/cargo-bins/cargo-binstall/releases/latest/download/cargo-binstall-x86_64-unknown-linux-musl.tgz | tar -xz -C /usr/bin cargo-binstall

cargo binstall --root /tmp ironbar
