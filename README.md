# diamondplated/homebrew-tap

Homebrew casks for my macOS apps.

```sh
brew tap diamondplated/tap
```

## Apps

| Cask | What it is | Requires |
|---|---|---|
| [`screenwren`](https://github.com/diamondplated/screenwren) | Fast, private, native screen capture — `⌃P`, click, it's on your clipboard | macOS 26+ |
| [`latent`](https://github.com/diamondplated/latent) | Folder-first photo viewer with a local AI enhancement pipeline | macOS 14+, Apple silicon |

```sh
brew install --cask --no-quarantine diamondplated/tap/screenwren
brew install --cask --no-quarantine diamondplated/tap/latent
```

## Why `--no-quarantine`

These apps are **ad-hoc signed, not notarized.** Notarizing requires an Apple Developer Program
membership, which these projects don't have.

Without the flag, Homebrew tags the download with macOS's quarantine attribute and Gatekeeper
refuses the first launch — you'd have to approve it manually under **System Settings → Privacy &
Security**. `--no-quarantine` skips that dance.

That flag is a real trust decision and it's yours to make, not mine to make quietly in a cask
`postflight`. Both apps are open source; build them yourself if you'd rather:

```sh
git clone https://github.com/diamondplated/screenwren && cd screenwren && ./build-app.sh
```

## Not here: Sift

[Sift](https://github.com/diamondplated/sift) — the local data-file explorer — isn't in this tap.
Its `.app` is a ~1 MB launcher that references a Python engine and its virtualenv rather than
bundling them, which is the right call for development and makes it non-relocatable. A cask can't
build from source, and a formula can't install a GUI app cleanly, so Sift installs from source:

```sh
git clone https://github.com/diamondplated/sift && cd sift && ./build-app.sh /Applications
```

## Uninstalling

```sh
brew uninstall --cask screenwren
brew uninstall --zap --cask screenwren    # also removes preferences
```
