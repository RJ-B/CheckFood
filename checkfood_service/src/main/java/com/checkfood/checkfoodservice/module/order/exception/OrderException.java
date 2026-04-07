package com.checkfood.checkfoodservice.module.order.exception;

import com.checkfood.checkfoodservice.module.exception.AppException;
import org.springframework.http.HttpStatus;

import java.util.UUID;

/**
 * Výjimka modulu objednávek poskytující tovární metody pro typické chybové scénáře.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class OrderException extends AppException {

    /**
     * Vytvoří novou výjimku objednávky s daným chybovým kódem, zprávou a HTTP statusem.
     *
     * @param errorCode chybový kód z {@link OrderErrorCode}
     * @param message   lidsky čitelná chybová zpráva
     * @param status    HTTP status odpovědi
     */
    public OrderException(OrderErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * Vytvoří výjimku pro nenalezenou objednávku.
     *
     * @param id UUID nenalezené objednávky
     * @return výjimka s HTTP 404
     */
    public static OrderException notFound(UUID id) {
        return new OrderException(
                OrderErrorCode.ORDER_NOT_FOUND,
                "Objednávka s ID " + id + " nebyla nalezena.",
                HttpStatus.NOT_FOUND);
    }

    /**
     * Vytvoří výjimku pro případ, kdy uživatel nemá aktivní sezení u stolu.
     *
     * @return výjimka s HTTP 404
     */
    public static OrderException noDiningContext() {
        return new OrderException(
                OrderErrorCode.NO_DINING_CONTEXT,
                "Nemáte aktivní sezení u stolu. Nelze vytvořit objednávku.",
                HttpStatus.NOT_FOUND);
    }

    /**
     * Vytvoří výjimku pro nenalezenou položku menu.
     *
     * @param menuItemId UUID nenalezené položky menu
     * @return výjimka s HTTP 404
     */
    public static OrderException itemNotFound(UUID menuItemId) {
        return new OrderException(
                OrderErrorCode.ITEM_NOT_FOUND,
                "Položka menu s ID " + menuItemId + " nebyla nalezena.",
                HttpStatus.NOT_FOUND);
    }

    /**
     * Vytvoří výjimku pro nedostupnou položku menu.
     *
     * @param name název nedostupné položky menu
     * @return výjimka s HTTP 409
     */
    public static OrderException itemUnavailable(String name) {
        return new OrderException(
                OrderErrorCode.ITEM_UNAVAILABLE,
                "Položka '" + name + "' není momentálně dostupná.",
                HttpStatus.CONFLICT);
    }

    /**
     * Vytvoří výjimku pro položku menu patřící jiné restauraci, než ke které má uživatel sezení.
     *
     * @param menuItemId UUID nepatřičné položky menu
     * @return výjimka s HTTP 409
     */
    public static OrderException itemWrongRestaurant(UUID menuItemId) {
        return new OrderException(
                OrderErrorCode.ITEM_WRONG_RESTAURANT,
                "Položka " + menuItemId + " nepatří k restauraci vašeho sezení.",
                HttpStatus.CONFLICT);
    }

    /**
     * Vytvoří výjimku pro prázdnou objednávku bez položek.
     *
     * @return výjimka s HTTP 400
     */
    public static OrderException emptyOrder() {
        return new OrderException(
                OrderErrorCode.EMPTY_ORDER,
                "Objednávka musí obsahovat alespoň jednu položku.",
                HttpStatus.BAD_REQUEST);
    }

    /**
     * Vytvoří výjimku pro systémovou chybu modulu objednávek.
     *
     * @param message popis systémové chyby
     * @return výjimka s HTTP 500
     */
    public static OrderException systemError(String message) {
        return new OrderException(
                OrderErrorCode.ORDER_SYSTEM_ERROR,
                "Interní chyba modulu objednávek: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR);
    }

    /**
     * Vytvoří výjimku pro případ, kdy není povolena platba objednávky.
     *
     * @param orderId UUID objednávky
     * @param reason  důvod zamítnutí platby
     * @return výjimka s HTTP 409
     */
    public static OrderException paymentNotAllowed(UUID orderId, String reason) {
        return new OrderException(
                OrderErrorCode.PAYMENT_NOT_ALLOWED,
                "Platbu nelze iniciovat pro objednávku " + orderId + ": " + reason,
                HttpStatus.CONFLICT);
    }

    /**
     * Vytvoří výjimku pro selhání inicializace platby u platební brány.
     *
     * @param reason popis důvodu selhání
     * @return výjimka s HTTP 502
     */
    public static OrderException paymentInitiationFailed(String reason) {
        return new OrderException(
                OrderErrorCode.PAYMENT_INITIATION_FAILED,
                "Inicializace platby selhala: " + reason,
                HttpStatus.BAD_GATEWAY);
    }

    /**
     * Vytvoří výjimku pro pokus o přístup k cizí objednávce.
     *
     * @param orderId UUID objednávky, ke které uživatel nemá přístup
     * @return výjimka s HTTP 403
     */
    public static OrderException notOwned(UUID orderId) {
        return new OrderException(
                OrderErrorCode.ORDER_NOT_OWNED,
                "Objednávka " + orderId + " vám nepatří.",
                HttpStatus.FORBIDDEN);
    }
}
