# OSWAP local PowerShell assistance

Canonical form:

```text
oswap assist powershell <TASK>
```

The v0.1.0 reference implementation calls Ollama's local `/api/chat` endpoint at `http://127.0.0.1:11434/api/chat`. The model can be selected with `OSWAP_LLM_MODEL`; the lightweight fallback is `qwen3:4b`.

This command is advisory, not agentic. It sends the requested coding task to the local model and prints the response. It does not execute generated PowerShell, invoke tools, write files, commit changes, or publish repositories.

Human review remains the execution boundary. Repository and retrieved text MUST be treated as untrusted data rather than model instructions.

Model selection within the supported Ollama runtime is implemented. Additional backend/provider adapters are planned and MUST require explicit configuration; a remote provider MUST NOT silently replace the localhost endpoint.

OSWAP syntax, dictionary lookup, repository verification, localization, domain profiles, and human authorization remain separate from the model family used for coding advice.
