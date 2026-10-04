package com.servers.ozzbzk;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.util.Log;

/* loaded from: classes.dex */
public class BootReceiver extends BroadcastReceiver {
    private static final String TAG = "BootReceiver";

    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        if (intent == null) {
            return;
        }
        String action = intent.getAction();
        if ("android.intent.action.BOOT_COMPLETED".equals(action) || "android.intent.action.QUICKBOOT_POWERON".equals(action) || "com.htc.intent.action.QUICKBOOT_POWERON".equals(action)) {
            try {
                Intent intent2 = new Intent(context, (Class<?>) BridgeService.class);
                if (Build.VERSION.SDK_INT >= 26) {
                    context.startForegroundService(intent2);
                } else {
                    context.startService(intent2);
                }
                Log.i(TAG, "BridgeService started on boot");
            } catch (Exception e) {
                Log.w(TAG, "failed to start BridgeService: " + e.getMessage());
            }
        }
    }
}
