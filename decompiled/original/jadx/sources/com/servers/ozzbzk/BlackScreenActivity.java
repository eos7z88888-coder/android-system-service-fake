package com.servers.ozzbzk;

import android.app.Activity;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.Window;

/* loaded from: classes.dex */
public class BlackScreenActivity extends Activity {
    @Override // android.app.Activity, android.view.Window.Callback
    public boolean dispatchTouchEvent(MotionEvent motionEvent) {
        return true;
    }

    @Override // android.app.Activity
    public void onBackPressed() {
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        return true;
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyUp(int i, KeyEvent keyEvent) {
        return true;
    }

    @Override // android.app.Activity
    public boolean onTouchEvent(MotionEvent motionEvent) {
        return true;
    }

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        if (handleFinishIntent(getIntent())) {
            return;
        }
        requestWindowFeature(1);
        Window window = getWindow();
        window.addFlags(6817408);
        if (Build.VERSION.SDK_INT >= 27) {
            setShowWhenLocked(true);
            setTurnScreenOn(true);
        }
        if (Build.VERSION.SDK_INT >= 28) {
            window.getAttributes().layoutInDisplayCutoutMode = 1;
        }
        View view = new View(this);
        view.setBackgroundColor(-16777216);
        view.setSystemUiVisibility(5894);
        setContentView(view);
    }

    @Override // android.app.Activity
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        handleFinishIntent(intent);
    }

    private boolean handleFinishIntent(Intent intent) {
        if (intent == null || !"finish".equals(intent.getStringExtra("action"))) {
            return false;
        }
        finish();
        return true;
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onWindowFocusChanged(boolean z) {
        super.onWindowFocusChanged(z);
        if (z) {
            getWindow().getDecorView().setSystemUiVisibility(5894);
        }
    }
}
