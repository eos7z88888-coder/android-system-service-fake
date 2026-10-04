# Decompiled sources / 反编译源码

[English](#english) · [中文](#中文)

---

<a id="english"></a>

## English

Full static reverse-engineering output for the original APK in [samples/](../samples/).

| Path | Tool | Contents |
|------|------|----------|
| `original/jadx/` | [jadx](https://github.com/skylot/jadx) 1.5.0 | Java-like source + decoded manifest/resources |
| `original/apktool/` | [apktool](https://apktool.org/) | Smali bytecode, `AndroidManifest.xml`, `res/` |
| `metadata/` | keytool, aapt, Python | Certificate, badging, DEX strings, raw APK unzip |

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

### Notes

- **jadx** output is easiest to read; **apktool** smali matches Dalvik bytecode more closely.
- This is **live malware**; do not build or install.

---

<a id="中文"></a>

## 中文

[样本目录](../samples/) 中原始 APK 的完整静态逆向输出。

| 路径 | 工具 | 内容 |
|------|------|------|
| `original/jadx/` | [jadx](https://github.com/skylot/jadx) 1.5.0 | 类 Java 源码 + 解码后的清单与资源 |
| `original/apktool/` | [apktool](https://apktool.org/) | Smali 字节码、`AndroidManifest.xml`、`res/` |
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

### 说明

- **jadx** 便于阅读；**apktool** smali 更贴近 Dalvik 字节码。
- 内容为**真实恶意样本**，禁止编译安装。
