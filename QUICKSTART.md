# Quick Start

## Requirements

- PowerShell 5.1 or newer
- Git
- Ollama for the reference local assistant runtime
- a compatible local model such as `qwen3:4b`

## Setup

```powershell
git clone https://github.com/GremlinNavi/oswap-coding-assistant.git
cd oswap-coding-assistant
ollama pull qwen3:4b
$env:OSWAP_LLM_MODEL = 'qwen3:4b'
```

## Verify

```powershell
.\tests\Test-OSWAPCodingAssistant.ps1
.\tests\Test-OSWAPRelease.ps1
```

## Use the assistant

```powershell
.\scripts\oswap-assistant.ps1 assist powershell "Explain Get-ChildItem -Recurse"
```

## Use a dictionary index

Place licensed, normalized JSONL records under `oswap-syntax/data/dictionaries/`, then run:

```powershell
.\scripts\oswap-assistant.ps1 dictionary lookup lang=fr-CA term=chat
```

Dictionary source datasets are not bundled by default.

## Resolve an international site profile

```powershell
.\scripts\Get-OSWAPSiteProfile.ps1 -Hostname ai.oswap.ca
```

The result identifies the region, default GUI locale, supported locales, and configured OSWAP hostnames without hard-coding them into application logic.

## Optional local-model integration check

```powershell
.\tests\Test-OSWAPRelease.ps1 -Integration
```

This contacts only the configured reference localhost model endpoint and verifies that assistant text is returned; it does not execute the returned text.
