cask "kura" do
  version "1.0.0"
  sha256 "b56960e40fcc81f12b4db3f58b1c5151d57507a06433d681b92989ff031f34f3"

  url "https://github.com/ymnao/Kura/releases/download/v#{version}/Kura.dmg"
  name "Kura"
  desc "Menu bar icon organizer that needs only the Accessibility permission"
  homepage "https://github.com/ymnao/Kura"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Kura.app"

  # Kura は ad-hoc 署名 (notarize なし) のため、quarantine 属性を自動で剥がして
  # Gatekeeper の「開発元が未確認」警告を回避する (本体 README の手動手順の自動化)
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Kura.app"]
  end

  uninstall quit: "io.github.ymnao.kura"

  zap trash: [
    "~/Library/Preferences/io.github.ymnao.kura.plist",
  ]

  caveats <<~EOS
    Kura is distributed with an ad-hoc signature (not notarized).
    The quarantine attribute is removed automatically after install,
    so Gatekeeper should not block the first launch.

    On first launch, grant the Accessibility permission when prompted.
  EOS
end
