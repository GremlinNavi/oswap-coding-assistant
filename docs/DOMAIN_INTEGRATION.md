# OSWAP Domain Integration

Domain configuration is data, not application logic. GUI, documentation, AI, and code endpoints SHOULD resolve hostnames through `oswap-syntax/resources/domains.json`.

## Current site profiles

- `oswap.ca` - Canada; GUI locales `en-CA` and `fr-CA`
- `oswap.us` - United States; GUI locale `en-US`
- `oswap.jp` - Japan; GUI locale `ja-JP`

Each profile reserves consistent labels such as `www`, `ai`, `code`, and `docs`. A deployment can point those labels to any supported host without changing the OSWAP command or GUI code.

## DNS deployment boundary

The repository does not contain Cloudflare credentials, zone IDs, account IDs, origin addresses, or API tokens. Deployment targets are supplied separately at deployment time.

Cloudflare supports A, AAAA, and CNAME records for subdomains. OSWAP therefore records desired hostnames while leaving the final record type and target to the deployment layer.

## Resolver

```powershell
.\scripts\Get-OSWAPSiteProfile.ps1 -Hostname docs.oswap.jp
```

The resolver strips a port, normalizes case, matches apex or configured subdomains, and returns the full site profile as JSON.
