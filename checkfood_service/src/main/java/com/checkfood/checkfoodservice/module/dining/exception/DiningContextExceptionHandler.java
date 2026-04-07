package com.checkfood.checkfoodservice.module.dining.exception;

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
 * Globální handler výjimek pro modul dining context — loguje a převádí
 * {@link DiningContextException} na standardizovanou HTTP odpověď.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestControllerAdvice
@Component
@Slf4j
public class DiningContextExceptionHandler extends AppExceptionHandler {

    /**
     * Vytvoří handler s injektovaným builderem chybových odpovědí.
     *
     * @param errorResponseBuilder builder pro sestavení standardizované chybové odpovědi
     */
    public DiningContextExceptionHandler(ErrorResponseBuilder errorResponseBuilder) {
        super(errorResponseBuilder);
    }

    /**
     * Zpracuje {@link DiningContextException} — zaloguje ji dle závažnosti a vrátí chybovou odpověď.
     *
     * @param ex      zachycená výjimka dining context
     * @param request aktuální webový požadavek
     * @return HTTP odpověď s chybovým tělem
     */
    @ExceptionHandler(DiningContextException.class)
    public ResponseEntity<ErrorResponse> handleDiningContextException(
            DiningContextException ex, WebRequest request) {
        String uri = extractRequestUri(request);

        if (ex.getErrorCode() instanceof DiningContextErrorCode code) {
            switch (code) {
                case DINING_SYSTEM_ERROR ->
                        log.error("SYSTEM ERROR [DiningContext]: {} - URI: {}", ex.getMessage(), uri, ex);
                case NO_ACTIVE_CONTEXT ->
                        log.debug("No active dining context: {} - URI: {}", ex.getMessage(), uri);
                case CONTEXT_MISMATCH ->
                        log.warn("Dining context mismatch: {} - URI: {}", ex.getMessage(), uri);
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
