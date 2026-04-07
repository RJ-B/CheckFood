package com.checkfood.checkfoodservice.module.menu.exception;

import com.checkfood.checkfoodservice.module.exception.AppException;
import org.springframework.http.HttpStatus;

import java.util.UUID;

/**
 * Výjimka modulu menu poskytující tovární metody pro typické chybové scénáře práce s menu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class MenuException extends AppException {

    /**
     * Vytvoří novou výjimku menu s daným chybovým kódem, zprávou a HTTP statusem.
     *
     * @param errorCode chybový kód z {@link MenuErrorCode}
     * @param message   lidsky čitelná chybová zpráva
     * @param status    HTTP status odpovědi
     */
    public MenuException(MenuErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * Vytvoří výjimku pro nenalezenou kategorii menu.
     *
     * @param id UUID nenalezené kategorie
     * @return výjimka s HTTP 404
     */
    public static MenuException categoryNotFound(UUID id) {
        return new MenuException(
                MenuErrorCode.MENU_CATEGORY_NOT_FOUND,
                "Kategorie menu s ID " + id + " nebyla nalezena.",
                HttpStatus.NOT_FOUND
        );
    }

    /**
     * Vytvoří výjimku pro nenalezenou položku menu.
     *
     * @param id UUID nenalezené položky menu
     * @return výjimka s HTTP 404
     */
    public static MenuException itemNotFound(UUID id) {
        return new MenuException(
                MenuErrorCode.MENU_ITEM_NOT_FOUND,
                "Položka menu s ID " + id + " nebyla nalezena.",
                HttpStatus.NOT_FOUND
        );
    }

    /**
     * Vytvoří výjimku pro nedostupnou položku menu.
     *
     * @param name název nedostupné položky menu
     * @return výjimka s HTTP 409
     */
    public static MenuException itemUnavailable(String name) {
        return new MenuException(
                MenuErrorCode.MENU_ITEM_UNAVAILABLE,
                "Položka menu '" + name + "' není momentálně dostupná.",
                HttpStatus.CONFLICT
        );
    }

    /**
     * Vytvoří výjimku pro systémovou chybu modulu menu.
     *
     * @param message popis systémové chyby
     * @return výjimka s HTTP 500
     */
    public static MenuException systemError(String message) {
        return new MenuException(
                MenuErrorCode.MENU_SYSTEM_ERROR,
                "Interní chyba modulu menu: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }
}
