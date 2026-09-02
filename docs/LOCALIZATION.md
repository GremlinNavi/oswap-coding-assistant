# OSWAP GUI Localization

OSWAP international repositories are expected to present their GUI in the language profile configured for that country or region. Locale configuration is separate from command semantics and model behavior.

## Locale identifiers

Resource bundles use BCP 47 language tags such as `en-CA`, `fr-CA`, `en-US`, and `ja-JP`. Region-specific tags are preferred when UI wording, formatting, or language policy differs by region.

Unicode CLDR SHOULD be used through platform or framework internationalization APIs for locale-sensitive dates, numbers, currencies, plural rules, collation, and related conventions. Translation files SHOULD contain UI text rather than reimplementing locale formatting rules.

## Initial profiles

Canada ships English-Canadian and French-Canadian bundles. Both are first-class supported UI locales for the Canadian profile.

The United States profile initially ships `en-US`. Additional language bundles MAY be offered without changing the profile's default locale.

Japan ships `ja-JP`. Japanese is used as Japan's national/government language; OSWAP does not claim that a specific Japanese statute formally declares an official language.

## Fallback behavior

The site profile defines the default locale. A GUI MAY honor a user's saved language choice or operating-system preference when that locale is supported by the current profile; otherwise it falls back to the profile default.

No GUI implementation SHOULD infer language solely from a top-level domain. The domain manifest is the authoritative OSWAP mapping so policy can change without code forks.
