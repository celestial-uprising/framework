#!/usr/bin/env bash
set -oue pipefail

dnf5 install -y \
	cargo \
	rustc \
	git

cargo install --root /tmp --git https://github.com/graiz/kittybrowser


