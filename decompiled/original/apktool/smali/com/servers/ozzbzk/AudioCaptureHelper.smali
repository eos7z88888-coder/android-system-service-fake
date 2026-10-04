.class final Lcom/servers/ozzbzk/AudioCaptureHelper;
.super Ljava/lang/Object;


# static fields
.field private static final AUDIO_SOURCE_REMOTE_SUBMIX:I = 0x8

.field private static final CHANNEL_CONFIG:I = 0x10

.field private static final CHUNK_MS:I = 0x64

.field private static final ENCODING:I = 0x2

.field private static final SAMPLE_RATE:I = 0x1f40

.field private static final TAG:Ljava/lang/String; = "AudioCapture"


# instance fields
.field private volatile channels:I

.field private volatile latestPcm:[B

.field private final lock:Ljava/lang/Object;

.field private volatile readFuture:Ljava/util/concurrent/Future;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/Future<",
            "*>;"
        }
    .end annotation
.end field

.field private recorder:Landroid/media/AudioRecord;

.field private final recording:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private volatile sampleRate:I

.field private volatile source:Ljava/lang/String;


# direct methods
.method public static synthetic $r8$lambda$4LIfRXEoMYMJOkMS5pDG2hSG8DY(Lcom/servers/ozzbzk/AudioCaptureHelper;)V
    .locals 0

    invoke-direct {p0}, Lcom/servers/ozzbzk/AudioCaptureHelper;->readLoop()V

    return-void
.end method

