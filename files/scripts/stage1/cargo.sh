#!/usr/bin/env bash
set -oue pipefail

dnf5 install -y \
	cargo \
	rustc \
	pkg-config \
	make \
	gcc-c++ \
	cmake \
	libpcap-devel \
	alsa-lib-devel

ingrid="cargo install --root /tmp"

$ingrid netop
$ingrid terminal_gameboy
