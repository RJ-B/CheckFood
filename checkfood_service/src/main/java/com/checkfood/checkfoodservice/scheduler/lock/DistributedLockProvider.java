package com.checkfood.checkfoodservice.scheduler.lock;

/**
 * Distribuovaný lock provider připravený pro implementaci přes DB, Redis nebo Zookeeper.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class DistributedLockProvider implements LockProvider {

    /**
     * Pokusí se získat distribuovaný zámek se zadaným názvem.
     *
     * @param lockName název zámku
     * @return {@code true} pokud byl zámek úspěšně získán
     */
    @Override
    public boolean acquireLock(String lockName) {
        // TODO: implementace distribuovaného zamykání
        return true;
    }

    /**
     * Uvolní distribuovaný zámek se zadaným názvem.
     *
     * @param lockName název zámku k uvolnění
     */
    @Override
    public void releaseLock(String lockName) {
        // TODO: implementace uvolnění distribuovaného zámku
    }
}
