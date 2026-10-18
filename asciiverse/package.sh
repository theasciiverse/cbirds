#!/bin/sh
# Packs ./cbirds into dist/cbirds-<target>.tar.gz for av: the binary at the
# top beside README, LICENSE and PATCHES.md.
#
#   asciiverse/package.sh x86_64-unknown-linux-musl
set -eu
cd "$(dirname "$0")/.."
target="$1"
stage=stage/cbirds
rm -rf "$stage" && mkdir -p "$stage" dist
cp cbirds README.md LICENSE PATCHES.md "$stage/"
tar -czf "dist/cbirds-$target.tar.gz" -C "$stage" .
ls dist
