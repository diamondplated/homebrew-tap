cask "latent" do
  version "0.1.0"
  sha256 "e72bfc827a7b8a688da66c357f6fa83815d856c017ad62d106042f7dbaafdb58"

  url "https://github.com/diamondplated/latent/releases/download/v#{version}/Latent-#{version}.zip",
      verified: "github.com/diamondplated/latent/"
  name "Latent"
  desc "Folder-first photo viewer with a local AI enhancement pipeline"
  homepage "https://github.com/diamondplated/latent"

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Latent.app"

  uninstall quit: "com.diamondplated.latent"

  zap trash: [
    "~/Library/Preferences/com.diamondplated.latent.plist",
    "~/Library/Saved Application State/com.diamondplated.latent.savedState",
    "~/Library/Application Support/Latent",
  ]

  caveats <<~EOS
    Latent is ad-hoc signed, not notarized — this project has no Apple
    Developer ID — and Homebrew 6 always applies macOS's quarantine attribute
    with no opt-out. So macOS WILL block the first launch.

    Approve it once, either way:

      • Open it, then go to System Settings → Privacy & Security and click
        "Open Anyway", or
      • Remove the attribute yourself, if you trust this build:
          xattr -dr com.apple.quarantine /Applications/Latent.app

    That second one disables a macOS security check for this app. It is your
    call to make deliberately, which is why it is not done for you here.

    The AI enhancement stages need model weights that are NOT bundled. Without
    them Latent still works: Sharpen runs classically, Upscale falls back to
    Lanczos, and the rest pass through. To enable them, clone the repo and run
    scripts/setup_models.sh (~1.2 GB, one time).

    Read THIRD_PARTY_MODELS.md before shipping anything commercial built on the
    face-restore stage — GFPGAN's license has non-commercial carve-outs.
  EOS
end
