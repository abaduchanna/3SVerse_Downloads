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

| Product | Paid / licensed build | Trial build |
|---------|----------------------|-------------|
| VidaPay Incentive Extractor | `VidaPay_Incentive_Extractor_FULL.exe` | `VidaPay_Incentive_Extractor_TRIAL.exe` |
| VidaPay Device Ordering | `VidaPay_Device_Ordering_FULL.exe` | `VidaPay_Device_Ordering_TRIAL.exe` |
| VidaPay Rebate Filing | `VidaPay_Rebate_Filing.exe` | same file (7-day trial built in) |

- Downloading is free. Using it beyond the built-in 7-day trial requires
  a license key, issued by 3S Verse and activated on one PC.
- Monthly / annual / lifetime customers re-download updates free: open
  your order status page on 3sverse.com with your order number and use
  the download buttons there.
- `3S-verse-POS` is an internal store tool and is intentionally not
  mirrored here.

## Setup note

The sync workflow needs one repo secret, `SYNC_TOKEN` (a GitHub PAT
with contents:read on `vidapay-rebate-filing`, `vidapay-extractor`,
`vidapay-ordering` and contents:write here). Trigger the sync manually
from the Actions tab → "Sync latest EXEs" → Run workflow.
