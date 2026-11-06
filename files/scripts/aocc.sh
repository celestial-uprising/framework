#!/usr/bin/env bash
set -euo pipefail
cd /tmp
cat aocc-compiler-5.2.0-1.x86_64.rpm.chunk_* >aocc-compiler-5.2.0-1.x86_64.rpm
rpm_path="aocc-compiler-5.2.0-1.x86_64.rpm"
if [[ ! -f "$rpm_path" ]]; then
  echo "ERROR: $rpm_path not found. Run assemble.sh first."
  exit 1
fi
rpm -ivh --nodigest --nosignature "$rpm_path"
rm -f aocc-compiler-5.2.0-1.x86_64.rpm
