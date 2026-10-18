#!/bin/sh
# Records the catalog preview at 100x30 the way av starts cbirds (no
# arguments: braille, the terminal's own colours), ended by SIGTERM, which
# cbirds answers by giving the terminal back. Needs asciinema 3.
#
#   asciiverse/record-preview.sh ./cbirds asciiverse/cbirds.cast [seed] [seconds]
set -eu
binary=$(cd "$(dirname "$1")" && pwd)/$(basename "$1")
out=$2
seed=${3:-1}
seconds=${4:-20}
home=$(mktemp -d)
trap 'rm -rf "$home"' EXIT
mkdir "$home/bin" && cp "$binary" "$home/bin/cbirds"
cd "$home"  # nothing in the recording names a local path
HOME="$home" PATH="$home/bin:$PATH" TERM=xterm-256color COLORTERM=truecolor LANG=C.UTF-8 \
asciinema rec --headless --overwrite -q \
  --window-size 100x30 --idle-time-limit 2 \
  --capture-env "TERM,COLORTERM,LANG" --title "cbirds" \
  --command "timeout --foreground -s TERM $seconds cbirds --seed $seed" \
  "$OLDPWD/$out"
