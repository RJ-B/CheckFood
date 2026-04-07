package com.checkfood.checkfoodservice.module.restaurant.menu.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Chybové kódy specifické pro modul menu, kategorizované dle původu chyby (BUSINESS, SYSTEM).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@RequiredArgsConstructor
public enum MenuErrorCode {

    MENU_CATEGORY_NOT_FOUND("BUSINESS"),
    MENU_ITEM_NOT_FOUND("BUSINESS"),
    MENU_ITEM_UNAVAILABLE("BUSINESS"),
    MENU_SYSTEM_ERROR("SYSTEM");

    private final String category;
}
