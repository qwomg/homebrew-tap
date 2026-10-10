cask "simwatchdog" do
  version "1.0.1"
  sha256 "26c034114a75163e05cd8616327c9c8865bfb93ed4c3e8fbea2624f751b5709b"

  url "https://github.com/qwomg/SimWatchdog/releases/download/v#{version}/SimWatchdog.zip"
  name "SimWatchdog"
  desc "Menu bar app that closes simulators when memory runs low"
  homepage "https://github.com/qwomg/SimWatchdog"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "SimWatchdog.app"

  # Ad-hoc signed, not notarized: clear quarantine so it opens without a Gatekeeper warning.
  postflight_steps do
    run "/usr/bin/xattr", "-dr", "com.apple.quarantine", "#{appdir}/SimWatchdog.app"
  end

  zap trash: [
    "~/Library/Logs/SimWatchdog.log",
    "~/Library/Preferences/io.github.qwomg.SimWatchdog.plist",
  ]
end
