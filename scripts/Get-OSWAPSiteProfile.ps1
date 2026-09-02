# SPDX-License-Identifier: Apache-2.0
#requires -Version 5.1
[CmdletBinding()]
param(
    [string]$Hostname = $env:OSWAP_HOSTNAME,
    [string]$ManifestPath = (Join-Path (Split-Path -Parent $PSScriptRoot) 'oswap-syntax\resources\domains.json'),
    [switch]$AsObject
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($Hostname)) {
    throw 'Provide -Hostname or set OSWAP_HOSTNAME.'
}
if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) {
    throw "OSWAP domain manifest not found: $ManifestPath"
}

$inputValue = $Hostname.Trim()
$uri = $null
if ([Uri]::TryCreate($inputValue, [UriKind]::Absolute, [ref]$uri) -and $uri.Host) {
    $normalized = $uri.Host.ToLowerInvariant()
} else {
    $normalized = (($inputValue -split ':')[0]).TrimEnd('.').ToLowerInvariant()
}

$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json
$match = $null
foreach ($site in @($manifest.sites)) {
    $names = New-Object System.Collections.Generic.List[string]
    $names.Add(([string]$site.apex).ToLowerInvariant())
    foreach ($property in $site.hostnames.PSObject.Properties) {
        if ($property.Value) { $names.Add(([string]$property.Value).ToLowerInvariant()) }
    }
    if ($names -contains $normalized) {
        $match = $site
        break
    }
}

if ($null -eq $match) {
    throw "No OSWAP site profile is configured for hostname '$normalized'."
}

if ($AsObject) {
    Write-Output $match
    return
}

$match | ConvertTo-Json -Depth 12
