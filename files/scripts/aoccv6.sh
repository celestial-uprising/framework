#!/usr/bin/env bash
set -euo pipefail

cat /tmp/aocc* > /tmp/aocc.rpm && \
    rpm -ivh --nodigest --nosignature /tmp/aocc.rpm && \
    rm -f /tmp/aocc*
