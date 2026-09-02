# GUI locale resources

These JSON files are UI resource bundles for the next OSWAP GUI development step. They do not contain executable behavior.

Every bundle MUST expose the same message keys. The site profile in `oswap-syntax/resources/domains.json` determines which bundles are available for a country/domain and which locale is the default.

Current bundles:

- `en-CA` - Canadian English
- `fr-CA` - Canadian French
- `en-US` - United States English
- `ja-JP` - Japanese for Japan

Use framework/platform internationalization APIs backed by Unicode CLDR for dates, numbers, units, currencies, collation, and plural behavior. Do not encode those rules manually in these translation files.
