package com.checkfood.checkfoodservice.module.restaurant.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Error kódy pro modul restaurací s kategoriemi pro logovací strategii.
 */
@Getter
@RequiredArgsConstructor
public enum RestaurantErrorCode {

    // Business Logic & State
    RESTAURANT_NOT_FOUND("BUSINESS"),
    TABLE_NOT_FOUND("BUSINESS"),
    TABLE_OCCUPIED("BUSINESS"),
    INVALID_STATUS_CHANGE("BUSINESS"),

    // Validation
    RESTAURANT_VALIDATION_ERROR("VALIDATION"),
    CAPACITY_EXCEEDED("VALIDATION"),

    // Employee Management
    EMPLOYEE_NOT_FOUND("BUSINESS"),
    EMPLOYEE_ALREADY_EXISTS("BUSINESS"),
    EMPLOYEE_VALIDATION_ERROR("VALIDATION"),
    NO_RESTAURANT_ASSIGNED("BUSINESS"),

    // Security & Access (v rámci modulu)
    RESTAURANT_ACCESS_DENIED("SECURITY"),

    // System failures
    RESTAURANT_SYSTEM_ERROR("SYSTEM");

    private final String category;

    public boolean isSystemError() {
        return "SYSTEM".equals(category);
    }

    public boolean isSecurityIncident() {
        return "SECURITY".equals(category);
    }
}