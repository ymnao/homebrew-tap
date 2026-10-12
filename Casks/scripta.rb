cask "scripta" do
  arch arm: "-arm64"

  version "0.8.0"
  sha256 arm:   "84d8e29c7f8961eb769af49d4e120bab6eb6a566b2be9a4fa711876d1a6dc6af",
         intel: "e03e435ab8d631b0783422a2fef631d5b7b0cb30da0c244e26d72fe48ad04c49"

  url "https://github.com/ymnao/scripta/releases/download/v#{version}/scripta-#{version}#{arch}.dmg"
  name "scripta"
  desc "Local-file-based lightweight Markdown note-taking app"
  homepage "https://github.com/ymnao/scripta"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "scripta.app"

  # scripta は未署名 (notarize なし) のため、quarantine 属性を自動で剥がして
  # 更新のたびに「プライバシーとセキュリティ」で許可し直す手間を省く
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/scripta.app"]
  end

  uninstall quit: "com.scripta.app"

  zap trash: [
    "~/Library/Application Support/scripta",
    "~/Library/Preferences/com.scripta.app.plist",
    "~/Library/Saved Application State/com.scripta.app.savedState",
  ]

  caveats <<~EOS
    scripta is distributed unsigned (not notarized).
    The quarantine attribute is removed automatically after install and upgrade,
    so Gatekeeper does not block the first launch.
  EOS
end
