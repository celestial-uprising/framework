#!/usr/bin/env bash
set -oue pipefail

dnf5 install -y \
	cargo \
	rustc \
	gcc \
	git

cargo install --root /tmp --git https://gitlab.com/snipedbywifi/terminactory


