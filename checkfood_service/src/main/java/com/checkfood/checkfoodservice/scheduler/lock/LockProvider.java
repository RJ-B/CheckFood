package com.checkfood.checkfoodservice.scheduler.lock;

/**
 * Abstrakce nad mechanizmem zamykání pro zabránění paralelního běhu jobů v distribuovaném prostředí.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface LockProvider {

    /**
     * Pokusí se získat zámek se zadaným názvem.
     *
     * @param lockName název zámku
     * @return {@code true} pokud byl zámek úspěšně získán
     */
    boolean acquireLock(String lockName);

    /**
     * Uvolní dříve získaný zámek.
     *
     * @param lockName název zámku k uvolnění
     */
    void releaseLock(String lockName);
}
