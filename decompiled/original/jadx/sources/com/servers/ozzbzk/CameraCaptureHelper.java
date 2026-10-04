package com.servers.ozzbzk;

import android.content.Context;
import android.hardware.camera2.CameraAccessException;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraManager;
import android.media.Image;
import android.util.Log;
import java.nio.ByteBuffer;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;

/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class CameraCaptureHelper {
    private static final long CAPTURE_TIMEOUT_MS = 8000;
    private static final int HEIGHT = 480;
    private static final long STREAM_INTERVAL_MS = 500;
    private static final String TAG = "CameraCapture";
    private static final int WIDTH = 640;
    private final Context context;
    private volatile byte[] latestJpeg;
    private volatile Future<?> streamFuture;
    private final Object jpegLock = new Object();
    private final AtomicBoolean streaming = new AtomicBoolean(false);

    /* JADX INFO: Access modifiers changed from: package-private */
    public CameraCaptureHelper(Context context) {
        this.context = context;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public byte[] captureOnce(int i) {
        return captureJpeg(i);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public byte[] getLatestJpeg() {
        byte[] bArr;
        synchronized (this.jpegLock) {
            bArr = this.latestJpeg;
        }
        return bArr;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean isStreaming() {
        return this.streaming.get();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public synchronized void startStream(final int i) {
        if (this.streaming.get()) {
            return;
        }
        this.streaming.set(true);
        this.streamFuture = Scheduler.submitIo(new Runnable() { // from class: com.servers.ozzbzk.CameraCaptureHelper$$ExternalSyntheticLambda1
            @Override // java.lang.Runnable
            public final void run() {
                CameraCaptureHelper.this.m0lambda$startStream$0$comserversozzbzkCameraCaptureHelper(i);
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: lambda$startStream$0$com-servers-ozzbzk-CameraCaptureHelper, reason: not valid java name */
    public /* synthetic */ void m0lambda$startStream$0$comserversozzbzkCameraCaptureHelper(int i) {
        while (this.streaming.get()) {
            try {
                byte[] captureJpeg = captureJpeg(i);
                if (captureJpeg != null && captureJpeg.length > 0) {
                    synchronized (this.jpegLock) {
                        this.latestJpeg = captureJpeg;
                    }
                }
            } catch (Exception e) {
                Log.w(TAG, "stream capture failed: " + e.getMessage());
            }
            try {
                Thread.sleep(STREAM_INTERVAL_MS);
            } catch (InterruptedException unused) {
                Thread.currentThread().interrupt();
                return;
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public synchronized void stopStream() {
        this.streaming.set(false);
        Future<?> future = this.streamFuture;
        this.streamFuture = null;
        if (future != null) {
            future.cancel(true);
            try {
                future.get(2L, TimeUnit.SECONDS);
            } catch (Exception unused) {
            }
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:106:0x019c  */
    /* JADX WARN: Removed duplicated region for block: B:108:0x0195 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:112:0x018e A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:116:0x0187 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:125:0x017c  */
    /* JADX WARN: Removed duplicated region for block: B:127:0x0175 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:131:0x016e A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:135:0x0167 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:144:0x015c  */
    /* JADX WARN: Removed duplicated region for block: B:146:? A[SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:147:0x0155 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:151:0x014e A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:155:0x0147 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Type inference failed for: r5v0 */
    /* JADX WARN: Type inference failed for: r5v1 */
    /* JADX WARN: Type inference failed for: r5v11 */
    /* JADX WARN: Type inference failed for: r5v12 */
    /* JADX WARN: Type inference failed for: r5v13 */
    /* JADX WARN: Type inference failed for: r5v14 */
    /* JADX WARN: Type inference failed for: r5v17, types: [android.hardware.camera2.CameraCaptureSession] */
    /* JADX WARN: Type inference failed for: r5v18 */
    /* JADX WARN: Type inference failed for: r5v19 */
    /* JADX WARN: Type inference failed for: r5v2 */
    /* JADX WARN: Type inference failed for: r5v3 */
    /* JADX WARN: Type inference failed for: r5v4, types: [android.hardware.camera2.CameraCaptureSession] */
    /* JADX WARN: Type inference failed for: r5v5, types: [android.hardware.camera2.CameraCaptureSession] */
    /* JADX WARN: Type inference failed for: r5v6, types: [android.hardware.camera2.CameraCaptureSession] */
    /* JADX WARN: Type inference failed for: r5v7 */
    /* JADX WARN: Type inference failed for: r5v8 */
    /* JADX WARN: Type inference failed for: r5v9 */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private byte[] captureJpeg(int r15) {
        /*
            Method dump skipped, instructions count: 416
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.servers.ozzbzk.CameraCaptureHelper.captureJpeg(int):byte[]");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* JADX WARN: Code restructure failed: missing block: B:10:0x0034, code lost:
    
        return;
     */
    /* JADX WARN: Code restructure failed: missing block: B:14:0x0031, code lost:
    
        if (r1 == null) goto L8;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static /* synthetic */ void lambda$captureJpeg$1(java.util.concurrent.atomic.AtomicReference r3, java.util.concurrent.CountDownLatch r4, android.media.ImageReader r5) {
        /*
            java.lang.String r0 = "image acquire failed: "
            r1 = 0
            android.media.Image r1 = r5.acquireLatestImage()     // Catch: java.lang.Throwable -> L19 java.lang.Exception -> L1b
            if (r1 == 0) goto L10
            byte[] r5 = imageToBytes(r1)     // Catch: java.lang.Throwable -> L19 java.lang.Exception -> L1b
            r3.set(r5)     // Catch: java.lang.Throwable -> L19 java.lang.Exception -> L1b
        L10:
            if (r1 == 0) goto L15
        L12:
            r1.close()
        L15:
            r4.countDown()
            goto L34
        L19:
            r3 = move-exception
            goto L35
        L1b:
            r3 = move-exception
            java.lang.String r5 = "CameraCapture"
            java.lang.String r3 = r3.getMessage()     // Catch: java.lang.Throwable -> L19
            java.lang.StringBuilder r2 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> L19
            r2.<init>(r0)     // Catch: java.lang.Throwable -> L19
            r2.append(r3)     // Catch: java.lang.Throwable -> L19
            java.lang.String r3 = r2.toString()     // Catch: java.lang.Throwable -> L19
            android.util.Log.w(r5, r3)     // Catch: java.lang.Throwable -> L19
            if (r1 == 0) goto L15
            goto L12
        L34:
            return
        L35:
            if (r1 == 0) goto L3a
            r1.close()
        L3a:
            r4.countDown()
            throw r3
        */
        throw new UnsupportedOperationException("Method not decompiled: com.servers.ozzbzk.CameraCaptureHelper.lambda$captureJpeg$1(java.util.concurrent.atomic.AtomicReference, java.util.concurrent.CountDownLatch, android.media.ImageReader):void");
    }

    private static String pickCameraId(CameraManager cameraManager, int i) throws CameraAccessException {
        String[] cameraIdList = cameraManager.getCameraIdList();
        if (cameraIdList == null || cameraIdList.length == 0) {
            return null;
        }
        for (String str : cameraIdList) {
            Integer num = (Integer) cameraManager.getCameraCharacteristics(str).get(CameraCharacteristics.LENS_FACING);
            if (num != null && num.intValue() == 1) {
                return str;
            }
        }
        return cameraIdList[Math.min(Math.max(i, 0), cameraIdList.length - 1)];
    }

    private static byte[] imageToBytes(Image image) {
        Image.Plane[] planes = image.getPlanes();
        if (planes == null || planes.length == 0) {
            return null;
        }
        ByteBuffer buffer = planes[0].getBuffer();
        byte[] bArr = new byte[buffer.remaining()];
        buffer.get(bArr);
        return bArr;
    }
}
