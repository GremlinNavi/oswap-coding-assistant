# SPDX-License-Identifier: Apache-2.0
#requires -Version 5.1
[CmdletBinding()]
param([switch]$Integration)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

if ((Get-Content (Join-Path $root 'VERSION') -Raw).Trim() -ne '0.1.0') {
    throw 'Unexpected release version.'
}

Get-ChildItem -LiteralPath $root -Recurse -Filter '*.json' | ForEach-Object {
    try { [void](Get-Content $_.FullName -Raw | ConvertFrom-Json) }
    catch { throw "Invalid JSON in $($_.FullName): $($_.Exception.Message)" }
}

$domains = Get-Content (Join-Path $root 'oswap-syntax\resources\domains.json') -Raw | ConvertFrom-Json
foreach ($site in @($domains.sites)) {
    if (@($site.ui_locales) -notcontains [string]$site.default_locale) {
        throw "Default locale missing from ui_locales for $($site.apex)."
    }
    foreach ($locale in @($site.ui_locales)) {
        $bundle = Join-Path $root ("gui\locales\{0}.json" -f $locale)
        if (-not (Test-Path -LiteralPath $bundle -PathType Leaf)) { throw "Missing locale bundle: $locale" }
    }
}

$localeFiles = @(Get-ChildItem (Join-Path $root 'gui\locales') -Filter '*.json')
$baseline = Get-Content $localeFiles[0].FullName -Raw | ConvertFrom-Json
$baselineKeys = @($baseline.PSObject.Properties.Name | Where-Object { $_ -ne 'locale' } | Sort-Object)
foreach ($file in $localeFiles) {
    $bundle = Get-Content $file.FullName -Raw | ConvertFrom-Json
    $keys = @($bundle.PSObject.Properties.Name | Where-Object { $_ -ne 'locale' } | Sort-Object)
    if (($keys -join '|') -ne ($baselineKeys -join '|')) { throw "Locale key mismatch in $($file.Name)." }
}

$schema = Get-Content (Join-Path $root 'oswap-syntax\schema\dictionary-record.schema.json') -Raw | ConvertFrom-Json
foreach ($required in @('word','lang_code','source','license')) {
    if (@($schema.required) -notcontains $required) { throw "Dictionary schema missing required field: $required" }
}

$resolver = Join-Path $root 'scripts\Get-OSWAPSiteProfile.ps1'
foreach ($site in @($domains.sites)) {
    $resolved = & $resolver -Hostname $site.hostnames.ai -AsObject
    if ([string]$resolved.id -ne [string]$site.id) { throw "Site resolver mismatch for $($site.hostnames.ai)." }
}

$dataRoot = Join-Path $env:TEMP ('oswap-release-dict-' + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $dataRoot -Force | Out-Null
try {
    Set-Content (Join-Path $dataRoot 'en.jsonl') -Encoding UTF8 -Value @(
        '{"word":"test","lang_code":"en","source":"fixture"}',
        '{"word":"test","lang_code":"en","source":"fixture","license":"test-only"}'
    )
    $result = & (Join-Path $root 'scripts\Invoke-OSWAPDictionary.ps1') -Language en -Term test -DataRoot $dataRoot
    $parsed = $result | ConvertFrom-Json
    if (@($parsed).Count -ne 1 -or [string]$parsed.license -ne 'test-only') {
        throw 'Dictionary provenance enforcement failed.'
    }
} finally {
    Remove-Item -LiteralPath $dataRoot -Recurse -Force -ErrorAction SilentlyContinue
}

if ($Integration) {
    $response = & (Join-Path $root 'scripts\Invoke-OSWAPAssist.ps1') -Prompt 'Reply exactly OSWAP_RELEASE_OK.'
    if ([string]::IsNullOrWhiteSpace(($response -join "`n"))) { throw 'Local-model integration returned no text.' }
}

Write-Host 'OSWAP v0.1.0 release validation passed.'
