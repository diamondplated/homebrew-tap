cask "screenwren" do
  version "0.5.0"
  sha256 "abd6189d5798e5eef4480bce9e77e74a2584b6e2e09370503c121d7095c54e70"

  url "https://github.com/diamondplated/screenwren/releases/download/v#{version}/ScreenWren-#{version}.zip",
      verified: "github.com/diamondplated/screenwren/"
  name "ScreenWren"
  desc "Fast, private, native screen capture for macOS"
  homepage "https://github.com/diamondplated/screenwren"

  # PaperKit editor APIs are macOS 26+ only, deliberately — there is no
  # compatibility editor for older releases.
  depends_on macos: ">= :tahoe"

  app "ScreenWren.app"

  uninstall quit: "io.github.diamondplated.ScreenWren",
            login_item: "ScreenWren"

  zap trash: [
    "~/Library/Preferences/io.github.diamondplated.ScreenWren.plist",
    "~/Library/Saved Application State/io.github.diamondplated.ScreenWren.savedState",
  ]

  caveats <<~EOS
    ScreenWren is ad-hoc signed, not notarized — this project has no Apple
    Developer ID. If you installed without --no-quarantine, macOS will refuse
    the first launch. Either reinstall with:

      brew install --cask --no-quarantine diamondplated/tap/screenwren

    or approve it once under System Settings → Privacy & Security.

    ScreenWren needs Screen Recording permission to capture pixels. It will
    walk you through granting it on first launch.
  EOS
end
