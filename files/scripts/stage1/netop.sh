#!/usr/bin/env bash
set -oue pipefail

dnf5 install -y \
	cargo \
	rustc \
	pkg-config \
	make \
	gcc-c++ \
	cmake \
	libpcap-devel

cargo install --root /tmp netop


