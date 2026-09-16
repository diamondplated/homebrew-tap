cask "sift" do
  version "2.0.1"
  sha256 "83b9d76da9b3e757bdd3255860f5ec125ddacfd58b05a51045259fa3d043b5c2"

  url "https://github.com/diamondplated/sift/releases/download/v#{version}/Sift-#{version}.zip",
      verified: "github.com/diamondplated/sift/"
  livecheck do
    url :url
    strategy :github_latest
  end

  name "Sift"
  desc "Drop a data file in, explore it instantly — DuckDB reads CSV, Parquet, Delta, JSON and XLSX in place"
  homepage "https://github.com/diamondplated/sift"

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Sift.app"

  uninstall quit: "io.github.diamondplated.sift"

  zap trash: [
    "~/Library/Preferences/io.github.diamondplated.sift.plist",
    "~/Library/Saved Application State/io.github.diamondplated.sift.savedState",
    "~/Library/Application Support/Sift",
  ]

  caveats <<~EOS
    Sift is ad-hoc signed, not notarized — this project has no Apple
    Developer ID — and Homebrew 6 always applies macOS's quarantine attribute
    with no opt-out. So macOS WILL block the first launch.

    Approve it once, either way:

      • Open it, then go to System Settings → Privacy & Security and click
        "Open Anyway", or
      • Remove the attribute yourself, if you trust this build:
          xattr -dr com.apple.quarantine /Applications/Sift.app

    That second one disables a macOS security check for this app. It is your
    call to make deliberately, which is why it is not done for you here.

    The bundle is self-contained: libduckdb ships inside it. Remote reads
    (HTTP / S3) install DuckDB's httpfs extension the first time you save a
    connection; until then Sift touches no network.
  EOS
end
