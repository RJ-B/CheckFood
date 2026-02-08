package com.checkfood.checkfoodservice.listener.application;

import com.checkfood.checkfoodservice.event.application.OrderCreatedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * Reaguje na vytvoření objednávky.
 */
@Component
public class OrderCreatedListener {

    @EventListener
    public void onOrderCreated(OrderCreatedEvent event) {

        // TODO:
        // - audit vytvoření objednávky
        // - invalidace cache objednávek
        // - business metriky
    }
}
