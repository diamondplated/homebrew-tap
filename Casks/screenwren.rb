cask "screenwren" do
  version "0.5.0"
  sha256 "abd6189d5798e5eef4480bce9e77e74a2584b6e2e09370503c121d7095c54e70"

  url "https://github.com/diamondplated/screenwren/releases/download/v#{version}/ScreenWren-#{version}.zip",
      verified: "github.com/diamondplated/screenwren/"
  livecheck do
    url :url
    strategy :github_latest
  end

  name "ScreenWren"
  desc "Fast, private, native screen capture for macOS"
  homepage "https://github.com/diamondplated/screenwren"

  # PaperKit editor APIs are macOS 26+ only, deliberately — there is no
  # compatibility editor for older releases.
  depends_on macos: :tahoe

  app "ScreenWren.app"

  uninstall quit: "io.github.diamondplated.ScreenWren",
            login_item: "ScreenWren"

  zap trash: [
    "~/Library/Preferences/io.github.diamondplated.ScreenWren.plist",
    "~/Library/Saved Application State/io.github.diamondplated.ScreenWren.savedState",
  ]

  caveats <<~EOS
    ScreenWren is ad-hoc signed, not notarized — this project has no Apple
    Developer ID — and Homebrew 6 always applies macOS's quarantine attribute
    with no opt-out. So macOS WILL block the first launch.

    Approve it once, either way:

      • Open it, then go to System Settings → Privacy & Security and click
        "Open Anyway", or
      • Remove the attribute yourself, if you trust this build:
          xattr -dr com.apple.quarantine /Applications/ScreenWren.app

    That second one disables a macOS security check for this app. It is your
    call to make deliberately, which is why it is not done for you here.
    Building from source avoids the question entirely.

    ScreenWren also needs Screen Recording permission to capture pixels; it
    walks you through granting that on first launch.
  EOS
end
