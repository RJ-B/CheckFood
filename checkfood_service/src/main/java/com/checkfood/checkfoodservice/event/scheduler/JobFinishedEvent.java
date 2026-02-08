package com.checkfood.checkfoodservice.event.scheduler;

import com.checkfood.checkfoodservice.event.base.DomainEvent;

/**
 * Událost vyvolaná po úspěšném dokončení jobu.
 */
public class JobFinishedEvent extends DomainEvent {

    private final String jobName;

    public JobFinishedEvent(String jobName) {
        this.jobName = jobName;
    }

    public String getJobName() {
        return jobName;
    }
}
