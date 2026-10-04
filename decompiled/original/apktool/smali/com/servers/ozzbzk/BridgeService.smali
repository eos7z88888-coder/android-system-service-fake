.class public Lcom/servers/ozzbzk/BridgeService;
.super Landroid/app/Service;


# static fields
.field private static final CHANNEL_ID:Ljava/lang/String; = "bridge_service"

.field private static final NOTIFICATION_ID:I = 0x1


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    return-void
.end method

.method private buildNotification()Landroid/app/Notification;
    .locals 2

    .line 67
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    .line 68
    new-instance v0, Landroid/app/Notification$Builder;

    const-string v1, "bridge_service"

    invoke-direct {v0, p0, v1}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    .line 70
    :cond_0
    new-instance v0, Landroid/app/Notification$Builder;

    invoke-direct {v0, p0}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V

    .line 72
    :goto_0
    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v0

    .line 73
    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v0

    const v1, 0x1080041

    .line 74
    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v1, 0x1

    .line 75
    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    move-result-object v0

    const/4 v1, -0x2

    .line 76
    invoke-virtual {v0, v1}, Landroid/app/Notification$Builder;->setPriority(I)Landroid/app/Notification$Builder;

    move-result-object v0

    .line 77
    invoke-virtual {v0}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    return-object v0
.end method

.method private createChannel()V
    .locals 4

    .line 51
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-ge v0, v1, :cond_0

    return-void

    .line 52
    :cond_0
    new-instance v0, Landroid/app/NotificationChannel;

    const-string v1, "bridge_service"

    const-string v2, "System"

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 54
    invoke-virtual {v0, v3}, Landroid/app/NotificationChannel;->setShowBadge(Z)V

    const/4 v1, 0x0

    .line 55
    invoke-virtual {v0, v1, v1}, Landroid/app/NotificationChannel;->setSound(Landroid/net/Uri;Landroid/media/AudioAttributes;)V

    .line 56
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1d

    if-lt v1, v2, :cond_1

    .line 57
    invoke-virtual {v0, v3}, Landroid/app/NotificationChannel;->setImportance(I)V

    .line 59
    :cond_1
    const-class v1, Landroid/app/NotificationManager;

    invoke-virtual {p0, v1}, Lcom/servers/ozzbzk/BridgeService;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/NotificationManager;

    if-eqz v1, :cond_2

    .line 61
    invoke-virtual {v1, v0}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    :cond_2
    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()V
    .locals 4

    .line 27
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 28
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeService;->createChannel()V

    .line 29
    invoke-direct {p0}, Lcom/servers/ozzbzk/BridgeService;->buildNotification()Landroid/app/Notification;

    move-result-object v0

    .line 30
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x22

    const/4 v3, 0x1

    if-lt v1, v2, :cond_0

    const v1, 0x400000c0    # 2.0000458f

    .line 31
    invoke-virtual {p0, v3, v0, v1}, Lcom/servers/ozzbzk/BridgeService;->startForeground(ILandroid/app/Notification;I)V

    goto :goto_0

    .line 36
    :cond_0
    invoke-virtual {p0, v3, v0}, Lcom/servers/ozzbzk/BridgeService;->startForeground(ILandroid/app/Notification;)V

    :goto_0
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 0

    const/4 p1, 0x1

    return p1
.end method
