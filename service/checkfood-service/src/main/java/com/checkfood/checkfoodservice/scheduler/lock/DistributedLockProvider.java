package com.checkfood.checkfoodservice.scheduler.lock;

/**
 * Distribuovaný lock provider.
 *
 * Připravený pro:
 * - DB
 * - Redis
 * - Zookeeper
 */
public class DistributedLockProvider implements LockProvider {

    @Override
    public boolean acquireLock(String lockName) {
        // TODO:
        // - distributed locking implementation
        return true;
    }

    @Override
    public void releaseLock(String lockName) {
        // TODO:
    }
}
