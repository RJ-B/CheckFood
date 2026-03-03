package com.checkfood.checkfoodservice.module.dining.exception;

import com.checkfood.checkfoodservice.module.exception.AppException;
import org.springframework.http.HttpStatus;

public class DiningContextException extends AppException {

    public DiningContextException(DiningContextErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    public static DiningContextException noActiveContext() {
        return new DiningContextException(
                DiningContextErrorCode.NO_ACTIVE_CONTEXT,
                "Nemáte aktivní rezervaci ani sezení u stolu.",
                HttpStatus.NOT_FOUND
        );
    }

    public static DiningContextException contextMismatch() {
        return new DiningContextException(
                DiningContextErrorCode.CONTEXT_MISMATCH,
                "Objednávka neodpovídá vašemu aktuálnímu sezení.",
                HttpStatus.CONFLICT
        );
    }

    public static DiningContextException systemError(String message) {
        return new DiningContextException(
                DiningContextErrorCode.DINING_SYSTEM_ERROR,
                "Interní chyba modulu sezení: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }
}
