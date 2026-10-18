# Changes from upstream

This is the Asciiverse packaging of [cbirds](https://github.com/clainstone/cbirds)
by Alessandro Palliccia (clainstone), Craig Reynolds' boids drawn in braille
in any terminal, and as sprites in Kitty and Ghostty (C99, the C library
and libm, nothing else). Upstream is the `upstream` remote; the
`asciiverse` branch carries the changes below.

Built from upstream `master` at `d0b5b1c` (2026-10-17), the newest commit
when this was packaged (2026-10-18). It is four commits after the v1.7.0
tag (2026-10-12) and they touch only the README, its docs and a Nix flake,
so the program is v1.7.0's; the version here is 1.7.0+20261017. Upstream is
very active: take the newest commit, or the newest tag, when updating.

## Licence

MIT, "Copyright (c) 2025 clainstone@icloud.com" in LICENSE, which the
archives carry. The README's credits say much of the code, tests and
documentation was written by language models under the author's direction;
that does not change the licence. The one piece of artwork, `matrix.png`
(a red arrowhead the embedded sprite is made from), came in the author's
first commit.

## Code

None. cbirds already quits cleanly: `q` sends the flock off the top of the
screen and exits in about a second with status 0, and SIGINT, SIGTERM and
SIGHUP put the terminal back before exiting (checked in tmux: echo, line
editing and the screen restored each time). Ctrl+C arrives as SIGINT.
Other keys steer the sliders, presets and birds, so not every key quits;
`--screensaver` makes any key, click or pointer movement quit at once, and
is left for those who want it.

## Tests

- **The termios structs are zeroed before they are compared.** Two tests
  in `tests/boids_test.c` compare `c_cc` before and after a run. musl's
  `tcgetattr` fills only the kernel's 19 control characters, so the rest
  of both structs was stack garbage and the comparison failed in Alpine
  though the terminal was put back exactly; glibc clears the rest itself.
  Worth offering upstream.

## Packaging

- Upstream's workflows (`tests.yml` on every push, `install.yml` weekly,
  which installs upstream's own Homebrew and apt packages) are removed:
  in this repo they would test upstream's channels, not this build.
- `asciiverse/package.sh` packs one target for av: the binary, README,
  LICENSE and this file.
- `.github/workflows/release.yml`: av archives for Linux (static musl,
  x86-64 and ARM64, built in Alpine, upstream's tests run there) and macOS
  (x86-64 and ARM64), plus SHA256SUMS. No Windows: cbirds needs termios
  and upstream supports Linux and macOS only. Runs on our tags only
  (`*-av.*`).
- `asciiverse/record-preview.sh` records `asciiverse/cbirds.cast`, the
  catalog preview: 20 seconds of `cbirds --seed 1` at 100x30, ended by
  SIGTERM.

av starts it as `cbirds` with no arguments: braille in the terminal's own
colours, mouse scatters the flock, `h` opens the sliders, `q` quits.

## Checked

- Linux: native build (glibc) and static build (Alpine 3.22), upstream's
  tests pass on both (on musl after the fix above); in tmux at 100x30, `q`
  quits in about a second with status 0, Ctrl+C (exit 130) and SIGTERM
  (exit 143) quit with the terminal settings put back.
- macOS: not built here.
