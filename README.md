# OSWAP Coding Assistant

A local-first, multilingual PowerShell coding assistant for the Open-Source World Access Project (OSWAP).

Current release-candidate version: `0.1.0`.

## Goals

- lightweight local LLM assistance for PowerShell coding
- no automatic execution of generated code
- model-selectable design with Ollama as the reference local runtime
- multilingual terminology support through locally indexed dictionary datasets
- explicit provenance and licence metadata for dictionary sources
- country/region GUI localization through external locale resource bundles
- domain integration through a data-driven OSWAP site-profile manifest
- compatibility with the wider OSWAP command/syntax ecosystem

## Quick start

See [`QUICKSTART.md`](QUICKSTART.md) for setup, verification, assistant use, dictionary lookup, and international site-profile resolution.

```powershell
ollama pull qwen3:4b
$env:OSWAP_LLM_MODEL = 'qwen3:4b'
.\tests\Test-OSWAPCodingAssistant.ps1
.\tests\Test-OSWAPRelease.ps1
.\scripts\oswap-assistant.ps1 assist powershell "Explain this pipeline"
```

## Canonical OSWAP-facing forms

The wider OSWAP shell may expose this component as:

```text
oswap assist powershell <TASK>
oswap dictionary lookup lang=<LANGUAGE-TAG> term=<TEXT>
```

The standalone reference wrapper is `scripts/oswap-assistant.ps1`.

The assistant is advisory. Generated code is never executed automatically.

## Local model runtime

The current reference implementation calls Ollama at `http://127.0.0.1:11434/api/chat`. Set `OSWAP_LLM_MODEL` to select a compatible locally installed model. Backend/provider adapters beyond the Ollama API are planned, not implemented in v0.1.0.

## Multilingual dictionary layer

Dictionary datasets are not vendored into this repository. Licensed data is normalized into JSONL indexes under `oswap-syntax/data/dictionaries/`.

`oswap-syntax/schema/dictionary-record.schema.json` defines OSWAP Dictionary Record v1. Conforming records preserve at minimum the term, language tag, upstream source, and licence metadata.

The source manifest identifies Wiktionary/Wiktextract/Kaikki for broad multilingual coverage and JMdict for specialist Japanese coverage. Import adapters are planned; local JSONL lookup is implemented.

## International GUI and planned domain profiles

`oswap-syntax/resources/domains.json` keeps planned hostname and locale policy out of application code.

OSWAP has registered `oswap.ca`, `oswap.us`, and `oswap.jp`, but this repository does not represent any OSWAP website or subdomain on those domains as currently deployed or online.

The current manifest contains planned profiles for:

- `oswap.ca` → `en-CA`, `fr-CA`
- `oswap.us` → `en-US`
- `oswap.jp` → `ja-JP`

Consistent `www`, `ai`, `code`, and `docs` labels are reserved in the manifest for future deployment. They are configuration identities, not claims of DNS resolution or service availability. Deployment targets and credentials are intentionally not stored in the repository.

GUI string bundles live under `gui/locales/`. Locale-sensitive formatting should use platform internationalization APIs backed by Unicode CLDR rather than hand-coded cultural rules.

See `docs/DOMAIN_INTEGRATION.md` and `docs/LOCALIZATION.md`.

## LLM-Assisted Console Parser integration

`docs/LLM_ASSISTED_CONSOLE_PARSER.md` defines how this local-first assistant may participate in the planned OSWAP LLM-Assisted Console Parser. The model may normalize multilingual, typo-tolerant, or informal console text into a typed parse candidate, but it remains advisory: deterministic OSWAP validation, effect classification, consent, tool resolution, and execution stay outside the model.

The integration document also records the planned explicit `@Tool` invocation convention, context provenance requirements, experimental intent envelopes, and the rule that model output must never be treated as automatically executable shell code.

## Safety boundary

The coding assistant can explain or generate PowerShell text, but it cannot execute commands, write files, commit changes, or publish repositories. Human review remains the execution boundary. See `SECURITY.md`.

## Development status

Version `0.1.0` freezes the current reference implementation. Major new adapters, importers, GUI behavior, and deployment automation belong to the next development cycle.

## License

OSWAP-authored source code and documentation are licensed under Apache License 2.0 unless a file states otherwise. Third-party dictionary data and model weights retain their original licences and attribution requirements.
