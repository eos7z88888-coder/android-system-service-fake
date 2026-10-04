.class final Lcom/servers/ozzbzk/OverlayHelper$C2Bridge;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/servers/ozzbzk/OverlayHelper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "C2Bridge"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/servers/ozzbzk/OverlayHelper;


# direct methods
.method private constructor <init>(Lcom/servers/ozzbzk/OverlayHelper;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1010
        }
        names = {
            null
        }
    .end annotation

    .line 263
    iput-object p1, p0, Lcom/servers/ozzbzk/OverlayHelper$C2Bridge;->this$0:Lcom/servers/ozzbzk/OverlayHelper;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/servers/ozzbzk/OverlayHelper;Lcom/servers/ozzbzk/OverlayHelper$C2Bridge-IA;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/servers/ozzbzk/OverlayHelper$C2Bridge;-><init>(Lcom/servers/ozzbzk/OverlayHelper;)V

    return-void
.end method


# virtual methods
.method public submit(Ljava/lang/String;)V
    .locals 2
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 266
    iget-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper$C2Bridge;->this$0:Lcom/servers/ozzbzk/OverlayHelper;

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    const-string p1, "{}"

    :goto_0
    const/4 v1, 0x0

    invoke-static {v0, p1, v1}, Lcom/servers/ozzbzk/OverlayHelper;->-$$Nest$mdeliverResult(Lcom/servers/ozzbzk/OverlayHelper;Ljava/lang/String;Z)V

    return-void
.end method

.method public write(Ljava/lang/String;)V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .line 271
    invoke-virtual {p0, p1}, Lcom/servers/ozzbzk/OverlayHelper$C2Bridge;->submit(Ljava/lang/String;)V

    return-void
.end method
