.class Lcom/servers/ozzbzk/CameraCaptureHelper$1;
.super Landroid/hardware/camera2/CameraDevice$StateCallback;


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

.field final synthetic val$deviceRef:Ljava/util/concurrent/atomic/AtomicReference;

.field final synthetic val$opened:Ljava/util/concurrent/CountDownLatch;


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

    .line 126
    iput-object p1, p0, Lcom/servers/ozzbzk/CameraCaptureHelper$1;->this$0:Lcom/servers/ozzbzk/CameraCaptureHelper;

    iput-object p2, p0, Lcom/servers/ozzbzk/CameraCaptureHelper$1;->val$deviceRef:Ljava/util/concurrent/atomic/AtomicReference;

    iput-object p3, p0, Lcom/servers/ozzbzk/CameraCaptureHelper$1;->val$opened:Ljava/util/concurrent/CountDownLatch;

    invoke-direct {p0}, Landroid/hardware/camera2/CameraDevice$StateCallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onDisconnected(Landroid/hardware/camera2/CameraDevice;)V
    .locals 0

    .line 135
    invoke-virtual {p1}, Landroid/hardware/camera2/CameraDevice;->close()V

    .line 136
    iget-object p1, p0, Lcom/servers/ozzbzk/CameraCaptureHelper$1;->val$opened:Ljava/util/concurrent/CountDownLatch;

    invoke-virtual {p1}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    return-void
.end method

.method public onError(Landroid/hardware/camera2/CameraDevice;I)V
    .locals 0

    .line 141
    invoke-virtual {p1}, Landroid/hardware/camera2/CameraDevice;->close()V

    .line 142
    iget-object p1, p0, Lcom/servers/ozzbzk/CameraCaptureHelper$1;->val$opened:Ljava/util/concurrent/CountDownLatch;

    invoke-virtual {p1}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    return-void
.end method

.method public onOpened(Landroid/hardware/camera2/CameraDevice;)V
    .locals 1

    .line 129
    iget-object v0, p0, Lcom/servers/ozzbzk/CameraCaptureHelper$1;->val$deviceRef:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    .line 130
    iget-object p1, p0, Lcom/servers/ozzbzk/CameraCaptureHelper$1;->val$opened:Ljava/util/concurrent/CountDownLatch;

    invoke-virtual {p1}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    return-void
.end method
