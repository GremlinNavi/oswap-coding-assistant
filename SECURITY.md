# Security

OSWAP Coding Assistant v0.1.0 is advisory software. The reference assistant returns text and has no code-execution, filesystem-write, Git-write, or publication capability.

## Security invariants

- generated PowerShell MUST NOT be executed automatically
- tool calling is out of scope for v0.1.0
- the reference inference endpoint is loopback-only (`127.0.0.1`) by default
- repository or dictionary text MUST be treated as untrusted data, not model instructions
- dictionary results MUST preserve source and licence metadata
- human review is the execution boundary

## Reporting

Do not include secrets, credentials, private repository contents, or personal data in a public security report. Use the repository's private security-reporting mechanism when enabled; otherwise contact the maintainer through an appropriate private channel.

Security claims in this repository describe the reference implementation and are not a certification of downstream forks, models, dictionary datasets, or deployment infrastructure.
