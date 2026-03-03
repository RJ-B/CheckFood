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

@RestControllerAdvice
@Component
@Slf4j
public class DiningContextExceptionHandler extends AppExceptionHandler {

    public DiningContextExceptionHandler(ErrorResponseBuilder errorResponseBuilder) {
        super(errorResponseBuilder);
    }

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
