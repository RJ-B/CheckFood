package com.checkfood.checkfoodservice.event.scheduler;

import com.checkfood.checkfoodservice.event.base.DomainEvent;

/**
 * Událost vyvolaná při startu plánované úlohy.
 */
public class JobStartedEvent extends DomainEvent {

    private final String jobName;

    public JobStartedEvent(String jobName) {
        this.jobName = jobName;
    }

    public String getJobName() {
        return jobName;
    }
}
