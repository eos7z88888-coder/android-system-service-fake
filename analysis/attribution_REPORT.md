# Attribution Report: com.servers.ozzbzk / System Service

## Verdict
- Malware is a LOCAL IPC BRIDGE payload (no hardcoded network C2 in APK).
- On this device: delivered via Douyin IM, installed by user, NEVER launched for C2 use.
- No companion controller app found among installed 3rd-party packages.
- Therefore: nobody successfully controlled this implant on-device; intended controller is external (Douyin sender + separate panel/companion not present).

## Delivery chain (usagestats + events)
1. 10:54 Douyin MainActivity
2. 10:54:59 Douyin IM FilePreviewActivity
3. Multiple install attempts via Chooser -> PackageInstaller (blocked/cancelled)
4. 10:58:36 back to Douyin ChatRoomActivity -> FilePreview -> install attempts
5. 11:04:06 Douyin ChatRoom -> FilePreview -> Chooser -> PackageInstaller
6. 11:04:22-25 Confirm Vivo PIN -> NewInstallInstalling SUCCESS (PACKAGE_ADDED com.servers.ozzbzk)
7. 11:04:28+ MT Manager opened (analysis, not C2)

## Control model
content://com.servers.ozzbzk.bridge (exported) accepts call() commands.
Controller must be: another app, adb, or Frida - NOT embedded in this APK.

## Signer
CN=uNOewfBz, O=Android, C=US
Valid from 2026-09-23 (fresh build)
SHA256 cert: B6EDE6C79E7CCA3CA53121FC5F92ADD6F68559FA91113383A5A4531171CF92E3
APK SHA256: B693855C1E36CCA582284F7F4582A3296EC5DF4B4B8EDFBFB4A085747FEADE4D
