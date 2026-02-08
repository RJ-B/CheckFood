package com.checkfood.checkfoodservice.scheduler.lock;

/**
 * Orchestrace lockování pro scheduler joby.
 */
public class SchedulerLockService {

    private final LockProvider lockProvider;

    public SchedulerLockService(LockProvider lockProvider) {
        this.lockProvider = lockProvider;
    }

    // TODO:
    // - executeWithLock(...)
}
