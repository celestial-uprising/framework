#!/usr/bin/env bash
set -oue pipefail

dnf5 install -y \
	cargo \
	rustc \
	pkg-config \
	openssl-devel \
	git

cargo install --root /tmp --git https://github.com/DingoOz/llm-visuals
