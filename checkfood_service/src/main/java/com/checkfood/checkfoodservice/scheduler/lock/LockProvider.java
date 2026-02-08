package com.checkfood.checkfoodservice.scheduler.lock;

/**
 * Abstrakce nad mechanizmem zamykání.
 *
 * Slouží k:
 * - zabránění paralelního běhu jobů
 * - podpoře distribuovaného prostředí
 */
public interface LockProvider {

    boolean acquireLock(String lockName);

    void releaseLock(String lockName);
}
