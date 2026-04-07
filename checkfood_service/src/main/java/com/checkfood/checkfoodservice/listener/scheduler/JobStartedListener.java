package com.checkfood.checkfoodservice.listener.scheduler;

import com.checkfood.checkfoodservice.event.scheduler.JobStartedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * Posluchač doménové události startu scheduler jobu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
public class JobStartedListener {

    /**
     * Zpracuje událost startu jobu.
     *
     * @param event událost s názvem spuštěného jobu
     */
    @EventListener
    public void onJobStarted(JobStartedEvent event) {
        // TODO: log startu jobu, metriky
    }
}
