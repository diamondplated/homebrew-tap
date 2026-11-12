# diamondplated/homebrew-tap

Homebrew casks for my macOS apps.

```sh
brew tap diamondplated/tap
```

## Apps

| Cask | What it is | Requires |
|---|---|---|
| [`mac-tools`](https://github.com/diamondplated/mac-tools-releases) | One app that installs, updates and configures DockPeek, ScreenWren, ScrollSplit and LinkRoutes | macOS 14+ (ScreenWren 26+) |
| [`latent`](https://github.com/diamondplated/mac-apps/tree/main/Latent) | Folder-first photo viewer with a local AI enhancement pipeline | macOS 14+, Apple silicon |
| [`sift`](https://github.com/diamondplated/mac-apps/tree/main/Sift) | Drop a data file in, explore it instantly — DuckDB reads it in place | macOS 14+, Apple silicon |

```sh
brew install --cask diamondplated/tap/mac-tools
brew install --cask diamondplated/tap/latent
brew install --cask diamondplated/tap/sift
```

The standalone `screenwren` cask was removed on 2026-11-12: its last build (0.5.0) is out of date and
ScreenWren now ships inside Mac Tools. If you still have it installed, switch over:

```sh
brew uninstall --cask screenwren && brew install --cask diamondplated/tap/mac-tools
```

Mac Tools updates itself through Sparkle, so `brew upgrade` leaves it alone once installed.

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
  xattr -dr com.apple.quarantine "/Applications/Mac Tools.app"
  ```

The second option disables a macOS security check for that app. That's a real decision, and it's
yours — which is why these casks don't do it silently in a `postflight` block.

If you'd rather not make that decision at all, build from source. All of these apps live in
[diamondplated/mac-apps](https://github.com/diamondplated/mac-apps); the full suite needs macOS 26+
and Swift 6.2+:

```sh
git clone https://github.com/diamondplated/mac-apps && cd mac-apps && ./build-app.sh && ./install-app.sh --no-build
```

## What the tap is still good for

Even with the Gatekeeper step, the cask gets you versioned installs, `brew upgrade`, and a clean
`brew uninstall --zap` that removes preferences and saved state too.

## Upgrades

```sh
brew upgrade --cask
```

A daily workflow in this repo checks each app's latest GitHub release and bumps the cask's version
and `sha256` automatically, so a new upstream release reaches you without anyone editing a cask by
hand. It refuses to rewrite a cask if the download 404s or comes back implausibly small — a wrong
`sha256` here breaks installs for everybody.

`brew livecheck --cask diamondplated/tap/mac-tools` reports the upstream version on demand.

## Uninstalling

```sh
brew uninstall --cask mac-tools
brew uninstall --zap --cask mac-tools    # also removes preferences and saved state
```
