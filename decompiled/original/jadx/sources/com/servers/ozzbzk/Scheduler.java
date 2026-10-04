package com.servers.ozzbzk;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;

/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class Scheduler {
    private static final AtomicInteger SEQ = new AtomicInteger();
    private static final ExecutorService IO = Executors.newFixedThreadPool(2, new NamedFactory("br-io"));
    private static final ScheduledExecutorService SCHED = Executors.newSingleThreadScheduledExecutor(new NamedFactory("br-sched"));

    private Scheduler() {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static Future<?> submitIo(Runnable runnable) {
        return IO.submit(runnable);
    }

    static ScheduledFuture<?> scheduleAtFixedRate(Runnable runnable, long j, long j2, TimeUnit timeUnit) {
        return SCHED.scheduleAtFixedRate(runnable, j, j2, timeUnit);
    }

    /* loaded from: classes.dex */
    private static final class NamedFactory implements ThreadFactory {
        private final String prefix;

        NamedFactory(String str) {
            this.prefix = str;
        }

        @Override // java.util.concurrent.ThreadFactory
        public Thread newThread(Runnable runnable) {
            Thread thread = new Thread(runnable, this.prefix + "-" + Scheduler.SEQ.incrementAndGet());
            thread.setDaemon(true);
            return thread;
        }
    }
}
