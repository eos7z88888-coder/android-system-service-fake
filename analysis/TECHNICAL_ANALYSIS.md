# Technical Analysis: `com.servers.ozzbzk`

Static analysis of the Android bridge implant. **No distribution-chain or device-specific attribution** — sample provided for research; origin not documented here.

## Architecture

```
External controller (separate app / adb / instrumentation)
        │  ContentResolver.call(method, arg, extras)
        ▼
content://com.servers.ozzbzk.bridge  (exported BridgeProvider)
        ├── CameraCaptureHelper
        ├── AudioCaptureHelper
        ├── OverlayHelper
        └── BridgeService (foreground persistence)
```

The APK is a **local IPC bridge**. There is no hardcoded HTTP/WebSocket C2 in the analyzed binary; operation assumes a co-resident or external operator that already knows the provider URI and command vocabulary.

## Manifest / exposure

- Package: `com.servers.ozzbzk`
- User-visible label mimics a system component ("System Service")
- `BridgeProvider` is **exported** → any app with permission to talk to the provider can invoke commands (subject to Android version / visibility rules)

## Signing

| Field | Value |
|-------|--------|
| CN | uNOewfBz |
| O | Android |
| C | US |
| Cert SHA256 | B6EDE6C79E7CCA3CA53121FC5F92ADD6F68559FA91113383A5A4531171CF92E3 |
| APK SHA256 | B693855C1E36CCA582284F7F4582A3296EC5DF4B4B8EDFBFB4A085747FEADE4D |
| APK size | ~33 KB |

Self-signed certificate with a recent validity window (from 2026-09-23), consistent with a freshly built implant rather than a store-distributed app.

## BridgeProvider API

Invocation pattern:

```java
getContentResolver().call(
    Uri.parse("content://com.servers.ozzbzk.bridge"),
    "<method>",
    "<arg>",
    extras  // optional Bundle
);
```

Observed `method` strings and behavior (from decompiled smali):

| Method | Behavior |
|--------|----------|
| `ping` | Returns status/version availability |
| `phish_launch` | Drives phishing UI; accepts HTML (incl. Base64), `target_pkg`, persists `phish_pending.json` |
| `camera_capture` | Captures JPEG via Camera1/Camera2/proxy paths; extras: `camera_id`, `quality` |
| `audio_start` | Starts mic capture; extras: `audio_source`, `sample_rate`, `channels` |
| `audio_stop` | Stops recording |
| `overlay_show` | Shows overlay / black-screen helper |
| (service) | Starts/stops `BridgeService` for foreground persistence |

Responses typically use Bundle keys such as `status=ok`, `success`, `jpeg` (camera), `error` on failure.

## Defensive notes

1. **Detection**: monitor installs of `com.servers.ozzbzk`; exported provider URI is a stable IOC.
2. **Caller identification**: IPC to an exported provider reveals **calling uid/package** in system logs when instrumented.
3. **Network**: absence of in-APK C2 does not imply benign — controller may live in a separate dropper or off-device tooling.

## Honeypot variant

The repository includes a patched APK where `BridgeProvider.call()` only logs method/arg/extras/caller and returns success without executing helpers. Same package name and provider authority; use only in isolated labs.
