package com.checkfood.checkfoodservice.event.application;

import com.checkfood.checkfoodservice.event.base.DomainEvent;

/**
 * Doménová událost vyvolaná po úspěšném vytvoření objednávky.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class OrderCreatedEvent extends DomainEvent {

    private final Long orderId;
    private final Long userId;

    /**
     * Vytvoří událost vytvoření objednávky.
     *
     * @param orderId identifikátor nové objednávky
     * @param userId  identifikátor uživatele, který objednávku vytvořil
     */
    public OrderCreatedEvent(Long orderId, Long userId) {
        this.orderId = orderId;
        this.userId = userId;
    }

    /**
     * Vrátí identifikátor objednávky.
     *
     * @return ID objednávky
     */
    public Long getOrderId() {
        return orderId;
    }

    /**
     * Vrátí identifikátor uživatele.
     *
     * @return ID uživatele
     */
    public Long getUserId() {
        return userId;
    }
}
