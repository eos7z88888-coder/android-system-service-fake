# Technical Analysis / 技术分析：`com.servers.ozzbzk`

[English](#english) · [中文](#中文)

---

<a id="english"></a>

## English

Static analysis of the Android bridge implant. Technical documentation only — **no distribution chain or device-specific attribution**.

### Architecture

```
External controller (app / adb / instrumentation)
        │  ContentResolver.call(method, arg, extras)
        ▼
content://com.servers.ozzbzk.bridge  (exported BridgeProvider)
        ├── CameraCaptureHelper
        ├── AudioCaptureHelper
        ├── OverlayHelper
        └── BridgeService (foreground persistence)
```

**Local IPC bridge.** No hardcoded HTTP/WebSocket C2 in the analyzed binary. A separate operator must know the provider URI and command set.

### Manifest / exposure

- Package: `com.servers.ozzbzk`
- Label mimics a system component ("System Service")
- `BridgeProvider` is **exported** — callable by other apps (subject to Android visibility rules)

### Signing

| Field | Value |
|-------|--------|
| CN | uNOewfBz |
| O | Android |
| C | US |
| Cert SHA256 | B6EDE6C79E7CCA3CA53121FC5F92ADD6F68559FA91113383A5A4531171CF92E3 |
| APK SHA256 | B693855C1E36CCA582284F7F4582A3296EC5DF4B4B8EDFBFB4A085747FEADE4D |
| APK size | ~33 KB |

Self-signed cert (valid from 2026-09-23); typical of a fresh implant, not Play Store distribution.

### BridgeProvider API

```java
getContentResolver().call(
    Uri.parse("content://com.servers.ozzbzk.bridge"),
    "<method>",
    "<arg>",
    extras  // optional Bundle
);
```

| Method | Behavior |
|--------|----------|
| `ping` | Status / version |
| `phish_launch` | Phishing UI; HTML (Base64 ok), `target_pkg`; writes `phish_pending.json` |
| `camera_capture` | JPEG via Camera1/2/proxy; extras: `camera_id`, `quality` |
| `audio_start` | Mic capture; extras: `audio_source`, `sample_rate`, `channels` |
| `audio_stop` | Stop recording |
| `overlay_show` | Overlay / black-screen |
| (service) | Start/stop `BridgeService` |

Responses often use Bundle keys: `status=ok`, `success`, `jpeg`, `error`.

### Defensive notes

1. **Detection**: watch for package `com.servers.ozzbzk`; provider URI is a stable IOC.
2. **Caller ID**: exported provider IPC exposes **caller uid/package** when logged.
3. **Network**: no in-APK C2 ≠ benign; controller may be another app or off-device.

### Honeypot variant

Patched APK: `call()` logs only, returns success, same package/authority. Lab use only.

---

<a id="中文"></a>

## 中文

Android 桥接木马的静态分析，**仅技术说明**，不含传播链或设备归因信息。

### 架构

```
外部控制端（独立 App / adb / 插桩）
        │  ContentResolver.call(method, arg, extras)
        ▼
content://com.servers.ozzbzk.bridge  （已导出 BridgeProvider）
        ├── CameraCaptureHelper      相机
        ├── AudioCaptureHelper       录音
        ├── OverlayHelper            悬浮层
        └── BridgeService            前台保活
```

**本地 IPC 桥**，分析二进制中无硬编码 HTTP/WebSocket C2；需已知 URI 与指令集的外部操作者。

### Manifest / 暴露面

- 包名：`com.servers.ozzbzk`
- 界面名称伪装为「System Service」
- `BridgeProvider` **exported**，可被其他应用调用（受 Android 可见性策略约束）

### 签名

| 字段 | 值 |
|------|-----|
| CN | uNOewfBz |
| O | Android |
| C | US |
| 证书 SHA256 | B6EDE6C79E7CCA3CA53121FC5F92ADD6F68559FA91113383A5A4531171CF92E3 |
| APK SHA256 | B693855C1E36CCA582284F7F4582A3296EC5DF4B4B8EDFBFB4A085747FEADE4D |
| APK 大小 | 约 33 KB |

自签名证书（2026-09-23 起），符合非商店分发的小型植入特征。

### BridgeProvider 接口

```java
getContentResolver().call(
    Uri.parse("content://com.servers.ozzbzk.bridge"),
    "<method>",
    "<arg>",
    extras  // 可选 Bundle
);
```

| 方法 | 行为 |
|------|------|
| `ping` | 状态 / 版本 |
| `phish_launch` | 钓鱼 UI；支持 HTML（可 Base64）、`target_pkg`；写入 `phish_pending.json` |
| `camera_capture` | JPEG 拍照（Camera1/2/代理）；参数：`camera_id`、`quality` |
| `audio_start` | 开始录音；参数：`audio_source`、`sample_rate`、`channels` |
| `audio_stop` | 停止录音 |
| `overlay_show` | 悬浮层 / 黑屏 |
| （服务） | 启停 `BridgeService` 前台服务 |

返回 Bundle 常见键：`status=ok`、`success`、`jpeg`、`error`。

### 防御要点

1. **检测**：监控包名 `com.servers.ozzbzk`；Provider URI 为稳定 IOC。
2. **调用方识别**：对已导出 Provider 的 IPC 可记录**调用方 uid/包名**。
3. **网络**：APK 内无 C2 不等于安全；控制端可能在其他 App 或设备外。

### 蜜罐变体

补丁版 `call()` 仅记录日志并返回成功，包名与 authority 不变；仅限隔离实验环境。
