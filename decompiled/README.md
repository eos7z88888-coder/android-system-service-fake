# Decompiled sources / 反编译源码

[English](#english) · [中文](#中文)

---

<a id="english"></a>

## English

Full static reverse-engineering output for both APK variants in [samples/](../samples/).

| Path | Tool | Contents |
|------|------|----------|
| `original/jadx/` | [jadx](https://github.com/skylot/jadx) 1.5.0 | Java-like source + decoded manifest/resources |
| `original/apktool/` | [apktool](https://apktool.org/) | Smali bytecode, `AndroidManifest.xml`, `res/` |
| `honeypot/jadx/` | jadx 1.5.0 | Honeypot variant (includes `CommandLogger.java`) |
| `honeypot/apktool/` | apktool | Honeypot smali |
| `metadata/` | keytool, aapt, Python | Certificates, badging, DEX strings, raw APK unzip |

### Key classes (`com.servers.ozzbzk`)

| Class | Role |
|-------|------|
| `BridgeProvider` | Exported IPC entry (`content://com.servers.ozzbzk.bridge`) |
| `BridgeService` | Foreground keep-alive |
| `CameraCaptureHelper` / `CameraProxyActivity` | Silent camera capture |
| `AudioCaptureHelper` | Microphone recording |
| `OverlayHelper` / `BlackScreenActivity` | Full-screen overlay |
| `PhishActivity` | Phishing WebView overlay |
| `BootReceiver` | Auto-start on boot |
| `BridgeDeviceAdmin` | Device admin receiver |
| `Scheduler` | Background task scheduling |
| `CommandLogger` | **Honeypot only** — logs IPC, no payload execution |

### Notes

- **jadx** output is easiest to read; **apktool** smali matches Dalvik bytecode more closely.
- `original/` is the **live malware**; do not build or install.
- `honeypot/` is a research patch that records calls and returns `{success=true}`.

---

<a id="中文"></a>

## 中文

[样本目录](../samples/) 中两个 APK 的完整静态逆向输出。

| 路径 | 工具 | 内容 |
|------|------|------|
| `original/jadx/` | [jadx](https://github.com/skylot/jadx) 1.5.0 | 类 Java 源码 + 解码后的清单与资源 |
| `original/apktool/` | [apktool](https://apktool.org/) | Smali 字节码、`AndroidManifest.xml`、`res/` |
| `honeypot/jadx/` | jadx 1.5.0 | 蜜罐变体（含 `CommandLogger.java`） |
| `honeypot/apktool/` | apktool | 蜜罐 smali |
| `metadata/` | keytool、aapt、Python | 证书、badging、DEX 字符串、APK 原始解压 |

### 主要类（`com.servers.ozzbzk`）

| 类 | 作用 |
|----|------|
| `BridgeProvider` | 导出的 IPC 入口（`content://com.servers.ozzbzk.bridge`） |
| `BridgeService` | 前台保活 |
| `CameraCaptureHelper` / `CameraProxyActivity` | 静默拍照 |
| `AudioCaptureHelper` | 麦克风录音 |
| `OverlayHelper` / `BlackScreenActivity` | 全屏悬浮层 |
| `PhishActivity` | 钓鱼 WebView |
| `BootReceiver` | 开机自启 |
| `BridgeDeviceAdmin` | 设备管理员接收器 |
| `Scheduler` | 后台任务调度 |
| `CommandLogger` | **仅蜜罐版** — 记录 IPC，不执行恶意逻辑 |

### 说明

- **jadx** 便于阅读；**apktool** smali 更贴近 Dalvik 字节码。
- `original/` 为**真实恶意样本**，禁止编译安装。
- `honeypot/` 为研究用补丁，仅记录调用并返回 `{success=true}`。
