# Android Bridge Backdoor: `com.servers.ozzbzk` (Research Sample)

> **WARNING — LIVE MALWARE**  
> This repository contains **functional Android malware** for **security research and defensive analysis only**.  
> **Do not install** these APKs on any device. Use isolated lab environments only.

## Summary

| Field | Value |
|-------|--------|
| Package | `com.servers.ozzbzk` |
| App label | System Service (fake) |
| Type | Local IPC bridge implant (exported ContentProvider) |
| IPC authority | `content://com.servers.ozzbzk.bridge` |
| Network C2 in APK | **None** (controller is external) |

The sample poses as a system service and exposes a **exported** `BridgeProvider` that accepts `ContentResolver.call()` commands from other apps on the same device. A separate controller (another app, ADB, or instrumentation) drives surveillance/phishing actions through this bridge.

## Files

| Path | Description |
|------|-------------|
| [analysis/attribution_REPORT.md](analysis/attribution_REPORT.md) | Delivery chain & attribution notes (device-local investigation) |
| [iocs/SHA256SUMS.txt](iocs/SHA256SUMS.txt) | Sample hashes |
| [samples/](samples/) | Original APK + passive honeypot variant + sealed archive |

## Hashes

```
b693855c1e36cca582284f7f4582a3296ec5df4b4b8edfbfb4a085747feade4d  system_service_ORIGINAL_MALWARE.apk
82a32cada3bfd073f35c6fa0251eaf31b055565b282cc02b50cac73355a1ec38  system_service_HONEYPOT_VARIANT.apk
```

Certificate SHA256: `B6EDE6C79E7CCA3CA53121FC5F92ADD6F68559FA91113383A5A4531171CF92E3`  
Signer CN: `uNOewfBz`, O=Android, C=US (self-signed, dated 2026-09-23)

## Bridge command surface (static analysis)

Invoked via `content://com.servers.ozzbzk.bridge` → `BridgeProvider.call(method, arg, extras)`:

| Method (observed) | Capability |
|-------------------|------------|
| `ping` | Health check / version |
| `phish_launch` | Launch phishing overlay / target app flow |
| `camera_capture` | Silent camera capture (incl. Camera2 / proxy paths) |
| `audio_start` / `audio_stop` | Microphone recording |
| `overlay_show` | Full-screen overlay / black screen |
| (others) | Foreground service bootstrap, activity injection helpers |

**Attribution model:** the bridge logs **caller uid/pid/package** on each IPC call — useful for identifying the controller app when it invokes the provider.

## Delivery (investigated device)

Observed install path: **social IM file share** → user confirms package installer → APK installed as sideload. No in-APK hardcoded download URL for the bridge itself.

## Honeypot variant

`system_service_HONEYPOT_VARIANT.apk` is a **receive-only** patched build: all `call()` handlers log the caller and return `{success=true}` without executing malicious actions. Included for defensive research / attribution testing.

## Legal / ethical use

- Provided **as-is** for malware analysis, detection rule development, and education.
- **Not** for deployment, evasion research, or unauthorized access.
- Researchers: submit hashes to [MalwareBazaar](https://bazaar.abuse.ch/) / VirusTotal for broader coverage.

## License

Analysis text and documentation: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).  
Malware binaries: no license granted for use beyond analysis in controlled environments.

---

*Published for public defensive research — 2026-10-04*
