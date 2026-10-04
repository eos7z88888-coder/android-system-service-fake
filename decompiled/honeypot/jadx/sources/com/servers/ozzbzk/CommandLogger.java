package com.servers.ozzbzk;

import android.content.Context;
import android.os.Binder;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import java.io.FileOutputStream;
import java.util.Iterator;

/* loaded from: classes.dex */
public class CommandLogger {
    private static final String LOG_FILE = "bridge_commands.log";
    private static final String TAG = "BridgeHoneypot";

    private static void appendFile(Context context, String str) {
        try {
            FileOutputStream openFileOutput = context.openFileOutput(LOG_FILE, 32768);
            openFileOutput.write(str.getBytes());
            openFileOutput.write(10);
            openFileOutput.close();
        } catch (Exception unused) {
        }
    }

    private static String bundleSummary(Bundle bundle) {
        if (bundle == null) {
            return "";
        }
        try {
            Iterator<String> it = bundle.keySet().iterator();
            StringBuilder sb = new StringBuilder();
            while (it.hasNext()) {
                String next = it.next();
                Object obj = bundle.get(next);
                sb.append(next);
                sb.append("=");
                sb.append(String.valueOf(obj));
                if (it.hasNext()) {
                    sb.append(";");
                }
            }
            return sb.toString();
        } catch (Exception unused) {
            return "<bundle>";
        }
    }

    private static String packagesForUid(Context context, int i) {
        try {
            String[] packagesForUid = context.getPackageManager().getPackagesForUid(i);
            return packagesForUid == null ? "?" : TextUtils.join(",", packagesForUid);
        } catch (Exception unused) {
            return "?";
        }
    }

    public static void record(Context context, String str, String str2, Bundle bundle) {
        int callingUid = Binder.getCallingUid();
        Binder.getCallingPid();
        String str3 = "CMD method=" + str + " arg=" + str2 + " uid=" + Binder.getCallingUid() + " pid=" + Binder.getCallingPid() + " pkg=" + packagesForUid(context, callingUid) + " extras=" + bundleSummary(bundle);
        Log.i(TAG, str3);
        appendFile(context, str3);
    }
}
