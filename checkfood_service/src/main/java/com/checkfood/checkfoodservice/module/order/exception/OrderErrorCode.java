package com.checkfood.checkfoodservice.module.order.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Chybové kódy specifické pro modul objednávek, kategorizované dle původu chyby (BUSINESS, VALIDATION, SYSTEM).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@RequiredArgsConstructor
public enum OrderErrorCode {

    ORDER_NOT_FOUND("BUSINESS"),
    NO_DINING_CONTEXT("BUSINESS"),
    ITEM_NOT_FOUND("VALIDATION"),
    ITEM_UNAVAILABLE("VALIDATION"),
    ITEM_WRONG_RESTAURANT("VALIDATION"),
    EMPTY_ORDER("VALIDATION"),
    ORDER_SYSTEM_ERROR("SYSTEM"),
    PAYMENT_NOT_ALLOWED("BUSINESS"),
    PAYMENT_INITIATION_FAILED("SYSTEM"),
    ORDER_NOT_OWNED("BUSINESS");

    private final String category;
}
