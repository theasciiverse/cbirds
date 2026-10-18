# cbirds (Asciiverse packaging)

Alessandro Palliccia's (clainstone) boids in braille, with Kitty-protocol
sprites as an option; C99, libc and libm only; MIT; packaged for the
Asciiverse catalog as a demo (kind `art`). Not our code: keep changes
small, list every one in PATCHES.md, and offer fixes upstream. Upstream
moves fast (several releases a week in October 2026).

- Remotes: `upstream` is github.com/clainstone/cbirds (branch `master`),
  `origin` is github.com/theasciiverse/cbirds.
- Branch `asciiverse` = upstream master plus our commits.
- Release: tag `v<version>-av.<n>` (now `v1.7.0+20261017-av.1`) and push
  only that tag; the workflow runs on `*-av.*` tags.
- av starts it as `cbirds`; Linux and macOS only.
- Build: `make`, `make test`. Static, in a copy of the tree:
  `docker run --rm --cpus 4 --memory 8g -v "$PWD":/src -w /src alpine:3.22
  sh -c 'apk add build-base && make CFLAGS=-O2 LDFLAGS="-static -s" cbirds
  && make test'` (the tests take a few minutes on musl).
- Preview: `asciiverse/record-preview.sh ./cbirds asciiverse/cbirds.cast`.
