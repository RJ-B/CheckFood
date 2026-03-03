package com.checkfood.checkfoodservice.module.panorama.exception;

import com.checkfood.checkfoodservice.module.exception.AppException;
import org.springframework.http.HttpStatus;

import java.util.UUID;

public class PanoramaException extends AppException {

    public PanoramaException(PanoramaErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    public static PanoramaException sessionNotFound(UUID id) {
        return new PanoramaException(
                PanoramaErrorCode.SESSION_NOT_FOUND,
                "Panorama session s ID " + id + " nebyla nalezena.",
                HttpStatus.NOT_FOUND
        );
    }

    public static PanoramaException invalidState(String message) {
        return new PanoramaException(
                PanoramaErrorCode.INVALID_SESSION_STATE,
                message,
                HttpStatus.BAD_REQUEST
        );
    }

    public static PanoramaException systemError(String message) {
        return new PanoramaException(
                PanoramaErrorCode.PANORAMA_SYSTEM_ERROR,
                "Interní chyba modulu panorama: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }
}
