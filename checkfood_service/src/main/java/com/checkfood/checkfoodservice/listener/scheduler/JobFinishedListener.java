package com.checkfood.checkfoodservice.listener.scheduler;

import com.checkfood.checkfoodservice.event.scheduler.JobFinishedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * Reaguje na úspěšné dokončení jobu.
 */
@Component
public class JobFinishedListener {

    @EventListener
    public void onJobFinished(JobFinishedEvent event) {

        // TODO:
        // - log dokončení
        // - audit běhu jobu
    }
}
