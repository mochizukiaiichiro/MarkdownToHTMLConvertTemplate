# コマンド引数
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$FileName
)

Write-Host start

# プロジェクトルート取得
$ProjectRoot = Split-Path $PSScriptRoot -Parent

# パス定義
$InputFile = Join-Path $ProjectRoot "input/$FileName.md"
$OutputFile = Join-Path $ProjectRoot "output/$FileName.html"

# 入力チェック
if (!(Test-Path $InputFile)) {
    Write-Error "入力ファイルがありません: $FileName"
    exit 1
}

# Outputディレクトリが無い場合は生成する
$OutputDir = Join-Path $ProjectRoot "output"
if (!(Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

# ログ
Write-Host "Input : $InputFile"
Write-Host "Output: $OutputFile"

# 実行
pandoc $InputFile `
    -o $OutputFile `
    --standalone `
    --embed-resources `
    --css (Join-Path $ProjectRoot "src/style/style.css") `
    --template (Join-Path $ProjectRoot "src/template/template.html") `
    --lua-filter (Join-Path $ProjectRoot "src/filters/insert-toc.lua")

Write-Host end