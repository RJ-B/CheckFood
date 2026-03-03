package com.checkfood.checkfoodservice.module.menu.exception;

import com.checkfood.checkfoodservice.module.exception.AppException;
import org.springframework.http.HttpStatus;

import java.util.UUID;

public class MenuException extends AppException {

    public MenuException(MenuErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    public static MenuException categoryNotFound(UUID id) {
        return new MenuException(
                MenuErrorCode.MENU_CATEGORY_NOT_FOUND,
                "Kategorie menu s ID " + id + " nebyla nalezena.",
                HttpStatus.NOT_FOUND
        );
    }

    public static MenuException itemNotFound(UUID id) {
        return new MenuException(
                MenuErrorCode.MENU_ITEM_NOT_FOUND,
                "Položka menu s ID " + id + " nebyla nalezena.",
                HttpStatus.NOT_FOUND
        );
    }

    public static MenuException itemUnavailable(String name) {
        return new MenuException(
                MenuErrorCode.MENU_ITEM_UNAVAILABLE,
                "Položka menu '" + name + "' není momentálně dostupná.",
                HttpStatus.CONFLICT
        );
    }

    public static MenuException systemError(String message) {
        return new MenuException(
                MenuErrorCode.MENU_SYSTEM_ERROR,
                "Interní chyba modulu menu: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }
}
