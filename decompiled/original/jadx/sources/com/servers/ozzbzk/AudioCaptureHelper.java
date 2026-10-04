package com.servers.ozzbzk;

import android.content.Context;
import android.media.AudioRecord;
import android.os.Bundle;
import android.util.Log;
import java.util.concurrent.Future;
import java.util.concurrent.atomic.AtomicBoolean;

/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class AudioCaptureHelper {
    private static final int AUDIO_SOURCE_REMOTE_SUBMIX = 8;
    private static final int CHANNEL_CONFIG = 16;
    private static final int CHUNK_MS = 100;
    private static final int ENCODING = 2;
    private static final int SAMPLE_RATE = 8000;
    private static final String TAG = "AudioCapture";
    private volatile byte[] latestPcm;
    private volatile Future<?> readFuture;
    private AudioRecord recorder;
    private final AtomicBoolean recording = new AtomicBoolean(false);
    private final Object lock = new Object();
    private volatile int sampleRate = SAMPLE_RATE;
    private volatile int channels = 1;
    private volatile String source = "mic";

    /* JADX INFO: Access modifiers changed from: package-private */
    public AudioCaptureHelper(Context context) {
    }

    boolean start() {
        return start("mic", SAMPLE_RATE, 1);
    }

    boolean start(String str) {
        return start(str, SAMPLE_RATE, 1);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean start(String str, int i, int i2) {
        synchronized (this.lock) {
            stopLocked();
            this.source = normalizeSource(str);
            if (i <= 0) {
                i = SAMPLE_RATE;
            }
            this.sampleRate = i;
            this.channels = i2 >= ENCODING ? ENCODING : 1;
            int i3 = this.channels >= ENCODING ? 12 : CHANNEL_CONFIG;
            int minBufferSize = AudioRecord.getMinBufferSize(this.sampleRate, i3, ENCODING);
            if (minBufferSize <= 0) {
                return false;
            }
            int max = Math.max(minBufferSize, ((this.sampleRate * this.channels) * 200) / 1000);
            try {
                int resolveAudioSource = resolveAudioSource(this.source);
                AudioRecord audioRecord = new AudioRecord(resolveAudioSource, this.sampleRate, i3, ENCODING, max);
                if (audioRecord.getState() != 1) {
                    audioRecord.release();
                    if (resolveAudioSource == 1) {
                        return false;
                    }
                    audioRecord = new AudioRecord(1, this.sampleRate, i3, ENCODING, max);
                    if (audioRecord.getState() != 1) {
                        audioRecord.release();
                        return false;
                    }
                    this.source = "mic";
                }
                audioRecord.startRecording();
                this.recorder = audioRecord;
                this.recording.set(true);
                this.readFuture = Scheduler.submitIo(new Runnable() { // from class: com.servers.ozzbzk.AudioCaptureHelper$$ExternalSyntheticLambda0
                    @Override // java.lang.Runnable
                    public final void run() {
                        AudioCaptureHelper.this.readLoop();
                    }
                });
                return true;
            } catch (Exception unused) {
                return false;
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void stop() {
        synchronized (this.lock) {
            stopLocked();
        }
    }

    private void stopLocked() {
        this.recording.set(false);
        Future<?> future = this.readFuture;
        this.readFuture = null;
        if (future != null) {
            future.cancel(true);
        }
        AudioRecord audioRecord = this.recorder;
        this.recorder = null;
        if (audioRecord != null) {
            try {
                audioRecord.stop();
            } catch (Exception e) {
                Log.w(TAG, "recorderStop: " + e.getMessage());
            }
            try {
                audioRecord.release();
            } catch (Exception e2) {
                Log.w(TAG, "recorderRelease: " + e2.getMessage());
            }
        }
        this.latestPcm = null;
    }

    boolean isRecording() {
        return this.recording.get();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public String getSource() {
        return this.source;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Bundle poll() {
        Bundle bundle = new Bundle();
        byte[] bArr = this.latestPcm;
        if (bArr == null || bArr.length == 0) {
            bArr = readOnce();
        }
        if (bArr == null || bArr.length == 0) {
            bundle.putBoolean("success", false);
            bundle.putString("error", "no pcm");
            return bundle;
        }
        this.latestPcm = null;
        bundle.putBoolean("success", true);
        bundle.putByteArray("pcm", bArr);
        return bundle;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void readLoop() {
        while (this.recording.get()) {
            byte[] readOnce = readOnce();
            if (readOnce != null && readOnce.length > 0) {
                this.latestPcm = readOnce;
            } else {
                try {
                    Thread.sleep(20L);
                } catch (InterruptedException unused) {
                    Thread.currentThread().interrupt();
                    return;
                }
            }
        }
    }

    private byte[] readOnce() {
        AudioRecord audioRecord = this.recorder;
        if (audioRecord == null || !this.recording.get()) {
            return null;
        }
        int max = Math.max(((this.sampleRate * this.channels) * 200) / 1000, 320);
        byte[] bArr = new byte[max];
        try {
            int read = audioRecord.read(bArr, 0, max);
            if (read <= 0) {
                return null;
            }
            if (read == max) {
                return bArr;
            }
            byte[] bArr2 = new byte[read];
            System.arraycopy(bArr, 0, bArr2, 0, read);
            return bArr2;
        } catch (Exception unused) {
            return null;
        }
    }

    private static int resolveAudioSource(String str) {
        if (isSystemSource(str)) {
            return AUDIO_SOURCE_REMOTE_SUBMIX;
        }
        return 1;
    }

    private static boolean isSystemSource(String str) {
        if (str == null) {
            return false;
        }
        String lowerCase = str.trim().toLowerCase();
        return "system".equals(lowerCase) || "internal".equals(lowerCase) || "remote_submix".equals(lowerCase) || "submix".equals(lowerCase);
    }

    private static String normalizeSource(String str) {
        return isSystemSource(str) ? "system" : "mic";
    }
}
