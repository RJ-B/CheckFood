package com.checkfood.checkfoodservice.exception.handler;

import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * Centrální zpracování výjimek v REST API.
 *
 * Zajišťuje:
 * - mapování výjimek na HTTP odpovědi
 * - jednotný formát chyb
 * - logování chyb
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    // TODO:
    // - @ExceptionHandler(ApiException.class)
    // - @ExceptionHandler(BusinessException.class)
    // - @ExceptionHandler(Exception.class)
}
