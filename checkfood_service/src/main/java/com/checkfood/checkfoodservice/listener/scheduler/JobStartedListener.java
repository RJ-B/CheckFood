package com.checkfood.checkfoodservice.listener.scheduler;

import com.checkfood.checkfoodservice.event.scheduler.JobStartedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * Reaguje na start scheduler jobu.
 */
@Component
public class JobStartedListener {

    @EventListener
    public void onJobStarted(JobStartedEvent event) {

        // TODO:
        // - log startu jobu
        // - metriky
    }
}
