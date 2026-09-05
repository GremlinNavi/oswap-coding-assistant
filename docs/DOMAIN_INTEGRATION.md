# OSWAP Domain Integration

Domain configuration is data, not application logic. GUI, documentation, AI, and code endpoint profiles SHOULD resolve planned hostnames through `oswap-syntax/resources/domains.json`.

## Deployment status

OSWAP has registered `oswap.ca`, `oswap.us`, and `oswap.jp` for future project infrastructure.

No site, API, AI endpoint, code endpoint, documentation endpoint, or other public OSWAP service on those domains is represented by this repository as currently deployed or online.

The manifest is a planning and local-resolution artifact. A hostname appearing in the manifest does not establish DNS delegation, TLS, routing, hosting, or application availability.

## Planned site profiles

- `oswap.ca` - Canada; GUI locales `en-CA` and `fr-CA`
- `oswap.us` - United States; GUI locale `en-US`
- `oswap.jp` - Japan; GUI locale `ja-JP`

Each profile reserves consistent labels such as `www`, `ai`, `code`, and `docs` for possible future deployment. A deployment can point those labels to any supported host without changing the OSWAP command or GUI code.

## DNS deployment boundary

The repository does not contain Cloudflare credentials, zone IDs, account IDs, origin addresses, or API tokens. Deployment targets are supplied separately at deployment time.

A future deployment may use suitable DNS record types and provider routing, but documentation MUST NOT describe a hostname as operational until DNS, TLS, routing/hosting, and the intended service have been tested from an external client.

## Resolver

```powershell
.\scripts\Get-OSWAPSiteProfile.ps1 -Hostname docs.oswap.jp
```

This is a local manifest lookup. It does not perform a DNS query and does not imply that `docs.oswap.jp` is currently reachable.

The resolver strips a port, normalizes case, matches an apex or configured planned subdomain, and returns the full site profile as JSON.

For documentation or tests that require a deliberately non-operational network name, prefer an IANA-reserved example or `.invalid` hostname rather than presenting a planned OSWAP hostname as a live URL.
