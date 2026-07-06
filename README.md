# homebrew-tap

[ymnao](https://github.com/ymnao) のプロジェクト用 Homebrew tap。

## 使い方

```bash
brew tap ymnao/tap
brew install --cask kura
```

または 1 コマンドで:

```bash
brew install --cask ymnao/tap/kura
```

## Casks

| Cask | 説明 |
|---|---|
| [kura](Casks/kura.rb) | [Kura](https://github.com/ymnao/Kura) — アクセシビリティ権限だけで動く macOS メニューバーアイコン収納ツール |

### 注意 (未署名アプリの扱い)

Kura は ad-hoc 署名 (notarize なし) で配布されています。この Cask はインストール後に
quarantine 属性を自動で削除するため、Gatekeeper の「開発元が未確認」警告は出ません。
この挙動が望ましくない場合は、[手動インストール手順](https://github.com/ymnao/Kura#インストール)
(チェックサム検証つき) を利用してください。

## ライセンス

[MIT](LICENSE)
