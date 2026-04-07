package com.checkfood.checkfoodservice.event.scheduler;

import com.checkfood.checkfoodservice.event.base.DomainEvent;
import lombok.Getter;

/**
 * Doménová událost vyvolaná při selhání plánované úlohy.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
public class JobFailedEvent extends DomainEvent {

    private final String jobName;
    private final String reason;

    /**
     * Vytvoří událost selhání jobu.
     *
     * @param jobName název jobu, který selhal
     * @param reason  popis příčiny selhání
     */
    public JobFailedEvent(String jobName, String reason) {
        this.jobName = jobName;
        this.reason = reason;
    }
}
