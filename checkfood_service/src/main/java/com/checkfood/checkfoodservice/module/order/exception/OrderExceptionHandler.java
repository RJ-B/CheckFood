package com.checkfood.checkfoodservice.module.order.exception;

import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;
import com.checkfood.checkfoodservice.module.exception.AppExceptionHandler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

/**
 * Globální handler výjimek pro modul objednávek — loguje a převádí {@link OrderException} na HTTP odpověď.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestControllerAdvice
@Component
@Slf4j
public class OrderExceptionHandler extends AppExceptionHandler {

    /**
     * Vytvoří handler s injektovaným builderem chybových odpovědí.
     *
     * @param errorResponseBuilder builder pro sestavení standardizované chybové odpovědi
     */
    public OrderExceptionHandler(ErrorResponseBuilder errorResponseBuilder) {
        super(errorResponseBuilder);
    }

    /**
     * Zpracuje {@link OrderException} — zaloguje ji dle závažnosti a vrátí standardizovanou chybovou odpověď.
     *
     * @param ex      zachycená výjimka objednávky
     * @param request aktuální webový požadavek
     * @return HTTP odpověď s chybovým tělem
     */
    @ExceptionHandler(OrderException.class)
    public ResponseEntity<ErrorResponse> handleOrderException(OrderException ex, WebRequest request) {
        String uri = extractRequestUri(request);

        if (ex.getErrorCode() instanceof OrderErrorCode code) {
            switch (code) {
                case ORDER_SYSTEM_ERROR ->
                    log.error("SYSTEM ERROR [Order]: {} - URI: {}", ex.getMessage(), uri, ex);
                case PAYMENT_INITIATION_FAILED ->
                    log.error("Payment initiation failed: {} - URI: {}", ex.getMessage(), uri);
                case ORDER_NOT_FOUND ->
                    log.debug("Order not found: {} - URI: {}", ex.getMessage(), uri);
                case NO_DINING_CONTEXT ->
                    log.debug("No dining context for order: {} - URI: {}", ex.getMessage(), uri);
                case ORDER_NOT_OWNED ->
                    log.warn("Unauthorized order access: {} - URI: {}", ex.getMessage(), uri);
                case PAYMENT_NOT_ALLOWED ->
                    log.info("Payment not allowed: {} - URI: {}", ex.getMessage(), uri);
                case ITEM_NOT_FOUND, ITEM_UNAVAILABLE, ITEM_WRONG_RESTAURANT, EMPTY_ORDER ->
                    log.info("Order validation failed: {} - URI: {}", ex.getMessage(), uri);
            }
        }

        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus());

        return new ResponseEntity<>(response, ex.getStatus());
    }
}
