package com.checkfood.checkfoodservice.feature.model;

/**
 * Výčet všech feature flagů v systému.
 *
 * Slouží jako:
 * - centrální přehled feature
 * - ochrana proti "magic stringům"
 */
public enum FeatureFlag {

    USER_REGISTRATION,
    ORDER_CREATION,
    PAYMENT_PROCESSING,
    AUDIT_ENABLED,
    CACHE_ENABLED

}
