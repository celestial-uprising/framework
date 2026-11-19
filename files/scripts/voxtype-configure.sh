#!/usr/bin/env bash
set -oue pipefail

mkdir -p /etc/voxtype/whisper/
XDG_DATA_HOME=/etc/voxtype/whisper voxtype setup --download --model base.en
