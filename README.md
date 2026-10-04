# Android Bridge Backdoor: `com.servers.ozzbzk` / Android 桥接后门研究样本

[English](#english) · [中文](#中文)

---

<a id="english"></a>

## English

> **WARNING — LIVE MALWARE**  
> For **security research and defensive analysis only**. **Do not install** on any device.

### Summary

| Field | Value |
|-------|--------|
| Package | `com.servers.ozzbzk` |
| App label | System Service (disguise) |
| Type | Local IPC bridge (exported ContentProvider) |
| IPC authority | `content://com.servers.ozzbzk.bridge` |
| Network C2 in APK | **None observed** (external controller required) |

Small sideloaded APK (~33 KB) with an **exported** `BridgeProvider`. Other apps invoke `ContentResolver.call()` for surveillance, overlay, and phishing helpers. No embedded remote C2 URL in the binary.

### Repository layout

| Path | Description |
|------|-------------|
| [analysis/TECHNICAL_ANALYSIS.md](analysis/TECHNICAL_ANALYSIS.md) | Static analysis (architecture, IPC API, signing) |
| [decompiled/](decompiled/) | Full reverse-engineering output (jadx, apktool, metadata) |
| [iocs/SHA256SUMS.txt](iocs/SHA256SUMS.txt) | Sample hashes |
| [samples/](samples/) | Original APK, honeypot variant, sealed archive |

### Hashes

```
b693855c1e36cca582284f7f4582a3296ec5df4b4b8edfbfb4a085747feade4d  system_service_ORIGINAL_MALWARE.apk
82a32cada3bfd073f35c6fa0251eaf31b055565b282cc02b50cac73355a1ec38  system_service_HONEYPOT_VARIANT.apk
```

Certificate SHA256: `B6EDE6C79E7CCA3CA53121FC5F92ADD6F68559FA91113383A5A4531171CF92E3`  
Signer CN: `uNOewfBz`, O=Android, C=US (self-signed, from 2026-09-23)

### IPC commands (static analysis)

`content://com.servers.ozzbzk.bridge` → `BridgeProvider.call(method, arg, extras)`

| Method | Capability |
|--------|------------|
| `ping` | Health / version check |
| `phish_launch` | Phishing overlay (HTML / target package) |
| `camera_capture` | Camera capture (Camera2 / proxy) |
| `audio_start` / `audio_stop` | Microphone recording |
| `overlay_show` | Full-screen overlay / black screen |
| (others) | Foreground service, activity helpers |

### Honeypot variant

`system_service_HONEYPOT_VARIANT.apk` — receive-only patch: logs IPC, returns `{success=true}`, does not run payloads.

### Use

Analysis, detection rules, AV testing, education only. **Not** for deployment or unauthorized access.

Analysis text: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

---

<a id="中文"></a>

## 中文

> **警告 — 真实恶意软件**  
> 仅用于**安全研究与防御分析**。**禁止**在任意设备上安装运行。

### 概要

| 项目 | 值 |
|------|-----|
| 包名 | `com.servers.ozzbzk` |
| 显示名称 | System Service（伪装系统服务） |
| 类型 | 本地 IPC 桥接（导出 ContentProvider） |
| IPC 地址 | `content://com.servers.ozzbzk.bridge` |
| APK 内网络 C2 | **未发现**（需外部控制端） |

约 33 KB 侧载 APK，注册**已导出**的 `BridgeProvider`。同设备其他应用通过 `ContentResolver.call()` 触发监控、悬浮层、钓鱼等功能；二进制内无硬编码远程 C2 地址。

### 仓库结构

| 路径 | 说明 |
|------|------|
| [analysis/TECHNICAL_ANALYSIS.md](analysis/TECHNICAL_ANALYSIS.md) | 静态分析（架构、IPC 接口、签名） |
| [decompiled/](decompiled/) | 完整逆向输出（jadx、apktool、元数据） |
| [iocs/SHA256SUMS.txt](iocs/SHA256SUMS.txt) | 样本哈希 |
| [samples/](samples/) | 原始 APK、蜜罐变体、密封压缩包 |

### 哈希

```
b693855c1e36cca582284f7f4582a3296ec5df4b4b8edfbfb4a085747feade4d  system_service_ORIGINAL_MALWARE.apk
82a32cada3bfd073f35c6fa0251eaf31b055565b282cc02b50cac73355a1ec38  system_service_HONEYPOT_VARIANT.apk
```

证书 SHA256：`B6EDE6C79E7CCA3CA53121FC5F92ADD6F68559FA91113383A5A4531171CF92E3`  
签名者 CN：`uNOewfBz`，O=Android，C=US（自签名，2026-09-23 起）

### IPC 指令（静态分析）

`content://com.servers.ozzbzk.bridge` → `BridgeProvider.call(method, arg, extras)`

| 方法 | 能力 |
|------|------|
| `ping` | 存活 / 版本探测 |
| `phish_launch` | 钓鱼界面（HTML / 目标包名） |
| `camera_capture` | 静默拍照（Camera2 / 代理路径） |
| `audio_start` / `audio_stop` | 麦克风录音 |
| `overlay_show` | 全屏悬浮 / 黑屏 |
| （其他） | 前台服务保活、Activity 辅助 |

### 蜜罐变体

`system_service_HONEYPOT_VARIANT.apk` 为**仅接收**补丁版：记录 IPC 调用并返回 `{success=true}`，不执行恶意逻辑。

### 用途

仅限样本分析、检测规则、杀软测试与教学。**禁止**部署、免杀或未授权访问。

分析文档：[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)。
