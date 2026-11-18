#!/usr/bin/env bash
set -oue pipefail

curl -fsSL "https://github.com/pulkitsharma07/solipsist/releases/latest/download/solipsist-linux-x64.tar.gz" -o "/tmp/solipsist.tar.gz"
tar xzf /tmp/solipsist.tar.gz -C /tmp/
cp /tmp/solipsist*/solipsist /tmp/bin/solipsist
chmod +x /tmp/bin/solipsist
