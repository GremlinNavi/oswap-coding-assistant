# Contributing

OSWAP Coding Assistant uses a four-layer command structure:

1. `oswap-syntax/commands/*.json` - machine-readable command contract
2. `oswap-syntax/knowledge/*.md` - design rationale and semantics
3. `scripts/Invoke-*.ps1` - reference implementation
4. `tests/*.ps1` - executable evidence

## Contribution requirements

- keep PowerShell compatible with the declared minimum version
- do not introduce automatic execution of model-generated code
- add or update tests when behavior changes
- distinguish `implemented`, `experimental`, and `planned` behavior
- keep locale strings outside core execution logic
- do not hard-code OSWAP domains into GUI or handler logic; use the site-profile manifest
- preserve upstream dictionary and model licensing
- dictionary adapters MUST normalize source and licence metadata
- destructive operations are out of scope for this repository

Run `tests/Test-OSWAPCodingAssistant.ps1` and `tests/Test-OSWAPRelease.ps1` before proposing a change. Optional local-model integration testing is documented in `QUICKSTART.md`.
