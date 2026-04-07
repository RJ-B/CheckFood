package com.checkfood.checkfoodservice.listener.scheduler;

import com.checkfood.checkfoodservice.event.scheduler.JobFailedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * Listener doménové události selhání scheduler jobu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
public class JobFailedListener {

    /**
     * Zpracuje událost selhání jobu.
     *
     * @param event událost s názvem jobu a příčinou selhání
     */
    @EventListener
    public void onJobFailed(JobFailedEvent event) {
        // TODO: audit selhání, error metriky, alerting
    }
}
