#!/bin/sh
set -eu

base='https://corgi.computer'
version='20261026T042549Z-2ff6e1844c09'

# System-wide paths for atomic / bootc images
# /usr/bin for global command access, /var/lib for writable runtime updates/releases
root='/var/lib/corgi'
bin='/usr/bin/corgi'
dir=$(dirname "$bin")

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# Architecture & Checksum mapping from upstream script
case "$(uname -s)-$(uname -m)" in
Linux-x86_64)
  target=linux-x86_64
  expected='a2b2782e3c07fa87f41defb97bdc109f3522099b119a0937752cad31313c2edc'
  ;;
*)
  echo "Error: Corgi upstream installer only lists Linux-x86_64 for Linux architectures." >&2
  exit 1
  ;;
esac

echo "==> Downloading Corgi $version for $target..."
curl --disable -fsSL --proto '=https' --proto-redir '=https' \
  --connect-timeout 10 --max-time 300 "$base/releases/$version/corgi-$target" -o "$tmp/corgi"

# Verify checksum
if command -v sha256sum >/dev/null 2>&1; then
  actual=$(sha256sum "$tmp/corgi" | cut -d ' ' -f 1)
else
  actual=$(shasum -a 256 "$tmp/corgi" | cut -d ' ' -f 1)
fi

if [ "$actual" != "$expected" ]; then
  echo "Error: Corgi checksum mismatch!" >&2
  echo "Expected: $expected" >&2
  echo "Actual:   $actual" >&2
  exit 1
fi
echo "==> Checksum verified successfully."

# Fetch manifest and execute Corgi's internal installer
echo "==> Fetching manifest and running internal installer..."
curl --disable -fsSL --proto '=https' --proto-redir '=https' \
  "$base/releases/$version/manifest.json" -o "$tmp/manifest.json"

chmod 700 "$tmp/corgi"
"$tmp/corgi" __install "$root" "$tmp/manifest.json"

# Write system-wide launcher wrapper at /usr/bin/corgi
echo "==> Writing system launcher to $bin..."
mkdir -p "$dir"
quoted=$(printf %s "$root" | sed "s/'/'\\\\''/g")
cat >"$bin" <<EOF
#!/bin/sh
set -eu
root='$quoted'
v=\$(cat "\$root/current")
case "\$v" in ''|*[!0-9.a-fTZ-]*) echo 'Invalid Corgi version' >&2; exit 1;; esac
exec "\$root/releases/\$v/corgi" "\$@"
EOF
chmod 755 "$bin"

echo "==> Corgi installed successfully system-wide!"
