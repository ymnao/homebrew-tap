cask "scripta" do
  arch arm: "-arm64"

  version "0.7.0"
  sha256 arm:   "1aeebd384556b413b03a1f88e7bb539692076a6e90f963ec846a7a1f1371c8e4",
         intel: "9880fcd80634036ff5e29bb8ad0e3401076f8a0dc3614d02638857cd8e35e649"

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
