package com.checkfood.checkfoodservice.listener.application;

import com.checkfood.checkfoodservice.event.application.OrderCreatedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * Posluchač doménové události vytvoření objednávky.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
public class OrderCreatedListener {

    /**
     * Zpracuje událost vytvoření objednávky.
     *
     * @param event událost s daty nové objednávky
     */
    @EventListener
    public void onOrderCreated(OrderCreatedEvent event) {
        // TODO: audit vytvoření objednávky, invalidace cache, business metriky
    }
}
