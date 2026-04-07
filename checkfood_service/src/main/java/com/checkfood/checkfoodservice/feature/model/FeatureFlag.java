package com.checkfood.checkfoodservice.feature.model;

/**
 * Výčet všech feature flagů v systému.
 * Slouží jako centrální přehled dostupných funkcionalit a ochrana proti magic stringům.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum FeatureFlag {

    USER_REGISTRATION,
    ORDER_CREATION,
    PAYMENT_PROCESSING,
    AUDIT_ENABLED,
    CACHE_ENABLED
}
