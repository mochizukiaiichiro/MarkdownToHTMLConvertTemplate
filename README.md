# MarkdownToHTMLConvertTemplate

## 概要

Pandocを使用してMarkdownをHTMLに変換するためのテンプレートプロジェクトです。
ドキュメント作成・案件概要資料・ナレッジ共有などを、**統一フォーマットのHTMLとして出力**できます。

---

## 特徴

- Markdownから**スタンドアロンHTML**を生成
- Pandocデフォルトの不要なスタイルを削除した**軽量テンプレート**
- シンプルで見やすい**カスタムCSS**
- Luaフィルタによる**目次（TOC）の自動生成**
- `[TOC]` を書いた位置に目次を挿入可能
- PowerShellスクリプトによる**ワンコマンド変換**

---

## ディレクトリ構成

```
.
├── input/        # 変換対象Markdown
├── output/       # 出力HTML
├── src/
│   ├── style/    # CSS
│   ├── template/ # HTMLテンプレート
│   └── filters/  # Luaフィルタ
└── script/
    └── build.ps1 # 変換スクリプト
```

---

## 使用方法

### 1. Markdownを配置

`input/` にファイルを配置します。

```
input/sample.md
```

---

### 2. 変換実行

```
.\script\build.ps1 sample
```

---

### 3. 出力

```
output/sample.html
```

---

## 目次（TOC）の使い方

Markdown内に以下を記述すると、その位置に目次が挿入されます。

```
[TOC]
```

---

## 前提条件

以下がインストールされている必要があります：

- Pandoc
- PowerShell（Windows環境）

---

## カスタマイズ

以下を編集することで自由にカスタマイズできます：

- `src/style/style.css`：見た目の変更
- `src/template/template.html`：HTML構造の変更
- `src/filters/insert-toc.lua`：目次生成ロジック

---

## 想定ユースケース

- 概要資料作成
- 技術ドキュメントのHTML化
- 社内ナレッジの共有

---

## ライセンス

MIT
