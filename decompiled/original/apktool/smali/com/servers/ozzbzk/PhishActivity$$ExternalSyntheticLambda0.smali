.class public final synthetic Lcom/servers/ozzbzk/PhishActivity$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/servers/ozzbzk/PhishActivity;


# direct methods
.method public synthetic constructor <init>(Lcom/servers/ozzbzk/PhishActivity;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/servers/ozzbzk/PhishActivity$$ExternalSyntheticLambda0;->f$0:Lcom/servers/ozzbzk/PhishActivity;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/servers/ozzbzk/PhishActivity$$ExternalSyntheticLambda0;->f$0:Lcom/servers/ozzbzk/PhishActivity;

    invoke-virtual {v0}, Lcom/servers/ozzbzk/PhishActivity;->lambda$scheduleSoftDismiss$0$com-servers-ozzbzk-PhishActivity()V

    return-void
.end method
