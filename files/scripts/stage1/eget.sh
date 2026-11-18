#!/usr/bin/env bash
set -oue pipefail

mkdir /tmp/eget
cd /tmp/eget

curl https://zyedidia.github.io/eget.sh | sh

./eget hanshuaikang/nping
./eget timkicker/podliner
./eget RivoLink/leaf
./eget matthart1983/kernwatch
./eget nasedkinpv/numr
./eget wentbackward/nv-monitor
./eget nektos/act

cp ./nping /tmp/bin
cp ./podliner /tmp/bin
cp ./leaf /tmp/bin
cp ./kernwatch /tmp/bin
cp ./numr /tmp/bin
cp ./nv-monitor /tmp/bin
cp ./act /tmp/bin
