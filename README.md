# homebrew-tap

[ymnao](https://github.com/ymnao) のプロジェクト用 Homebrew tap。

## 使い方

Cask 名を tap 付きの完全名で指定してインストールする:

```bash
brew install --cask ymnao/tap/kura
brew install --cask ymnao/tap/scripta
```

Homebrew 6.0.0 以降は公式以外の tap に [Tap Trust](https://docs.brew.sh/Tap-Trust) が必要で、
`brew tap ymnao/tap` だけでは Cask を短縮名で読み込めない。完全名でインストールすると
その Cask だけが trust される。tap 全体を trust する場合は `brew trust ymnao/tap`。

更新は `brew upgrade --cask <名前>`。

## Casks

| Cask | 説明 |
|---|---|
| [kura](Casks/kura.rb) | [Kura](https://github.com/ymnao/Kura) — アクセシビリティ権限だけで動く macOS メニューバーアイコン収納ツール |
| [scripta](Casks/scripta.rb) | [scripta](https://github.com/ymnao/scripta) — ローカルファイルベースの軽量 Markdown メモアプリ |

### 注意 (未署名アプリの扱い)

Kura と scripta はどちらも notarize されていない。
この tap の Cask はインストール後 (更新時を含む) に quarantine 属性を自動で削除するため、
Gatekeeper の「開発元が未確認」警告は出ず、更新のたびに許可し直す必要もない。

これは Gatekeeper の検査を省略することと同じなので、この tap と各プロジェクトの
GitHub Releases を信頼できる場合にだけ利用してほしい。Cask はダウンロードした dmg を
Cask に記録した `sha256` で検証し、一致しなければインストールしない。
この挙動が望ましくない場合は、各プロジェクトの Releases から dmg を手動でインストールする。

## 自動更新

[`.github/workflows/autobump.yml`](.github/workflows/autobump.yml) が毎週月曜 (19:40 UTC) に `brew bump` を実行し、
各プロジェクトの最新リリースを検出すると Cask の version / sha256 を更新する PR を開く。

自動 bump が止まるケース:

- **新しいリリースの最小 macOS が上がったとき** (arch 別 dmg の scripta)。bump 時の
  `brew audit` が dmg の `LSMinimumSystemVersion` と Cask の `depends_on macos:` の
  食い違いを検出して bump を中止し、workflow が失敗する。Cask の `depends_on macos:` を
  上げる PR を手で出して merge してから、workflow を手動実行する
  (scripta は v0.7.0 が Electron 43 = `:monterey`、次のリリースから Electron 44 = `:ventura`)
- **repo に 60 日間動きが無いとき**。GitHub は public repo の schedule workflow を
  自動で無効化する。Actions タブから workflow を有効化し直す

## ライセンス

[MIT](LICENSE)
