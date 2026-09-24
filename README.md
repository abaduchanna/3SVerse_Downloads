# 3S Verse — Downloads

Public, always-current Windows builds of the VidaPay dealer tools.
Developed by www.3SVerse.com

This repo is the download mirror for https://3sverse.com. A scheduled
GitHub Action (`.github/workflows/sync.yml`) copies the newest release
assets of the private build repos into this repo's `latest` release, so
a single versionless URL always serves the newest build:

```
https://github.com/abaduchanna/3sverse-downloads/releases/latest/download/<EXE-NAME>.exe
```

| Product | One build for everyone |
|---------|------------------------|
| VidaPay Incentive Extractor | `VidaPay_Incentive_Extractor.exe` |
| VidaPay Device Ordering | `VidaPay_Device_Ordering.exe` |
| VidaPay Rebate Filing | `VidaPay_Rebate_Filing.exe` |

- There is ONE build per tool: it opens as a free 7-day trial, and a
  license key unlocks the full version permanently. Trial users and
  paid customers run the same file.
- Downloading is free. Using it beyond the built-in 7-day trial requires
  a license key, issued by 3S Verse and activated on one PC.
- Monthly / annual / lifetime customers re-download updates free: open
  your order status page on 3sverse.com with your order number and use
  the download buttons there.
- `3S-verse-POS` is an internal store tool and is intentionally not
  mirrored here.

## Why hosting the paid-capable build publicly is safe

The build embeds a scoped ledger client token used for license
activation and revocation checks. It cannot mint or extend licenses:
every key is accepted only after its Ed25519 signature (produced by the
seller's offline keygen) verifies against the seller-published public
keys in `license_core`. The signing keys never ship with any build.

## Setup note

The sync workflow needs one repo secret, `SYNC_TOKEN` (a GitHub PAT
with contents:read on `VidaPay_Rebate_Filing`, `VidaPay_Incentive_Extractor`,
`VidaPay_Device_Ordering` and contents:write here). Trigger the sync manually
from the Actions tab → "Sync latest EXEs" → Run workflow.
