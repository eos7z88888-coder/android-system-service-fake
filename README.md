# Android Bridge Backdoor: `com.servers.ozzbzk` (Research Sample)

> **WARNING — LIVE MALWARE**  
> Functional Android malware sample for **security research and defensive analysis only**.  
> **Do not install** on any device. Use isolated lab environments only.

## Summary

| Field | Value |
|-------|--------|
| Package | `com.servers.ozzbzk` |
| App label | System Service (disguise) |
| Type | Local IPC bridge (exported ContentProvider) |
| IPC authority | `content://com.servers.ozzbzk.bridge` |
| Network C2 in APK | **None observed** (external controller required) |

Small sideloaded APK (~33 KB) that registers an **exported** `BridgeProvider`. Other apps on the same device invoke `ContentResolver.call()` to trigger surveillance, overlay, and phishing helpers. The bridge itself does not embed a remote C2 URL.

## Repository layout

| Path | Description |
|------|-------------|
| [analysis/TECHNICAL_ANALYSIS.md](analysis/TECHNICAL_ANALYSIS.md) | Static analysis (architecture, IPC API, signing) |
| [iocs/SHA256SUMS.txt](iocs/SHA256SUMS.txt) | Sample hashes |
| [samples/](samples/) | Original APK, passive honeypot variant, sealed archive |

## Hashes

```
b693855c1e36cca582284f7f4582a3296ec5df4b4b8edfbfb4a085747feade4d  system_service_ORIGINAL_MALWARE.apk
82a32cada3bfd073f35c6fa0251eaf31b055565b282cc02b50cac73355a1ec38  system_service_HONEYPOT_VARIANT.apk
```

Certificate SHA256: `B6EDE6C79E7CCA3CA53121FC5F92ADD6F68559FA91113383A5A4531171CF92E3`  
Signer CN: `uNOewfBz`, O=Android, C=US (self-signed, valid from 2026-09-23)

## IPC command surface (static analysis)

Endpoint: `content://com.servers.ozzbzk.bridge` → `BridgeProvider.call(method, arg, extras)`

| Method | Capability |
|--------|------------|
| `ping` | Health / version check |
| `phish_launch` | Phishing overlay flow (HTML / target package) |
| `camera_capture` | Camera capture (Camera2 / proxy paths) |
| `audio_start` / `audio_stop` | Microphone recording |
| `overlay_show` | Full-screen overlay / black screen |
| (others) | Foreground service bootstrap, activity helpers |

## Honeypot variant

`system_service_HONEYPOT_VARIANT.apk` is a **receive-only** patched build: handlers log inbound IPC and return `{success=true}` without executing payloads. Useful for lab detection / caller logging experiments.

## Use

- Malware analysis, YARA/Sigma rules, AV testing, education.
- **Not** for deployment, evasion, or unauthorized access.

Analysis text: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Binaries: no license beyond controlled analysis.
