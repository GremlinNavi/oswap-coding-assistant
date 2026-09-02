# SPDX-License-Identifier: Apache-2.0
#requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$scripts = Join-Path $root 'scripts'

Get-ChildItem -LiteralPath $scripts -Filter '*.ps1' | ForEach-Object {
    $errors = $null
    [void][Management.Automation.Language.Parser]::ParseFile($_.FullName, [ref]$null, [ref]$errors)
    if ($errors.Count -gt 0) { throw "PowerShell parse failure in $($_.Name): $($errors[0].Message)" }
}

$dataRoot = Join-Path $env:TEMP ('oswap-dict-test-' + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $dataRoot -Force | Out-Null
try {
    $fixture = '{"word":"chat","lang_code":"fr","pos":"noun","senses":[{"glosses":["domestic cat"]}],"source":"test-fixture","license":"test-only"}'
    Set-Content -LiteralPath (Join-Path $dataRoot 'fr.jsonl') -Value $fixture -Encoding UTF8
    $result = & (Join-Path $scripts 'Invoke-OSWAPDictionary.ps1') -Language fr -Term chat -DataRoot $dataRoot
    if (($result -join "`n") -notmatch 'domestic cat') { throw 'Dictionary fixture lookup failed.' }
} finally {
    Remove-Item -LiteralPath $dataRoot -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host 'OSWAP Coding Assistant self-test passed.'
