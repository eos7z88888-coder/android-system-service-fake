.class public final synthetic Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/servers/ozzbzk/OverlayHelper;

.field public final synthetic f$1:Ljava/util/concurrent/atomic/AtomicReference;

.field public final synthetic f$2:Ljava/lang/String;

.field public final synthetic f$3:Ljava/lang/String;

.field public final synthetic f$4:Ljava/lang/String;

.field public final synthetic f$5:Ljava/util/concurrent/CountDownLatch;


# direct methods
.method public synthetic constructor <init>(Lcom/servers/ozzbzk/OverlayHelper;Ljava/util/concurrent/atomic/AtomicReference;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/concurrent/CountDownLatch;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;->f$0:Lcom/servers/ozzbzk/OverlayHelper;

    iput-object p2, p0, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;->f$1:Ljava/util/concurrent/atomic/AtomicReference;

    iput-object p3, p0, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;->f$2:Ljava/lang/String;

    iput-object p4, p0, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;->f$3:Ljava/lang/String;

    iput-object p5, p0, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;->f$4:Ljava/lang/String;

    iput-object p6, p0, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;->f$5:Ljava/util/concurrent/CountDownLatch;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 6

    .line 0
    iget-object v0, p0, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;->f$0:Lcom/servers/ozzbzk/OverlayHelper;

    iget-object v1, p0, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;->f$1:Ljava/util/concurrent/atomic/AtomicReference;

    iget-object v2, p0, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;->f$2:Ljava/lang/String;

    iget-object v3, p0, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;->f$3:Ljava/lang/String;

    iget-object v4, p0, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;->f$4:Ljava/lang/String;

    iget-object v5, p0, Lcom/servers/ozzbzk/OverlayHelper$$ExternalSyntheticLambda2;->f$5:Ljava/util/concurrent/CountDownLatch;

    invoke-virtual/range {v0 .. v5}, Lcom/servers/ozzbzk/OverlayHelper;->lambda$show$0$com-servers-ozzbzk-OverlayHelper(Ljava/util/concurrent/atomic/AtomicReference;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/concurrent/CountDownLatch;)V

    return-void
.end method
