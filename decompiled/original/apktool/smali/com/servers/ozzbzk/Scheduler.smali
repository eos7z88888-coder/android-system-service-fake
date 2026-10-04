.class final Lcom/servers/ozzbzk/Scheduler;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/servers/ozzbzk/Scheduler$NamedFactory;
    }
.end annotation


# static fields
.field private static final IO:Ljava/util/concurrent/ExecutorService;

.field private static final SCHED:Ljava/util/concurrent/ScheduledExecutorService;

.field private static final SEQ:Ljava/util/concurrent/atomic/AtomicInteger;


# direct methods
.method static bridge synthetic -$$Nest$sfgetSEQ()Ljava/util/concurrent/atomic/AtomicInteger;
    .locals 1

    sget-object v0, Lcom/servers/ozzbzk/Scheduler;->SEQ:Ljava/util/concurrent/atomic/AtomicInteger;

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 2

    .line 18
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>()V

    sput-object v0, Lcom/servers/ozzbzk/Scheduler;->SEQ:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 20
    new-instance v0, Lcom/servers/ozzbzk/Scheduler$NamedFactory;

    const-string v1, "br-io"

    invoke-direct {v0, v1}, Lcom/servers/ozzbzk/Scheduler$NamedFactory;-><init>(Ljava/lang/String;)V

    const/4 v1, 0x2

    invoke-static {v1, v0}, Ljava/util/concurrent/Executors;->newFixedThreadPool(ILjava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    sput-object v0, Lcom/servers/ozzbzk/Scheduler;->IO:Ljava/util/concurrent/ExecutorService;

    .line 21
    new-instance v0, Lcom/servers/ozzbzk/Scheduler$NamedFactory;

    const-string v1, "br-sched"

    invoke-direct {v0, v1}, Lcom/servers/ozzbzk/Scheduler$NamedFactory;-><init>(Ljava/lang/String;)V

    .line 22
    invoke-static {v0}, Ljava/util/concurrent/Executors;->newSingleThreadScheduledExecutor(Ljava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v0

    sput-object v0, Lcom/servers/ozzbzk/Scheduler;->SCHED:Ljava/util/concurrent/ScheduledExecutorService;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static scheduleAtFixedRate(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Runnable;",
            "JJ",
            "Ljava/util/concurrent/TimeUnit;",
            ")",
            "Ljava/util/concurrent/ScheduledFuture<",
            "*>;"
        }
    .end annotation

    .line 32
    sget-object v0, Lcom/servers/ozzbzk/Scheduler;->SCHED:Ljava/util/concurrent/ScheduledExecutorService;

    move-object v1, p0

    move-wide v2, p1

    move-wide v4, p3

    move-object v6, p5

    invoke-interface/range {v0 .. v6}, Ljava/util/concurrent/ScheduledExecutorService;->scheduleAtFixedRate(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object p0

    return-object p0
.end method

.method static submitIo(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Runnable;",
            ")",
            "Ljava/util/concurrent/Future<",
            "*>;"
        }
    .end annotation

    .line 27
    sget-object v0, Lcom/servers/ozzbzk/Scheduler;->IO:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v0, p0}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    move-result-object p0

    return-object p0
.end method
