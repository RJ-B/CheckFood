package com.checkfood.checkfoodservice.exception.business;

/**
 *   Základní výjimka pro porušení
 *   business pravidel aplikace.
 *
 *   Není mapována přímo na HTTP
 *   Zachytává se v GlobalExceptionHandler
 */
public abstract class BusinessException extends RuntimeException {

    protected BusinessException(String message) {
        super(message);
    }
}
