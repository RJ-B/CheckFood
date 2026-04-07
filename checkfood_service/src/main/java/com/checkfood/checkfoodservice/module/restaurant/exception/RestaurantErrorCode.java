package com.checkfood.checkfoodservice.module.restaurant.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Chybové kódy modulu restaurací kategorizované podle logovací strategie.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@RequiredArgsConstructor
public enum RestaurantErrorCode {

    RESTAURANT_NOT_FOUND("BUSINESS"),
    TABLE_NOT_FOUND("BUSINESS"),
    TABLE_OCCUPIED("BUSINESS"),
    INVALID_STATUS_CHANGE("BUSINESS"),
    RESTAURANT_VALIDATION_ERROR("VALIDATION"),
    CAPACITY_EXCEEDED("VALIDATION"),
    EMPLOYEE_NOT_FOUND("BUSINESS"),
    EMPLOYEE_ALREADY_EXISTS("BUSINESS"),
    EMPLOYEE_VALIDATION_ERROR("VALIDATION"),
    NO_RESTAURANT_ASSIGNED("BUSINESS"),
    RESTAURANT_ACCESS_DENIED("SECURITY"),
    EMPLOYEE_PERMISSION_DENIED("SECURITY"),
    RESTAURANT_SYSTEM_ERROR("SYSTEM");

    private final String category;

    /**
     * Indikuje, zda se jedná o systémovou chybu vyžadující error-level logování.
     *
     * @return {@code true} pro kódy kategorie SYSTEM
     */
    public boolean isSystemError() {
        return "SYSTEM".equals(category);
    }

    /**
     * Indikuje, zda se jedná o bezpečnostní incident vyžadující warn-level logování.
     *
     * @return {@code true} pro kódy kategorie SECURITY
     */
    public boolean isSecurityIncident() {
        return "SECURITY".equals(category);
    }
}