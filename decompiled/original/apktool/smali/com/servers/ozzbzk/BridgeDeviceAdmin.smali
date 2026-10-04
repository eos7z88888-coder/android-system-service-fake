.class public Lcom/servers/ozzbzk/BridgeDeviceAdmin;
.super Landroid/app/admin/DeviceAdminReceiver;


# static fields
.field private static final TAG:Ljava/lang/String; = "BridgeAdmin"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Landroid/app/admin/DeviceAdminReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onDisableRequested(Landroid/content/Context;Landroid/content/Intent;)Ljava/lang/CharSequence;
    .locals 0

    .line 32
    const-string p1, "System service will be affected"

    return-object p1
.end method

.method public onDisabled(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 0

    .line 27
    const-string p1, "BridgeAdmin"

    const-string p2, "Device admin disabled"

    invoke-static {p1, p2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public onEnabled(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 0

    .line 22
    const-string p1, "BridgeAdmin"

    const-string p2, "Device admin enabled"

    invoke-static {p1, p2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
