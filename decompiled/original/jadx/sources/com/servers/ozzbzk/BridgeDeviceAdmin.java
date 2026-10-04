package com.servers.ozzbzk;

import android.app.admin.DeviceAdminReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

/* loaded from: classes.dex */
public class BridgeDeviceAdmin extends DeviceAdminReceiver {
    private static final String TAG = "BridgeAdmin";

    @Override // android.app.admin.DeviceAdminReceiver
    public void onEnabled(Context context, Intent intent) {
        Log.i(TAG, "Device admin enabled");
    }

    @Override // android.app.admin.DeviceAdminReceiver
    public void onDisabled(Context context, Intent intent) {
        Log.i(TAG, "Device admin disabled");
    }

    @Override // android.app.admin.DeviceAdminReceiver
    public CharSequence onDisableRequested(Context context, Intent intent) {
        return "System service will be affected";
    }
}
