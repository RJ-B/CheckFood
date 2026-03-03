package com.checkfood.checkfoodservice.module.menu.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum MenuErrorCode {

    MENU_CATEGORY_NOT_FOUND("BUSINESS"),
    MENU_ITEM_NOT_FOUND("BUSINESS"),
    MENU_ITEM_UNAVAILABLE("BUSINESS"),
    MENU_SYSTEM_ERROR("SYSTEM");

    private final String category;
}
