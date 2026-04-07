package com.checkfood.checkfoodservice.scheduler.lock;

/**
 * Orchestrace lockování pro scheduler joby.
 * Zajišťuje, že každý job běží v daný čas nejvýše jednou i v clusteru.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class SchedulerLockService {

    private final LockProvider lockProvider;

    /**
     * Vytvoří instanci s injektovaným lock providerem.
     *
     * @param lockProvider implementace distribuovaného zamykání
     */
    public SchedulerLockService(LockProvider lockProvider) {
        this.lockProvider = lockProvider;
    }

    // TODO: executeWithLock(...)
}
