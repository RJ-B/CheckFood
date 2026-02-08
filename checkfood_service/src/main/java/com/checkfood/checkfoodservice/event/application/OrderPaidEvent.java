package com.checkfood.checkfoodservice.event.application;

import com.checkfood.checkfoodservice.event.base.DomainEvent;

/**
 * Událost vyvolaná po úspěšné platbě objednávky.
 */
public class OrderPaidEvent extends DomainEvent {

    private final Long orderId;
    private final String paymentProvider;

    public OrderPaidEvent(Long orderId, String paymentProvider) {
        this.orderId = orderId;
        this.paymentProvider = paymentProvider;
    }

    public Long getOrderId() {
        return orderId;
    }

    public String getPaymentProvider() {
        return paymentProvider;
    }
}
