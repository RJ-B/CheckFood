package com.checkfood.checkfoodservice.event.scheduler;

import com.checkfood.checkfoodservice.event.base.DomainEvent;

/**
 * Doménová událost vyvolaná po úspěšném dokončení plánované úlohy.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class JobFinishedEvent extends DomainEvent {

    private final String jobName;

    /**
     * Vytvoří událost dokončení jobu.
     *
     * @param jobName název dokončeného jobu
     */
    public JobFinishedEvent(String jobName) {
        this.jobName = jobName;
    }

    /**
     * Vrátí název dokončeného jobu.
     *
     * @return název jobu
     */
    public String getJobName() {
        return jobName;
    }
}
