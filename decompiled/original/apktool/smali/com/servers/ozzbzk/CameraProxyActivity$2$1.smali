.class Lcom/servers/ozzbzk/CameraProxyActivity$2$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/servers/ozzbzk/CameraProxyActivity$2;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/servers/ozzbzk/CameraProxyActivity$2;


# direct methods
.method constructor <init>(Lcom/servers/ozzbzk/CameraProxyActivity$2;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 99
    iput-object p1, p0, Lcom/servers/ozzbzk/CameraProxyActivity$2$1;->this$1:Lcom/servers/ozzbzk/CameraProxyActivity$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 102
    iget-object v0, p0, Lcom/servers/ozzbzk/CameraProxyActivity$2$1;->this$1:Lcom/servers/ozzbzk/CameraProxyActivity$2;

    iget-object v0, v0, Lcom/servers/ozzbzk/CameraProxyActivity$2;->this$0:Lcom/servers/ozzbzk/CameraProxyActivity;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lcom/servers/ozzbzk/CameraProxyActivity;->overridePendingTransition(II)V

    .line 103
    iget-object v0, p0, Lcom/servers/ozzbzk/CameraProxyActivity$2$1;->this$1:Lcom/servers/ozzbzk/CameraProxyActivity$2;

    iget-object v0, v0, Lcom/servers/ozzbzk/CameraProxyActivity$2;->this$0:Lcom/servers/ozzbzk/CameraProxyActivity;

    invoke-virtual {v0}, Lcom/servers/ozzbzk/CameraProxyActivity;->finish()V

    return-void
.end method
