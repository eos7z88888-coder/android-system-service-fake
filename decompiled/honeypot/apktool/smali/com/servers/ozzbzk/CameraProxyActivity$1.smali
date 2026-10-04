.class Lcom/servers/ozzbzk/CameraProxyActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/servers/ozzbzk/CameraProxyActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/servers/ozzbzk/CameraProxyActivity;

.field final synthetic val$camId:I

.field final synthetic val$q:I


# direct methods
.method constructor <init>(Lcom/servers/ozzbzk/CameraProxyActivity;II)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010,
            0x1010
        }
        names = {
            null,
            null,
            null
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 67
    iput-object p1, p0, Lcom/servers/ozzbzk/CameraProxyActivity$1;->this$0:Lcom/servers/ozzbzk/CameraProxyActivity;

    iput p2, p0, Lcom/servers/ozzbzk/CameraProxyActivity$1;->val$camId:I

    iput p3, p0, Lcom/servers/ozzbzk/CameraProxyActivity$1;->val$q:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 70
    iget-object v0, p0, Lcom/servers/ozzbzk/CameraProxyActivity$1;->this$0:Lcom/servers/ozzbzk/CameraProxyActivity;

    iget v1, p0, Lcom/servers/ozzbzk/CameraProxyActivity$1;->val$camId:I

    iget v2, p0, Lcom/servers/ozzbzk/CameraProxyActivity$1;->val$q:I

    invoke-static {v0, v1, v2}, Lcom/servers/ozzbzk/CameraProxyActivity;->-$$Nest$mdoCapture(Lcom/servers/ozzbzk/CameraProxyActivity;II)V

    return-void
.end method
