cask "mac-tools" do
  version "1.2.1"
  sha256 "daf4b926daef5209b349f5f1461f86c7c936aab9585b2cb578bff455e1d6bfb1"

  url "https://github.com/diamondplated/mac-tools-releases/releases/download/v#{version}/Mac-Tools-#{version}.zip",
      verified: "github.com/diamondplated/mac-tools-releases/"
  livecheck do
    url :url
    strategy :github_latest
  end

  name "Mac Tools"
  desc "Installs, updates and configures DockPeek, ScreenWren, ScrollSplit and LinkRoutes"
  homepage "https://github.com/diamondplated/mac-tools-releases"

  # Sparkle updates the app in place, so brew upgrade leaves it alone.
  auto_updates true
  depends_on macos: :sonoma

  app "Mac Tools.app"

  uninstall quit: "com.andrew.mactools"

  zap trash: [
    "~/Library/Application Support/Mac Tools",
    "~/Library/Caches/com.andrew.mactools",
    "~/Library/HTTPStorages/com.andrew.mactools",
    "~/Library/Preferences/com.andrew.mactools.plist",
    "~/Library/Saved Application State/com.andrew.mactools.savedState",
  ]

  caveats <<~EOS
    Mac Tools is signed with a local certificate, not notarized — this project
    has no Apple Developer ID — and Homebrew 6 always applies macOS's
    quarantine attribute with no opt-out. So macOS WILL block the first launch.

    Approve it once, either way:

      • Open it, then go to System Settings → Privacy & Security and click
        "Open Anyway", or
      • Remove the attribute yourself, if you trust this build:
          xattr -dr com.apple.quarantine "/Applications/Mac Tools.app"

    That second one disables a macOS security check for this app. It is your
    call to make deliberately, which is why it is not done for you here.

    Mac Tools installs DockPeek, ScreenWren, ScrollSplit and LinkRoutes from
    inside the app; each asks for its own permissions on first launch.
    ScreenWren needs macOS 26 or later.
  EOS
end
