package com.checkfood.checkfoodservice.module.exception;

import com.checkfood.checkfoodservice.exception.ServiceException;
import lombok.Getter;
import org.springframework.http.HttpStatus;

/**
 * Základní výjimka pro všechny byznys moduly v rámci balíčku 'module'.
 */
@Getter
public abstract class AppException extends ServiceException {

    public AppException(Object errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    public AppException(Object errorCode, String message, HttpStatus status, Throwable cause) {
        super(errorCode, message, status, cause);
    }
}