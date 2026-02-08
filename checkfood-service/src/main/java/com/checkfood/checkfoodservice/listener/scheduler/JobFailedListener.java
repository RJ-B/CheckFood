package com.checkfood.checkfoodservice.listener.scheduler;

import com.checkfood.checkfoodservice.event.scheduler.JobFailedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * Reaguje na selhání scheduler jobu.
 */
@Component
public class JobFailedListener {

    @EventListener
    public void onJobFailed(JobFailedEvent event) {

        // TODO:
        // - audit selhání
        // - error metriky
        // - alerting (do budoucna)
    }
}
