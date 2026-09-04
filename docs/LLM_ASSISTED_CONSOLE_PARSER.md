# OSWAP Coding Assistant — LLM-Assisted Console Parser Integration

SPDX-License-Identifier: Apache-2.0

## Scope

This document defines how the OSWAP Coding Assistant may participate in the planned OSWAP LLM-Assisted Console Parser without turning generated language into automatically executable code.

The Coding Assistant remains advisory. Its model output may help normalize human-readable console input into a typed candidate, but deterministic OSWAP validation and the execution boundary live outside the model.

## Integration model

```text
user console text
  -> OSWAP parser front end
  -> local LLM assistance when needed
  -> typed candidate
  -> deterministic OSWAP validator
  -> effect classifier
  -> consent / provider authorization
  -> execution adapter
```

The preferred path is canonical-first: if the input already matches a deterministic OSWAP grammar, the parser should skip LLM interpretation.

## Local-first model role

The current Coding Assistant uses a local Ollama-compatible runtime as its reference backend. A future parser adapter may reuse that local model interface to interpret multilingual or typo-tolerant input.

Model output MUST be treated as untrusted structured data until it validates against an OSWAP-owned schema.

The model MUST NOT:

- execute generated PowerShell;
- call `Invoke-Expression` or an equivalent evaluator;
- expand user authorization;
- silently select a provider or repository when multiple materially different targets are plausible;
- invent a tool or plugin because its name appears semantically plausible;
- represent a requested mutation as completed without verified execution evidence.

## Candidate shape

A parser adapter may request that the model produce a compact candidate such as:

```json
{
  "parser_profile": "oswap-llm-assisted-console/v1",
  "operation": "repository.transfer",
  "arguments": {
    "direction": "upload",
    "replication_expression": "3"
  },
  "requested_tools": [],
  "execution_requested": true,
  "ambiguities": [],
  "candidate_only": true
}
```

The adapter should reject additional fields that are not part of the applicable schema unless they are explicitly preserved as non-executable metadata.

## Multilingual input

The Coding Assistant may use its multilingual and dictionary layers to help normalize ordinary literary grammar from the user's active language into language-neutral OSWAP fields.

This may improve accessibility for:

- spelling mistakes or transpositions;
- speech-to-text artifacts;
- locale-specific terminology;
- informal slang;
- mixed natural-language and canonical OSWAP syntax.

The original input should be preserved for auditability and user review.

## Explicit tool notation

The planned OSWAP parser profile uses a leading `@` to mark an explicit plugin, connected service, or tool target.

Examples:

```text
@GitHub inspect repository state
@GitLab compare mirror state
@Web search OSWAP accessibility precedents
```

The Coding Assistant may help parse the surrounding natural language, but tool resolution must occur against a runtime registry. Mentioning a provider name without the explicit invocation marker should not by itself cause an external call.

## Experimental intent envelopes

High-level OSWAP research syntax may include colon-delimited intent envelopes such as:

```text
Joker:to:Search:Meaning:"factual accuracy"
```

The Coding Assistant may translate such text into structured fields for inspection. Unknown fields should remain unknown rather than being assigned invented executable semantics.

## Comments

The planned parser profile may treat square-bracket text as human-readable comment metadata where the grammar permits it.

Example:

```text
oswap upload twin=3 [publish three complete copies]
```

The exact lexical rules should be versioned before this becomes normative syntax. Quoted bracket characters must not be discarded accidentally.

## Context and provenance

LLM parsing may depend on the active locale, current repository, retrieved documentation, conversation context, saved preferences, or available tool registry.

When such context materially changes the parse, the parser should record the relevant context source or category. Context may resolve meaning but must not create consent.

## Recommended command surface

A future wrapper could expose assisted interpretation with an explicit non-executing command such as:

```text
oswap assist parse <TEXT>
```

or:

```text
oswap parse --assist <TEXT>
```

The command should return a candidate and plain-language preview, not execute the resulting operation automatically.

## Relationship to the OSWAP workflow layer

The canonical workflow/security design for the parser is documented in:

```text
GremlinNavi/oswap-workflows/docs/OSWAP_LLM_ASSISTED_CONSOLE_PARSER.md
```

The syntax-facing conventions are recorded in:

```text
GremlinNavi/OSWAP-syntax/LLM_ASSISTED_CONSOLE_PARSER.md
```

These documents preserve the same architectural rule as this repository's existing safety boundary: LLM assistance may explain or generate text, but human review and deterministic execution controls remain separate.
