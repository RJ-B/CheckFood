package com.checkfood.checkfoodservice.event.scheduler;

import com.checkfood.checkfoodservice.event.base.DomainEvent;

/**
 * Doménová událost vyvolaná při startu plánované úlohy.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class JobStartedEvent extends DomainEvent {

    private final String jobName;

    /**
     * Vytvoří událost startu jobu.
     *
     * @param jobName název spuštěného jobu
     */
    public JobStartedEvent(String jobName) {
        this.jobName = jobName;
    }

    /**
     * Vrátí název spuštěného jobu.
     *
     * @return název jobu
     */
    public String getJobName() {
        return jobName;
    }
}
