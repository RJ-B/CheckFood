package com.checkfood.checkfoodservice.module.order.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum OrderErrorCode {

    ORDER_NOT_FOUND("BUSINESS"),
    NO_DINING_CONTEXT("BUSINESS"),
    ITEM_NOT_FOUND("VALIDATION"),
    ITEM_UNAVAILABLE("VALIDATION"),
    ITEM_WRONG_RESTAURANT("VALIDATION"),
    EMPTY_ORDER("VALIDATION"),
    ORDER_SYSTEM_ERROR("SYSTEM");

    private final String category;
}
