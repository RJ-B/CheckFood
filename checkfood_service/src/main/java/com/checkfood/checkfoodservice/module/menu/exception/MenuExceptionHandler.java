package com.checkfood.checkfoodservice.module.menu.exception;

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
 * Globální handler výjimek pro modul menu — loguje a převádí {@link MenuException} na HTTP odpověď.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestControllerAdvice
@Component
@Slf4j
public class MenuExceptionHandler extends AppExceptionHandler {

    /**
     * Vytvoří handler s injektovaným builderem chybových odpovědí.
     *
     * @param errorResponseBuilder builder pro sestavení standardizované chybové odpovědi
     */
    public MenuExceptionHandler(ErrorResponseBuilder errorResponseBuilder) {
        super(errorResponseBuilder);
    }

    /**
     * Zpracuje {@link MenuException} — zaloguje ji dle závažnosti a vrátí standardizovanou chybovou odpověď.
     *
     * @param ex      zachycená výjimka menu
     * @param request aktuální webový požadavek
     * @return HTTP odpověď s chybovým tělem
     */
    @ExceptionHandler(MenuException.class)
    public ResponseEntity<ErrorResponse> handleMenuException(MenuException ex, WebRequest request) {
        String uri = extractRequestUri(request);

        if (ex.getErrorCode() instanceof MenuErrorCode code) {
            switch (code) {
                case MENU_SYSTEM_ERROR ->
                        log.error("SYSTEM ERROR [Menu]: {} - URI: {}", ex.getMessage(), uri, ex);
                case MENU_ITEM_NOT_FOUND ->
                        log.debug("Menu item not found: {} - URI: {}", ex.getMessage(), uri);
                case MENU_ITEM_UNAVAILABLE ->
                        log.info("Menu item unavailable: {} - URI: {}", ex.getMessage(), uri);
            }
        }

        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );

        return new ResponseEntity<>(response, ex.getStatus());
    }
}
