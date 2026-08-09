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
brew install --cask diamondplated/tap/screenwren
brew install --cask diamondplated/tap/latent
```

## Read this before you install: macOS will block the first launch

These apps are **ad-hoc signed, not notarized.** Notarizing requires an Apple Developer Program
membership, which these projects don't have.

Homebrew 6 applies macOS's quarantine attribute to every cask and **removed the `--no-quarantine`
opt-out**, so there is no flag that avoids this. After installing, the first launch will be refused
by Gatekeeper. Approve it once, whichever way you prefer:

- **Open it, then go to System Settings → Privacy & Security and click "Open Anyway."** macOS
  remembers the decision.
- **Or strip the attribute yourself**, if you trust the build:
  ```sh
  xattr -dr com.apple.quarantine /Applications/ScreenWren.app
  ```

The second option disables a macOS security check for that app. That's a real decision, and it's
yours — which is why these casks don't do it silently in a `postflight` block.

If you'd rather not make that decision at all, build from source. Both repos build in one command
with no dependencies beyond Xcode:

```sh
git clone https://github.com/diamondplated/screenwren && cd screenwren && ./build-app.sh
```

## What the tap is still good for

Even with the Gatekeeper step, the cask gets you versioned installs, `brew upgrade`, and a clean
`brew uninstall --zap` that removes preferences and saved state too.

## Not here: Sift

[Sift](https://github.com/diamondplated/sift) — the local data-file explorer — isn't in this tap.
Its `.app` is a ~1 MB launcher that references a Python engine and its virtualenv rather than
bundling them, which is the right call for development and makes it non-relocatable. A cask can't
build from source and a formula can't install a GUI app cleanly, so Sift installs from source:

```sh
git clone https://github.com/diamondplated/sift && cd sift && ./build-app.sh /Applications
```

## Uninstalling

```sh
brew uninstall --cask screenwren
brew uninstall --zap --cask screenwren    # also removes preferences and saved state
```
