package com.checkfood.checkfoodservice.monitoring.metrics;

/**
 * Centrální definice názvů metrik zabraňující používání magic stringů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public final class MetricNames {

    private MetricNames() {}

    public static final String ORDER_CREATED = "orders.created";
    public static final String PAYMENT_SUCCESS = "payments.success";
    public static final String PAYMENT_FAILED = "payments.failed";
}
