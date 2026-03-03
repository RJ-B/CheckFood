package com.checkfood.checkfoodservice.module.order.exception;

import com.checkfood.checkfoodservice.module.exception.AppException;
import org.springframework.http.HttpStatus;

import java.util.UUID;

public class OrderException extends AppException {

    public OrderException(OrderErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    public static OrderException notFound(UUID id) {
        return new OrderException(
                OrderErrorCode.ORDER_NOT_FOUND,
                "Objednávka s ID " + id + " nebyla nalezena.",
                HttpStatus.NOT_FOUND);
    }

    public static OrderException noDiningContext() {
        return new OrderException(
                OrderErrorCode.NO_DINING_CONTEXT,
                "Nemáte aktivní sezení u stolu. Nelze vytvořit objednávku.",
                HttpStatus.NOT_FOUND);
    }

    public static OrderException itemNotFound(UUID menuItemId) {
        return new OrderException(
                OrderErrorCode.ITEM_NOT_FOUND,
                "Položka menu s ID " + menuItemId + " nebyla nalezena.",
                HttpStatus.NOT_FOUND);
    }

    public static OrderException itemUnavailable(String name) {
        return new OrderException(
                OrderErrorCode.ITEM_UNAVAILABLE,
                "Položka '" + name + "' není momentálně dostupná.",
                HttpStatus.CONFLICT);
    }

    public static OrderException itemWrongRestaurant(UUID menuItemId) {
        return new OrderException(
                OrderErrorCode.ITEM_WRONG_RESTAURANT,
                "Položka " + menuItemId + " nepatří k restauraci vašeho sezení.",
                HttpStatus.CONFLICT);
    }

    public static OrderException emptyOrder() {
        return new OrderException(
                OrderErrorCode.EMPTY_ORDER,
                "Objednávka musí obsahovat alespoň jednu položku.",
                HttpStatus.BAD_REQUEST);
    }

    public static OrderException systemError(String message) {
        return new OrderException(
                OrderErrorCode.ORDER_SYSTEM_ERROR,
                "Interní chyba modulu objednávek: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
