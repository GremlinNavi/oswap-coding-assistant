# OSWAP multilingual dictionary layer

Canonical form:

```text
oswap dictionary lookup lang=<LANGUAGE-TAG> term=<TEXT>
```

Version 0.1.0 accepts a constrained BCP 47-style language-tag subset. The dictionary layer is local-first and performs no network call during lookup.

Licensed source data is normalized into JSONL indexes under `oswap-syntax/data/dictionaries/`. `oswap-syntax/schema/dictionary-record.schema.json` defines OSWAP Dictionary Record v1.

Conforming lookup records MUST include `word`, `lang_code`, `source`, and `license`. Optional upstream fields may be retained. Records missing source or licence metadata are ignored by the reference lookup implementation.

The source manifest is `oswap-syntax/resources/dictionaries.json`. Generated indexes SHOULD retain dataset edition/dump date, source URL, attribution text, and other provenance where available.

Initial source targets are Wiktionary/Wiktextract/Kaikki for broad multilingual coverage and JMdict for specialist Japanese multilingual lexicography. Local JSONL lookup is implemented; Kaikki and JMdict import/normalization adapters are planned.

Source content is never relicensed as Apache-2.0 merely because OSWAP integration code is Apache-2.0. Dictionary lookup also does not ask an LLM to invent a definition when a local source has no match.
