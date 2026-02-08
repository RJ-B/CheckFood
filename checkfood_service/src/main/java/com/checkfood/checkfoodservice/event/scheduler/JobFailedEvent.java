package com.checkfood.checkfoodservice.event.scheduler;

import com.checkfood.checkfoodservice.event.base.DomainEvent;
import lombok.Getter;

/**
 * Událost vyvolaná při selhání plánované úlohy.
 */
@Getter
public class JobFailedEvent extends DomainEvent {

    private final String jobName;
    private final String reason;

    public JobFailedEvent(String jobName, String reason) {
        this.jobName = jobName;
        this.reason = reason;
    }

}
