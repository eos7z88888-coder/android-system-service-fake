.class Lcom/servers/ozzbzk/CameraCaptureHelper$2;
.super Landroid/hardware/camera2/CameraCaptureSession$StateCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/servers/ozzbzk/CameraCaptureHelper;->captureJpeg(I)[B
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/servers/ozzbzk/CameraCaptureHelper;

.field final synthetic val$sessionLatch:Ljava/util/concurrent/CountDownLatch;

.field final synthetic val$sessionRef:Ljava/util/concurrent/atomic/AtomicReference;


# direct methods
.method constructor <init>(Lcom/servers/ozzbzk/CameraCaptureHelper;Ljava/util/concurrent/atomic/AtomicReference;Ljava/util/concurrent/CountDownLatch;)V
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

    .line 181
    iput-object p1, p0, Lcom/servers/ozzbzk/CameraCaptureHelper$2;->this$0:Lcom/servers/ozzbzk/CameraCaptureHelper;

    iput-object p2, p0, Lcom/servers/ozzbzk/CameraCaptureHelper$2;->val$sessionRef:Ljava/util/concurrent/atomic/AtomicReference;

    iput-object p3, p0, Lcom/servers/ozzbzk/CameraCaptureHelper$2;->val$sessionLatch:Ljava/util/concurrent/CountDownLatch;

    invoke-direct {p0}, Landroid/hardware/camera2/CameraCaptureSession$StateCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onConfigureFailed(Landroid/hardware/camera2/CameraCaptureSession;)V
    .locals 0

    .line 190
    iget-object p1, p0, Lcom/servers/ozzbzk/CameraCaptureHelper$2;->val$sessionLatch:Ljava/util/concurrent/CountDownLatch;

    invoke-virtual {p1}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    return-void
.end method

.method public onConfigured(Landroid/hardware/camera2/CameraCaptureSession;)V
    .locals 1

    .line 184
    iget-object v0, p0, Lcom/servers/ozzbzk/CameraCaptureHelper$2;->val$sessionRef:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    .line 185
    iget-object p1, p0, Lcom/servers/ozzbzk/CameraCaptureHelper$2;->val$sessionLatch:Ljava/util/concurrent/CountDownLatch;

    invoke-virtual {p1}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    return-void
.end method
