package com.checkfood.checkfoodservice.module.owner.exception;

import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
@RequiredArgsConstructor
@Slf4j
public class OwnerClaimExceptionHandler {

    private final ErrorResponseBuilder errorResponseBuilder;

    @ExceptionHandler(OwnerClaimException.class)
    public ResponseEntity<ErrorResponse> handleOwnerClaimException(OwnerClaimException ex) {
        var code = ex.getErrorCode();
        log.warn("Owner claim error: {} - {}", code, ex.getMessage());

        ErrorResponse response = errorResponseBuilder.build(
                code,
                ex.getMessage(),
                code.getStatus()
        );

        return new ResponseEntity<>(response, code.getStatus());
    }
}
