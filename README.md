# OSWAP Coding Assistant

A local-first, multilingual PowerShell coding assistant for the Open-Source World Access Project (OSWAP).

## Goals

- lightweight local LLM assistance for PowerShell coding
- no automatic execution of generated code
- model-agnostic design with Ollama as the reference local runtime
- multilingual terminology support through locally indexed dictionary datasets
- explicit provenance and licence metadata for dictionary sources
- compatibility with the wider OSWAP command/syntax ecosystem

## Canonical commands

```powershell
.\scripts\oswap-assistant.ps1 assist powershell "Explain this pipeline"
.\scripts\oswap-assistant.ps1 dictionary lookup lang=fr term=chat
```

The wider OSWAP shell may expose the same assistant as:

```text
oswap assist powershell <TASK>
oswap dictionary lookup lang=<BCP47> term=<TEXT>
```

The assistant is advisory. Generated code is never executed automatically.
## Local model runtime

The reference implementation calls Ollama at `http://127.0.0.1:11434/api/chat`.
Set `OSWAP_LLM_MODEL` to choose the model. The current lightweight fallback is `qwen3:4b`.

```powershell
$env:OSWAP_LLM_MODEL = 'qwen3:4b'
.\scripts\oswap-assistant.ps1 assist powershell "Write a safe Get-ChildItem example"
```

## Multilingual dictionary layer

Dictionary datasets are not vendored into this repository. Licensed data is normalized into JSONL indexes under `oswap-syntax/data/dictionaries/`.

The initial source manifest identifies Wiktionary/Wiktextract/Kaikki for broad multilingual coverage and JMdict for specialist Japanese coverage. Dictionary data retains its upstream licence; it is not relicensed under Apache-2.0.

## Safety boundary

The coding assistant can explain or generate PowerShell text, but it cannot execute commands, write files, commit changes, or publish repositories. Human review remains the execution boundary.

## License

OSWAP-authored source code and documentation are licensed under Apache License 2.0 unless a file states otherwise. Third-party dictionary data retains its original licence and attribution requirements.
