# homebrew-tap

Homebrew tap for [Coder CLI](https://github.com/tjcoder-labs/cli), the
terminal-first AI coding assistant by TJ Coder / AI Labs.

## Install

```bash
brew tap tjcoder-labs/tap
brew install coder
```

## Update

```bash
brew upgrade coder
```

## Formula layout

- `Formula/coder.rb` — the `coder` formula (stable release).

## Bumping a version

The CLI release watcher (running on apiv2) regenerates the sha256s and
bumps the formula automatically on each release. To do it manually:

1. Bump `VERSION_TAG` in `Formula/coder.rb` to the new tag.
2. Regenerate the four sha256 values:
   ```bash
   for a in darwin_amd64 darwin_arm64 linux_amd64 linux_arm64; do
     echo -n "$a: "
     curl -fsSL "https://github.com/tjcoder-labs/cli/releases/download/vNEW/coder_vNEW_$a.tar.gz" | shasum -a 256
   done
   ```
3. Commit and push.
