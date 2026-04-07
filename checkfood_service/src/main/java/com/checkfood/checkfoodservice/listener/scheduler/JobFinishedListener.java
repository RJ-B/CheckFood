package com.checkfood.checkfoodservice.listener.scheduler;

import com.checkfood.checkfoodservice.event.scheduler.JobFinishedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * Listener doménové události úspěšného dokončení scheduler jobu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
public class JobFinishedListener {

    /**
     * Zpracuje událost dokončení jobu.
     *
     * @param event událost s názvem dokončeného jobu
     */
    @EventListener
    public void onJobFinished(JobFinishedEvent event) {
        // TODO: log dokončení, audit běhu jobu
    }
}
