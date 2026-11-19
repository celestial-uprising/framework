#!/usr/bin/env bash
set -oue pipefail

mkdir -p /tmp/bin

dnf5 install -y \
	cargo \
	rustc \
	pkg-config \
	make \
	gcc \
	gtk4-devel \
	gtk4-layer-shell-devel \
	dbus-devel \
	pkgconf-pkg-config \
	pulseaudio-libs-devel \
	libinput-devel \
	libevdev-devel \
	luajit-devel

cargo install --root /tmp ironbar
