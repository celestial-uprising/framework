#!/usr/bin/env bash
set -oue pipefail

dnf5 install -y \
	golang \
	git

raelynn="env GOBIN=/tmp/bin go install"

$raelynn github.com/moezdil/siltide@latest
$raelynn github.com/szktkfm/mdtt/cmd/mdtt@latest
$raelynn github.com/termkit/gama@latest
$raelynn github.com/jesseduffield/lazygit@latest
$raelynn github.com/charmbracelet/glow/v2@latest
$raelynn github.com/kencx/keyb@latest
$raelynn github.com/chojs23/ec/cmd/ec@latest
$raelynn github.com/alvinunreal/lazyskills/cmd/lazyskills@latest
$raelynn github.com/edoardottt/cariddi/cmd/cariddi@latest
$raelynn github.com/fumiyas/qrc/cmd/qrc@latest
$raelynn github.com/B33pBeeps/redthread/cmd/redthread@latest
$raelynn github.com/yutat23/lsoff@latest
$raelynn github.com/Gaurav-Gosain/tuios/cmd/tuios@latest
$raelynn github.com/Gaurav-Gosain/tuios/cmd/tuios-web@latest
$raelynn github.com/Ri4dH/failtrace/cmd/failtrace@latest
$raelynn github.com/pedrosousa13/onda@latest
$raelynn github.com/halpworld/halpradio@latest
