package com.checkfood.checkfoodservice.module.panorama.exception;

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
 * Globální handler pro výjimky panoramatického modulu s rozlišeným logováním podle závažnosti chyby.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestControllerAdvice
@Component
@Slf4j
public class PanoramaExceptionHandler extends AppExceptionHandler {

    /**
     * Vytvoří handler s potřebným builderem chybových odpovědí.
     *
     * @param errorResponseBuilder builder pro sestavení standardizované chybové odpovědi
     */
    public PanoramaExceptionHandler(ErrorResponseBuilder errorResponseBuilder) {
        super(errorResponseBuilder);
    }

    /**
     * Zpracuje {@link PanoramaException} a vrátí standardizovanou chybovou odpověď.
     * Logování se liší podle typu chyby (error/info/debug).
     *
     * @param ex      zachycená výjimka panoramatického modulu
     * @param request aktuální HTTP požadavek
     * @return odpověď s chybovým kódem a příslušným HTTP statusem
     */
    @ExceptionHandler(PanoramaException.class)
    public ResponseEntity<ErrorResponse> handlePanoramaException(PanoramaException ex, WebRequest request) {
        String uri = extractRequestUri(request);

        if (ex.getErrorCode() instanceof PanoramaErrorCode code) {
            switch (code) {
                case PANORAMA_SYSTEM_ERROR ->
                        log.error("SYSTEM ERROR [Panorama]: {} - URI: {}", ex.getMessage(), uri, ex);
                case SESSION_NOT_FOUND ->
                        log.debug("Panorama session not found: {} - URI: {}", ex.getMessage(), uri);
                case INVALID_SESSION_STATE ->
                        log.info("Invalid panorama session state: {} - URI: {}", ex.getMessage(), uri);
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
