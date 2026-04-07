package com.checkfood.checkfoodservice.module.order.entity;

/**
 * Stav platby jednotlivé položky objednávky v rámci sdíleného sezení u stolu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum ItemPaymentStatus {
    UNPAID,
    PAYING,
    PAID
}