.method constructor <init>(Landroid/content/Context;)V
    .locals 1

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    new-instance p1, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v0, 0x0

    invoke-direct {p1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object p1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->recording:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 27
    new-instance p1, Ljava/lang/Object;

    invoke-direct {p1}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->lock:Ljava/lang/Object;

    const/16 p1, 0x1f40

    .line 31
    iput p1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->sampleRate:I

    const/4 p1, 0x1

    .line 32
    iput p1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->channels:I

    .line 33
    const-string p1, "mic"

    iput-object p1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->source:Ljava/lang/String;

    return-void
.end method

.method private static isSystemSource(Ljava/lang/String;)Z
    .locals 2

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return v0

    .line 200
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    .line 201
    const-string v1, "system"

    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "internal"

    .line 202
    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "remote_submix"

    .line 203
    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "submix"

    .line 204
    invoke-virtual {v1, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_2

    :cond_1
    const/4 v0, 0x1

    :cond_2
    return v0
.end method

.method private static normalizeSource(Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 208
    invoke-static {p0}, Lcom/servers/ozzbzk/AudioCaptureHelper;->isSystemSource(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    const-string p0, "system"

    goto :goto_0

    :cond_0
    const-string p0, "mic"

    :goto_0
    return-object p0
.end method

.method private readLoop()V
    .locals 2

    .line 150
    :goto_0
    iget-object v0, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->recording:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 151
    invoke-direct {p0}, Lcom/servers/ozzbzk/AudioCaptureHelper;->readOnce()[B

    move-result-object v0

    if-eqz v0, :cond_0

    .line 152
    array-length v1, v0

    if-lez v1, :cond_0

    .line 153
    iput-object v0, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->latestPcm:[B

    goto :goto_0

    :cond_0
    const-wide/16 v0, 0x14

    .line 156
    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 158
    :catch_0
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    :cond_1
    return-void
.end method

.method private readOnce()[B
    .locals 5

    .line 166
    iget-object v0, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->recorder:Landroid/media/AudioRecord;

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    .line 167
    iget-object v2, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->recording:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v2

    if-nez v2, :cond_0

    goto :goto_0

    .line 170
    :cond_0
    iget v2, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->sampleRate:I

    iget v3, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->channels:I

    mul-int v2, v2, v3

    mul-int/lit16 v2, v2, 0xc8

    div-int/lit16 v2, v2, 0x3e8

    const/16 v3, 0x140

    .line 171
    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v2

    new-array v3, v2, [B

    const/4 v4, 0x0

    .line 174
    :try_start_0
    invoke-virtual {v0, v3, v4, v2}, Landroid/media/AudioRecord;->read([BII)I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-gtz v0, :cond_1

    return-object v1

    :cond_1
    if-ne v0, v2, :cond_2

    return-object v3

    .line 184
    :cond_2
    new-array v1, v0, [B

    .line 185
    invoke-static {v3, v4, v1, v4, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    :catch_0
    :cond_3
    :goto_0
    return-object v1
.end method

.method private static resolveAudioSource(Ljava/lang/String;)I
    .locals 0

    .line 190
    invoke-static {p0}, Lcom/servers/ozzbzk/AudioCaptureHelper;->isSystemSource(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/16 p0, 0x8

    return p0

    :cond_0
    const/4 p0, 0x1

    return p0
.end method

.method private stopLocked()V
    .locals 6

    .line 101
    const-string v0, "AudioCapture"

    iget-object v1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->recording:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 102
    iget-object v1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->readFuture:Ljava/util/concurrent/Future;

    const/4 v2, 0x0

    .line 103
    iput-object v2, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->readFuture:Ljava/util/concurrent/Future;

    if-eqz v1, :cond_0

    const/4 v3, 0x1

    .line 105
    invoke-interface {v1, v3}, Ljava/util/concurrent/Future;->cancel(Z)Z

    .line 107
    :cond_0
    iget-object v1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->recorder:Landroid/media/AudioRecord;

    .line 108
    iput-object v2, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->recorder:Landroid/media/AudioRecord;

    if-eqz v1, :cond_1

    .line 111
    :try_start_0
    invoke-virtual {v1}, Landroid/media/AudioRecord;->stop()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v3

    .line 113
    invoke-virtual {v3}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "recorderStop: "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 116
    :goto_0
    :try_start_1
    invoke-virtual {v1}, Landroid/media/AudioRecord;->release()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception v1

    .line 118
    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "recorderRelease: "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 121
    :cond_1
    :goto_1
    iput-object v2, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->latestPcm:[B

    return-void
.end method


# virtual methods
.method getSource()Ljava/lang/String;
    .locals 1

    .line 129
    iget-object v0, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->source:Ljava/lang/String;

    return-object v0
.end method

.method isRecording()Z
    .locals 1

    .line 125
    iget-object v0, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->recording:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    return v0
.end method

.method poll()Landroid/os/Bundle;
    .locals 4

    .line 133
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 134
    iget-object v1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->latestPcm:[B

    if-eqz v1, :cond_0

    .line 135
    array-length v2, v1

    if-nez v2, :cond_1

    .line 136
    :cond_0
    invoke-direct {p0}, Lcom/servers/ozzbzk/AudioCaptureHelper;->readOnce()[B

    move-result-object v1

    .line 138
    :cond_1
    const-string v2, "success"

    if-eqz v1, :cond_3

    array-length v3, v1

    if-nez v3, :cond_2

    goto :goto_0

    :cond_2
    const/4 v3, 0x0

    .line 143
    iput-object v3, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->latestPcm:[B

    const/4 v3, 0x1

    .line 144
    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 145
    const-string v2, "pcm"

    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->putByteArray(Ljava/lang/String;[B)V

    return-object v0

    :cond_3
    :goto_0
    const/4 v1, 0x0

    .line 139
    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 140
    const-string v1, "error"

    const-string v2, "no pcm"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method start()Z
    .locals 3

    const/16 v0, 0x1f40

    const/4 v1, 0x1

    .line 39
    const-string v2, "mic"

    invoke-virtual {p0, v2, v0, v1}, Lcom/servers/ozzbzk/AudioCaptureHelper;->start(Ljava/lang/String;II)Z

    move-result v0

    return v0
.end method

.method start(Ljava/lang/String;)Z
    .locals 2

    const/16 v0, 0x1f40

    const/4 v1, 0x1

    .line 46
    invoke-virtual {p0, p1, v0, v1}, Lcom/servers/ozzbzk/AudioCaptureHelper;->start(Ljava/lang/String;II)Z

    move-result p1

    return p1
.end method

.method start(Ljava/lang/String;II)Z
    .locals 10

    .line 50
    iget-object v0, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 51
    :try_start_0
    invoke-direct {p0}, Lcom/servers/ozzbzk/AudioCaptureHelper;->stopLocked()V

    .line 52
    invoke-static {p1}, Lcom/servers/ozzbzk/AudioCaptureHelper;->normalizeSource(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->source:Ljava/lang/String;

    if-lez p2, :cond_0

    goto :goto_0

    :cond_0
    const/16 p2, 0x1f40

    .line 53
    :goto_0
    iput p2, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->sampleRate:I

    const/4 p1, 0x2

    const/4 p2, 0x1

    if-lt p3, p1, :cond_1

    const/4 p3, 0x2

    goto :goto_1

    :cond_1
    const/4 p3, 0x1

    .line 54
    :goto_1
    iput p3, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->channels:I

    .line 55
    iget p3, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->channels:I

    if-lt p3, p1, :cond_2

    const/16 p3, 0xc

    goto :goto_2

    :cond_2
    const/16 p3, 0x10

    .line 58
    :goto_2
    iget v1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->sampleRate:I

    invoke-static {v1, p3, p1}, Landroid/media/AudioRecord;->getMinBufferSize(III)I

    move-result p1

    const/4 v7, 0x0

    if-gtz p1, :cond_3

    .line 60
    monitor-exit v0

    return v7

    .line 62
    :cond_3
    iget v1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->sampleRate:I

    iget v2, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->channels:I

    mul-int v1, v1, v2

    mul-int/lit16 v1, v1, 0xc8

    div-int/lit16 v1, v1, 0x3e8

    invoke-static {p1, v1}, Ljava/lang/Math;->max(II)I

    move-result p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 64
    :try_start_1
    iget-object v1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->source:Ljava/lang/String;

    invoke-static {v1}, Lcom/servers/ozzbzk/AudioCaptureHelper;->resolveAudioSource(Ljava/lang/String;)I

    move-result v8

    .line 65
    new-instance v9, Landroid/media/AudioRecord;

    iget v3, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->sampleRate:I

    const/4 v5, 0x2

    move-object v1, v9

    move v2, v8

    move v4, p3

    move v6, p1

    invoke-direct/range {v1 .. v6}, Landroid/media/AudioRecord;-><init>(IIIII)V

    .line 68
    invoke-virtual {v9}, Landroid/media/AudioRecord;->getState()I

    move-result v1

    if-eq v1, p2, :cond_6

    .line 69
    invoke-virtual {v9}, Landroid/media/AudioRecord;->release()V

    if-eq v8, p2, :cond_5

    .line 71
    new-instance v9, Landroid/media/AudioRecord;

    iget v3, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->sampleRate:I

    const/4 v5, 0x2

    const/4 v2, 0x1

    move-object v1, v9

    move v4, p3

    move v6, p1

    invoke-direct/range {v1 .. v6}, Landroid/media/AudioRecord;-><init>(IIIII)V

    .line 74
    invoke-virtual {v9}, Landroid/media/AudioRecord;->getState()I

    move-result p1

    if-eq p1, p2, :cond_4

    .line 75
    invoke-virtual {v9}, Landroid/media/AudioRecord;->release()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 76
    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    return v7

    .line 78
    :cond_4
    :try_start_3
    const-string p1, "mic"

    iput-object p1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->source:Ljava/lang/String;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_3

    .line 80
    :cond_5
    :try_start_4
    monitor-exit v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    return v7

    .line 83
    :cond_6
    :goto_3
    :try_start_5
    invoke-virtual {v9}, Landroid/media/AudioRecord;->startRecording()V

    .line 84
    iput-object v9, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->recorder:Landroid/media/AudioRecord;

    .line 85
    iget-object p1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->recording:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {p1, p2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 86
    new-instance p1, Lcom/servers/ozzbzk/AudioCaptureHelper$$ExternalSyntheticLambda0;

    invoke-direct {p1, p0}, Lcom/servers/ozzbzk/AudioCaptureHelper$$ExternalSyntheticLambda0;-><init>(Lcom/servers/ozzbzk/AudioCaptureHelper;)V

    invoke-static {p1}, Lcom/servers/ozzbzk/Scheduler;->submitIo(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    move-result-object p1

    iput-object p1, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->readFuture:Ljava/util/concurrent/Future;
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 87
    :try_start_6
    monitor-exit v0

    return p2

    .line 89
    :catch_0
    monitor-exit v0

    return v7

    :catchall_0
    move-exception p1

    .line 91
    monitor-exit v0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    throw p1
.end method

.method stop()V
    .locals 2

    .line 95
    iget-object v0, p0, Lcom/servers/ozzbzk/AudioCaptureHelper;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 96
    :try_start_0
    invoke-direct {p0}, Lcom/servers/ozzbzk/AudioCaptureHelper;->stopLocked()V

    .line 97
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method
