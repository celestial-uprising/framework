#!/usr/bin/env bash
set -oue pipefail

dnf5 install -y \
	cargo \
	curl \
	tar \
	gzip

curl -fsSL https://github.com/cargo-bins/cargo-binstall/releases/latest/download/cargo-binstall-x86_64-unknown-linux-musl.tgz | tar -xz -C /usr/bin cargo-binstall

cargo binstall --root /tmp --no-confirm \
	wrkflw \
	kmon \
	yazi-fm \
	yazi-cli \
	viddy \
	xan \
	doxx \
	xleak \
	serie \
	croft-software \
	upmd \
	herdr \
	llmfit \
	splashboard \
	xfr \
	eilmeldung \
	swaptop \
	gfold \
	lla \
	reknife \
	bookokrat \
	edamame \
	elio \
	termscp \
	zizmor \
	llamastash \
	papr-tui \
	rura
