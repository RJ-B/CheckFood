package com.checkfood.checkfoodservice.event.application;

import com.checkfood.checkfoodservice.event.base.DomainEvent;

/**
 * Událost vyvolaná po vytvoření objednávky.
 */
public class OrderCreatedEvent extends DomainEvent {

    private final Long orderId;
    private final Long userId;

    public OrderCreatedEvent(Long orderId, Long userId) {
        this.orderId = orderId;
        this.userId = userId;
    }

    public Long getOrderId() {
        return orderId;
    }

    public Long getUserId() {
        return userId;
    }
}
