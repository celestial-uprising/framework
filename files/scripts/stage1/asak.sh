#!/usr/bin/env bash
set -oue pipefail

dnf5 install -y \
	cargo \
	rustc \
	gcc \
	git \
	alsa-lib-devel \
	jack-audio-connection-kit-devel

cargo install --root /tmp asak


