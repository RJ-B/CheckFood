package com.checkfood.checkfoodservice.module.order.entity;

/**
 * Stavy životního cyklu objednávky od vytvoření po doručení nebo zrušení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum OrderStatus {
    PENDING,
    CONFIRMED,
    PREPARING,
    READY,
    DELIVERED,
    CANCELLED
}
