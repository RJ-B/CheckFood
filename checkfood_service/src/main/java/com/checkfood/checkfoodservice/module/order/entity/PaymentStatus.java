package com.checkfood.checkfoodservice.module.order.entity;

/**
 * Stavy platby objednávky v průběhu zpracování platební brány.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum PaymentStatus {
    NONE,
    INITIATED,
    PROCESSING,
    PAID,
    FAILED,
    CANCELLED
}
