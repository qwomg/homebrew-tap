cask "simwatchdog" do
  version "1.1.0"
  sha256 "50cfb737099a4f77f9aeb2713ac23a3d7362defb11cba3e6ad7abc71fe73e10d"

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
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/SimWatchdog.app"],
        writable_paths: ["SimWatchdog.app"],
        writable_base:  :appdir
  end

  zap trash: [
    "~/Library/Logs/SimWatchdog.log",
    "~/Library/Preferences/io.github.qwomg.SimWatchdog.plist",
  ]
end
